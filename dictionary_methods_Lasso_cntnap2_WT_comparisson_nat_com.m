load dictionary_methods_Lasso_cntnap2_WT_comparisson_nat_com
for k_dict_elements=1:length(number_extra_elements_to_try)
    number_extra_elements=number_extra_elements_to_try(k_dict_elements);
    for k_lambda=1:3%length(lambda_list)
        for k_repeats=1:repeats_per_presentation
            for k_novel_odors=1:length(variable_backgrounds)
                for k_files_indiv_animals=1:length(files_indiv_animals)
                    logistic_for_correlation(k_novel_odors,k_files_indiv_animals,k_repeats)=animals_logistic_performance_per_odor_novel(k_repeats,k_dict_elements,k_lambda,k_files_indiv_animals,k_novel_odors);
                    lasso_for_correlation(k_novel_odors,k_files_indiv_animals,k_repeats,:)=animals_margin_correct_performance_per_odor(k_repeats,k_dict_elements,k_lambda,k_files_indiv_animals,k_novel_odors,:);
                    cpa_for_correlation(k_novel_odors,k_files_indiv_animals,k_repeats)=animals_margin_correct_performance_per_odor_cpa(k_repeats,k_dict_elements,k_lambda,k_files_indiv_animals,k_novel_odors);
                    nn_for_correlation(k_novel_odors,k_files_indiv_animals,k_repeats)=animals_nn_performance_per_odor(k_repeats,k_dict_elements,k_lambda,k_files_indiv_animals,k_novel_odors);
                    svm_for_correlation(k_novel_odors,k_files_indiv_animals,k_repeats)=animals_svm_performance_per_odor_novel(k_repeats,k_dict_elements,k_lambda,k_files_indiv_animals,k_novel_odors);
                end
            end
            nn=squeeze(nn_for_correlation(:,:,k_repeats));
            lasso_8_repeats=squeeze(lasso_for_correlation(:,:,k_repeats,:));
            [new_odors_used,n_animals_used,n_mixtures_used]=size(lasso_8_repeats);
            lasso=NaN(new_odors_used,n_animals_used);
            for k=1:new_odors_used
                for kk=1:n_animals_used
                    this_group_of_mixtures=squeeze(lasso_8_repeats(k,kk,:));
                    xx=this_group_of_mixtures+randn(size(this_group_of_mixtures))*1e-40;
                    lasso(k,kk)=sum(xx>0)/length(xx);
                end
            end 
            svm=squeeze(svm_for_correlation(:,:,k_repeats));
            logi=squeeze(logistic_for_correlation(:,:,k_repeats));
            

            
            
            
            
            x=corrcoef(nn,lasso);
            nn_lasso(k_dict_elements,k_lambda,k_repeats)=x(2,1);
            x=corrcoef(svm,lasso);
            svm_lasso(k_dict_elements,k_lambda,k_repeats)=x(2,1);
            x=corrcoef(logi,lasso);
            logistic_lasso(k_dict_elements,k_lambda,k_repeats)=x(2,1);
            
            lasso_performance(k_dict_elements,k_lambda,k_repeats)=mean(mean(lasso));%sum(sum(lasso>0))/sum(sum(~isnan(lasso)));
            lasso_performance_per_animal(k_dict_elements,k_lambda,k_repeats,:)=mean(lasso,1);%sum(lasso>0)./sum(~isnan(lasso)); % To plot the performances of the individual animals
            nn_performance(k_repeats)=mean(mean(nn));
            svm_performance(k_repeats)=mean(mean(svm));
            logistic_performance(k_repeats)=mean(mean(logi));
            
            
        end
    end
end


%good_dim=5:14;
good_dim=find(number_extra_elements_to_try>99);
symbols='+so^d'

lasso_performance_per_animal;
for k=1:10
    cntnap2_lasso_perf=squeeze(mean(lasso_performance_per_animal(k,1,:,:),3));
    wt_lasso_perf=squeeze(mean(wt.lasso_performance_per_animal(k,1,:,:),3));
    [h,p]=ttest2(cntnap2_lasso_perf,wt_lasso_perf);
    p_lasso_wt_cntnap2(k)=p
end

% Figure from the paper, showing lambda=0.0001 for lasso between shank3
% and WT
k_lambda=1
figure,hold on
this_lambda_per_animal=mean(lasso_performance_per_animal(good_dim,k_lambda,:,:),3);
this_lambda_per_animal=squeeze(this_lambda_per_animal);
a=plot(number_extra_elements_to_try(good_dim)-10,this_lambda_per_animal,'sm')
set(a,'MarkerSize',18)
set(a,'MarkerSize',18), for k=1:5,set(a(k),'Marker',symbols(k)),end


plot(number_extra_elements_to_try(good_dim),mean(lasso_performance(good_dim,k_lambda,:),3),'B')
xx=lasso_performance;
for k_p=1:length(good_dim)
    x=squeeze(xx(good_dim(k_p),k_lambda,:));
    low_x(k_p)=prctile(x,10);
    high_x(k_p)=prctile(x,90);
end
c=mean(lasso_performance(good_dim,k_lambda,:),3)';
a=errorbar(number_extra_elements_to_try(good_dim),c,c-low_x,high_x-c,'m');set(a,'LineWidth',2)


% Add WT animals data
wt_this_lambda_per_animal=mean(wt.lasso_performance_per_animal(good_dim,k_lambda,:,:),3);
wt_this_lambda_per_animal=squeeze(wt_this_lambda_per_animal);
a=plot(number_extra_elements_to_try(good_dim)+10,wt_this_lambda_per_animal,'sg')
set(a,'MarkerSize',18)
set(a,'MarkerSize',18), for k=1:5,set(a(k),'Marker',symbols(k)),end


u=plot(number_extra_elements_to_try(good_dim),mean(wt.lasso_performance(good_dim,k_lambda,:),3),'g')


xx=wt.lasso_performance;
for k_p=1:length(good_dim)
    x=squeeze(xx(good_dim(k_p),k_lambda,:));
    low_x(k_p)=prctile(x,10);
    high_x(k_p)=prctile(x,90);
end
c=mean(wt.lasso_performance(good_dim,k_lambda,:),3)';
a=errorbar(number_extra_elements_to_try(good_dim),c,c-low_x,high_x-c,'g');set(a,'LineWidth',2)

axis([50 1050 0.5 1])
a=gca, set(a,'FontName','arial'), set(a,'FontSize',14)
xlabel('Number of elements in the dictionary')
ylabel('Lasso performance using test set (novel backgrounds)')
title('Figure 9I')

   


