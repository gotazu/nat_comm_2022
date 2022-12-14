load resubmission_figure_8
% creates plot of supplementary Figure 11G
for k_files=1:length(files_with_simulation)
    % For the linear classifiers
    for kk=1:length(correlations.result(k_files).svm.correlation_as_threshold)
        svm_corr(k_files,kk)=correlations.result(k_files).svm.correlation_as_threshold(kk);
        logistic_corr(k_files,kk)=correlations.result(k_files).logistic.correlation_as_threshold(kk);
        svm_corr_n_glom(k_files,kk)=mean(number_roi(k_files).svm_lasso_number_nonzero_glom(:,kk));
        logistic_corr_n_glom(k_files,kk)=mean(number_roi(k_files).logistic_lasso_number_nonzero_glom(:,kk));    
        svm_performance(k_files,kk)=mean(correlations.result(k_files).svm.performance_as_threshold(:,kk));
        logistic_performance(k_files,kk)=mean(correlations.result(k_files).logistic.performance_as_threshold(:,kk));
        
    end
    for kk=1:length(correlations.result(k_files).nn.correlation_as_threshold)
        nn_corr(k_files,kk)=correlations.result(k_files).nn.correlation_as_threshold(kk);
        nn_corr_n_glom(k_files,kk)=mean(number_roi(k_files).nn_number_nonzero_glom(:,kk)); 
        nn_performance(k_files,kk)=mean(correlations.result(k_files).nn.performance_as_threshold(:,kk));
    end  
end

svm_corr_n_glom=svm_corr_n_glom(:,1:7);
svm_corr=svm_corr(:,1:7);
svm_performance=svm_performance(:,1:7);

logistic_corr_n_glom=logistic_corr_n_glom(:,1:4);
logistic_corr=logistic_corr(:,1:4);
logistic_performance=logistic_performance(:,1:4);

mean_nn_corr_n_glom=mean(nn_corr_n_glom); 
mean_svm_corr_n_glom=mean(svm_corr_n_glom);mean_svm_corr_n_glom(1)=mean_nn_corr_n_glom(1);
mean_logistic_corr_n_glom=mean(logistic_corr_n_glom);mean_logistic_corr_n_glom(1)=mean_nn_corr_n_glom(1);



figure,a=errorbar(mean_svm_corr_n_glom,mean(svm_corr),std(svm_corr),std(svm_corr),std(svm_corr_n_glom),std(svm_corr_n_glom),'r'),set(a,'LineWidth',2)
hold on
a=errorbar(mean_logistic_corr_n_glom,mean(logistic_corr),std(logistic_corr),std(logistic_corr),std(logistic_corr_n_glom),std(logistic_corr_n_glom),'g'),set(a,'LineWidth',2)
a=errorbar(mean_nn_corr_n_glom,mean(nn_corr),std(nn_corr),std(nn_corr),std(nn_corr_n_glom),std(nn_corr_n_glom),'k'),set(a,'LineWidth',2)
axis([14 162 -0.15 1])
a=gca; set(a,'Box','off')
xlabel('Number of ROI used')
ylabel('Linear correlation with behavior (r)')
title('Supplementary Figure 11G')

for k= 1:7
    base=nn_corr(:,1);
    [h,p_nn_corr(k)]=ttest2(base,nn_corr(:,k));
end

for k= 1:7
    base_svm=svm_corr(:,1);
    [h,p_svm_corr(k)]=ttest2(base_svm,svm_corr(:,k));
   
end
        
for k= 1:4
    base_logistic=logistic_corr(:,1);
    [h,p_logistic_corr(k)]=ttest2(base_logistic,logistic_corr(:,k));
end


