load  z_score_postprocess_decoder_batch_new_decoder_final
%%%Money shot for nearest neighbor different selectivities of the included
%%%ROI
clear correlation_as_threshold
nn_average_glom=mean(average_glom_used_nn);

error_number_glom_low=std(average_glom_used_nn);
for k_threshold=[1,4]
    figure,a=plot((imaging_go_performance(:,k_threshold)+imaging_no_go_performance(:,k_threshold))/2,(behavior_go_performance_sync+behavior_no_go_performance_sync)/2,'ko')
    set(a,'MarkerSize',12)
    axis([0.5 1 0.5 1])
    hold on
    axis square
    a=plot((imaging_go_performance(:,k_threshold)+imaging_no_go_performance(:,k_threshold))/2,(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2,'ro')
    set(a,'MarkerSize',12)
    behav_fit=[(behavior_go_performance_sync+behavior_no_go_performance_sync)/2 ,(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2];
    im_fit=[(imaging_go_performance(:,k_threshold)+imaging_no_go_performance(:,k_threshold))/2;(imaging_go_performance(:,k_threshold)+imaging_no_go_performance(:,k_threshold))/2];
    fiteo=polyfit(im_fit,behav_fit',1);
    for_line_plot_x=0:0.1:1;
    for_line_plot_y=polyval(fiteo,for_line_plot_x);
    plot(for_line_plot_x,for_line_plot_y)
    axis([0.5 1 0.5 1])
    axis square
    hold on
    a=gca;
    xlabel('Classifier Performance'),ylabel('Animal performance'),title('Supp Figure 11A-D Nearest Neighbor')
    set(a,'Box','off')
    [RHO,PVAL] = corr(behav_fit',im_fit)
    [R,P,RL,RU] = corrcoef(behav_fit',im_fit);
    correlation_as_threshold(k_threshold)=RHO;
    correlation_as_threshold_p(k_threshold)=P(2,1);
    correlation_low_nn(k_threshold)=RL(1,2);correlation_high_nn(k_threshold)=RU(1,2);
    
    %[RHO,PVAL] = corr(behav_fit',im_fit,'type','Spearman')
    text(0.8,0.6,['r=',num2str(RHO), ' p=',num2str(PVAL)])
    text(0.55,0.6,[num2str(nn_average_glom(k_threshold)), ' +- ',num2str(error_number_glom_low(k_threshold))])
    axis square
end

%Money shots for the different linear classifier: 1) svm_lasso
clear correlation_as_threshold
n_svm=mean(svm_lasso_number_nonzero_glom);
error_number_glom_low=std(svm_lasso_number_nonzero_glom);

for k_lambda=[1,9]
    figure,a=plot(imaging_performance_odors_tested_novel_svm_lasso(:,k_lambda),(behavior_go_performance_sync+behavior_no_go_performance_sync)/2,'ko')
    set(a,'MarkerSize',12)
    axis([0.5 1 0.5 1])
    hold on
    axis square
    a=plot(imaging_performance_odors_tested_novel_svm_lasso(:,k_lambda),(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2,'ro')
    set(a,'MarkerSize',12)
    behav_fit=[(behavior_go_performance_sync+behavior_no_go_performance_sync)/2 ,(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2];
    im_fit=[imaging_performance_odors_tested_novel_svm_lasso(:,k_lambda);imaging_performance_odors_tested_novel_svm_lasso(:,k_lambda)];
    fiteo=polyfit(im_fit,behav_fit',1);
    for_line_plot_x=0:0.1:1;
    for_line_plot_y=polyval(fiteo,for_line_plot_x);
    plot(for_line_plot_x,for_line_plot_y)
    axis([0.5 1 0.5 1])
    axis square
    hold on
    a=gca;
    xlabel('Classifier Performance'),ylabel('Animal performance'),title('Supp Figure 11C-F SVM')
    set(a,'Box','off')
    [RHO,PVAL] = corr(behav_fit',im_fit)
    [R,P,RL,RU] = corrcoef(behav_fit',im_fit);
    correlation_as_threshold(k_lambda)=RHO;
    correlation_as_threshold_p(k_lambda)=P(2,1);
    correlation_low_svm(k_lambda)=RL(1,2);correlation_high_svm(k_lambda)=RU(1,2);
    
    
    
    corr_coefficient_svm_lasso(k_lambda)=RHO;
    performance_svm_lasso(k_lambda)=mean(imaging_performance_odors_tested_novel_svm_lasso(:,k_lambda));
    %[RHO,PVAL] = corr(behav_fit',im_fit,'type','Spearman')
    text(0.8,0.6,['r=',num2str(RHO), ' p=',num2str(PVAL)])
    
    
    axis square
end



%2)_logistic_lasso  
clear correlation_as_threshold
for k_lambda=[1,5]
    figure,a=plot(imaging_performance_odors_tested_novel_logistic_lasso(:,k_lambda),(behavior_go_performance_sync+behavior_no_go_performance_sync)/2,'ko')
    set(a,'MarkerSize',12)
    axis([0.5 1 0.5 1])
    hold on
    axis square
    a=plot(imaging_performance_odors_tested_novel_logistic_lasso(:,k_lambda),(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2,'ro')
    set(a,'MarkerSize',12)
    behav_fit=[(behavior_go_performance_sync+behavior_no_go_performance_sync)/2 ,(behavior_go_performanceno_no_sync+behavior_no_go_performanceno_no_sync)/2];
    im_fit=[imaging_performance_odors_tested_novel_logistic_lasso(:,k_lambda);imaging_performance_odors_tested_novel_logistic_lasso(:,k_lambda)];
    fiteo=polyfit(im_fit,behav_fit',1);
    for_line_plot_x=0:0.1:1;
    for_line_plot_y=polyval(fiteo,for_line_plot_x);
    plot(for_line_plot_x,for_line_plot_y)
    axis([0.5 1 0.5 1])
    axis square
    hold on
    a=gca;
    xlabel('Classifier Performance'),ylabel('Animal performance'),title('Supp Figure 11B-E logistic')
    
    set(a,'Box','off')
    [RHO,PVAL] = corr(behav_fit',im_fit)
    
    [R,P,RL,RU] = corrcoef(behav_fit',im_fit);
    correlation_as_threshold_log(k_lambda)=RHO;
    correlation_as_threshold_p_log(k_lambda)=P(2,1);
    correlation_low_log(k_lambda)=RL(1,2);correlation_high_log(k_lambda)=RU(1,2);
    
    
    %[RHO,PVAL] = corr(behav_fit',im_fit,'type','Spearman')
    corr_coefficient_logistic_lasso(k_lambda)=RHO;
    performance_logistic_lasso(k_lambda)=mean(imaging_performance_odors_tested_novel_logistic_lasso(:,k_lambda));
    text(0.8,0.6,['r=',num2str(RHO), ' p=',num2str(PVAL)])
end

% Add the plots for the individual glomeruli


%%%Money shot for the best ROI.
for k_dir=1:length(data_per_dir)
    no_go_larger_than_go(k_dir)=max(analysis_results_new(k_dir).single_roi_performance_standard_no_go_larger_than_go);
    go_larger_than_no_go(k_dir)=max(analysis_results_new(k_dir).single_roi_performance_standard_go_larger_than_no_go);
    best_roi_performance(k_dir)= max([no_go_larger_than_go(k_dir),go_larger_than_no_go(k_dir)]);    
end

figure,bar([1,2],[mean(best_roi_novel_performance),mean(best_roi_performance)])
title('Figure 2F, Best ROI chosen from training set')
ylabel('Performance')
axis([0.2 3.2 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])
set(a,'XTick',[1,2]), set(a,'XTickLabel',{'Novel','Standard'})
set(a,'Box','off')
hold on
n_plot=sqrt(length(best_roi_novel_performance));
errorbar([1,2],[mean(best_roi_novel_performance),mean(best_roi_performance)],[std(best_roi_novel_performance),std(best_roi_performance)]/n_plot,'k')



% Before looking at the behavioral data, I shoould do a plot of how  each
% of the methods that I have used behaved
for k_dir=1:length(data_per_dir)
    svm_standard(k_dir)=mean(analysis_results_new(k_dir).linear_classifier.svm.lasso.performance_per_regularization_standard(1,:),2);
    log_standard(k_dir)=mean(analysis_results_new(k_dir).linear_classifier.logistic.lasso.performance_per_regularization_standard(1,:),2);
    svm_novel(k_dir)=mean(analysis_results_new(k_dir).linear_classifier.svm.lasso.performance_per_regularization_novel(1,:),2);
    log_novel(k_dir)=mean(analysis_results_new(k_dir).linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:),2);
    nn_novel(k_dir)=mean(analysis_results_new(k_dir).noisy_novel_testing_1_correct_0_error{1});
end


figure,bar([1],[mean(svm_novel)])
title('Figure 3F, performance SVM')
ylabel('SVM performance')
axis([0.2 3.2 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])
set(a,'Box','off')
hold on
n_plot=sqrt(length(best_roi_novel_performance));
errorbar([1],[mean(svm_novel)],[std(svm_novel)]/n_plot,'k')


figure,bar([1],[mean(log_novel)])
title('Figure 3D, performance logistic')
ylabel('logistic performance')
axis([0.2 3.2 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])
set(a,'Box','off')
hold on
n_plot=sqrt(length(best_roi_novel_performance));
errorbar([1],[mean(log_novel)],[std(log_novel)]/n_plot,'k')

figure,bar([1],[mean(nn_novel)])
title('Figure 3H performance NN')
axis([0.2 1.8 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])

set(a,'Box','off')
hold on
n_plot=sqrt(length(best_roi_novel_performance));
a=errorbar([1],[mean(nn_novel)],[std(nn_novel)]/n_plot,'k')
set(a,'LineWidth',2)


% Plot the correlation between the AUC of each ROI for novel and standard
% odors

AUC_novel_all=[];
AUC_standard_all=[];
for kk=1:length(analysis_results_new)
    AUC_novel_all=[AUC_novel_all,analysis_results_new(kk).AUC_novel];
    AUC_standard_all=[AUC_standard_all,analysis_results_new(kk).AUC_standard];
end
figure,plot(AUC_standard_all,AUC_novel_all,'k.'), title('Figure 2C')
axis([0 1 0 1]), axis square
a=gca;
xlabel('Area under ROC for training set')
xlabel('Area under ROC for test set')






