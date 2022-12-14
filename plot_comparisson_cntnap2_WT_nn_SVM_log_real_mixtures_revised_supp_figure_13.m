% Supp Fig 14 D-F , We calculated how large do we need a large coefficient
% of variation to start affecting the performance of the algorithms,
% calculated using actual mixtures

load plot_comparisson_cntnap2_WT_nn_SVM_log_real_mixtures_revised_supp_figure_13
% Before looking at the behavioral data, I shoould do a plot of how  each
% of the methods that I have used behaved
for CV_counter=1:length(CV_to_try)
    for k_dir=1:length(data_per_dir)
        svm_novel(CV_counter,k_dir)=mean(analysis_results_new(CV_counter,k_dir).linear_classifier.svm.lasso.performance_per_regularization_novel(1,:),2);
        log_novel(CV_counter,k_dir)=mean(analysis_results_new(CV_counter,k_dir).linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:),2);
        nn_novel(CV_counter,k_dir)=mean(analysis_results_new(CV_counter,k_dir).noisy_novel_testing_1_correct_0_error{1});
    end
end

figure,a=errorbar(CV_to_try,mean(svm_novel,2),std(svm_novel')/sqrt(length(data_per_dir))),set(a,'LineWidth',2),hold on,hold on
axis([0.2 3 0.5 1.05])
% I will calculate the p-value 
for k=1:length(CV_to_try)
    [h,p]=ttest2(svm_novel(1,:),svm_novel(k,:));
    p_value_svm(k)=p;
    if p<0.05
        a=text(CV_to_try(k),0.8,'*')
        set(a,'FontSize',24)
    end
end
a=gca
set(a,'FontName','arial'), set(a,'FontSize',36),set(a,'Box','off')
xlabel('Coefficient of variation (CV)')
ylabel('SVM performance')
title('Supp Fig 14D')




figure,a=errorbar(CV_to_try,mean(log_novel,2),std(log_novel')/sqrt(length(data_per_dir))),set(a,'LineWidth',2),hold on
axis([0.2 3 0.5 1.05])
% I will calculate the p-value 
for k=1:length(CV_to_try)
    [h,p]=ttest2(log_novel(1,:),log_novel(k,:));
    p_value_log(k)=p;
    if p<0.05
        a=text(CV_to_try(k),0.8,'*'),set(a,'FontSize',24)
    end
end
a=gca
set(a,'FontName','arial'), set(a,'FontSize',36),set(a,'Box','off')
xlabel('Coefficient of variation (CV)')
ylabel('Logistic performance')
title('Supp Fig 14E')



figure,a=errorbar(CV_to_try,mean(nn_novel,2),std(nn_novel')/sqrt(length(data_per_dir))),set(a,'LineWidth',2),hold on
axis([0.2 3 0.5 1.05])
for k=1:length(CV_to_try)
    [h,p]=ttest2(nn_novel(1,:),nn_novel(k,:));
    p_value_nn(k)=p;
    if p<0.05
        a=text(CV_to_try(k),0.8,'*'),set(a,'FontSize',24)
    end
end
a=gca
set(a,'FontName','arial'), set(a,'FontSize',36),set(a,'Box','off')
xlabel('Coefficient of variation (CV)')
ylabel('Nearest Neighbor performance')
title('Supp Fig 14F')

    
    
