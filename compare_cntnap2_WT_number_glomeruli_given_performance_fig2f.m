load compare_cntnap2_WT_number_glomeruli_given_performance_fig2f

average_glom_used_nn_WT=[];
%Extract the distribution of the number of glomeruli which are reduced as we change the sparseness constraint
for k_dir=1:length(analysis_results_new_WT)
    svm_lasso_number_nonzero_glom_WT(k_dir,:)=analysis_results_new_WT(k_dir).linear_classifier.svm.lasso.number_nonzero_glom;
    logistic_lasso_number_nonzero_glom_WT(k_dir,:)=analysis_results_new_WT(k_dir).linear_classifier.logistic.lasso.number_nonzero_glom;
    for kk=1:length(analysis_results_new_WT(1).performance_thresholds_au_ROC_n_glomeruli)
        r_WT(k_dir,kk)=mean(analysis_results_new_WT(k_dir).noisy_novel_testing_1_correct_0_error{kk});
    end
    average_glom_used_nn_WT=[average_glom_used_nn_WT;analysis_results_new_WT(k_dir).performance_thresholds_au_ROC_n_glomeruli];
end
%Extract the distribution of animal performances
for k_dir=1:length(analysis_results_new_WT)
    svm_lasso_performance_WT(k_dir,:)=mean(analysis_results_new_WT(k_dir).linear_classifier.svm.lasso.performance_per_regularization_novel');
    logistic_lasso_performance_WT(k_dir,:)=mean(analysis_results_new_WT(k_dir).linear_classifier.logistic.lasso.performance_per_regularization_novel');
end


figure,hold on
index_fig_2_f=1:13;
%index_fig_2_f=1:21;
[h,p_svm]=ttest(svm_lasso_performance_WT,0.70,'Tail','left')
x_neg=std(svm_lasso_number_nonzero_glom_WT(:,index_fig_2_f))/sqrt(32);
y_neg=std(svm_lasso_performance_WT(:,index_fig_2_f))/sqrt(32);x_neg(1)=39.8/sqrt(32);y_neg(1)= 2.2/100;
n_glom_svm=mean(svm_lasso_number_nonzero_glom_WT(:,index_fig_2_f)); n_glom_svm(1)=161.3;
mean_perf_svm=mean(svm_lasso_performance_WT(:,index_fig_2_f));mean_perf_svm(1)=70.1/100;
%plot(n_glom_svm,p_svm(index_fig_2_f),'ko')

a=errorbar(n_glom_svm,mean_perf_svm,y_neg,y_neg,x_neg,x_neg,'ko'), set(a,'LineWidth',4)
plot(n_glom_svm,mean_perf_svm,'k')


index_fig_2_f=1:7;
%index_fig_2_f=1:21;
x_neg=std(logistic_lasso_number_nonzero_glom_WT(:,index_fig_2_f))/sqrt(32);
y_neg=std(logistic_lasso_performance_WT(:,index_fig_2_f))/sqrt(32);x_neg(1)=39.8/sqrt(32); y_neg(1)=2.5/100;
[h,p_logistic]=ttest(logistic_lasso_performance_WT,0.70,'Tail','left')

n_glom_logistic=mean(logistic_lasso_number_nonzero_glom_WT(:,index_fig_2_f));n_glom_logistic(1)=161.3;
mean_perf_logistic=mean(logistic_lasso_performance_WT(:,index_fig_2_f));mean_perf_logistic(1)=70.1/100;
a=errorbar(n_glom_logistic,mean_perf_logistic,y_neg,y_neg,x_neg,x_neg,'go'), set(a,'LineWidth',4)
plot(n_glom_logistic,mean_perf_logistic,'g')
%plot(n_glom_logistic,p_logistic(index_fig_2_f),'go')



index_fig_2_f=1:2:20
[h,p_nn]=ttest(r_WT,0.70,'Tail','left')
x_neg=std(average_glom_used_nn_WT(:,index_fig_2_f))/sqrt(32);
x_neg(1)=39.8/sqrt(32);
y_neg=std(r_WT(:,index_fig_2_f))/sqrt(32);
y_neg(1)=2.9*1/100; % These values are from the original simulation
glom_nn=mean(average_glom_used_nn_WT(:,index_fig_2_f));
n_glom_NN=mean(average_glom_used_nn_WT(:,index_fig_2_f));n_glom_NN(1)=161.3;
mean_perf_NN=mean(r_WT(:,index_fig_2_f));
mean_perf_NN(1)=70.8/100;
a=errorbar(n_glom_NN,mean_perf_NN,y_neg,y_neg,x_neg,x_neg,'ro'), set(a,'LineWidth',4)
a=plot(n_glom_NN,mean_perf_NN,'r')
%plot(n_glom_NN,p_nn(index_fig_2_f),'ro')

axis([2 170 0.5 1])
a=gca
set(a,'XScale','log')
set(a,'FontSize',36),set(a,'FontName','arial')
xlabel('Number of ROI used')
ylabel('Performance')
title('Figure 4F')

