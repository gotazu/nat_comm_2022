 load z_score_postprocess_decoder_batch_new_decoder_final_explore_noise_levels 
% Coun the number of responses included
for k_z_score_threshold=1:length(z_score_threshold_to_use)
    z_score_threshold=z_score_threshold_to_use(k_z_score_threshold);%-0.42;
    for k_dir=1:length(data_per_dir)
        number_responses_used(k_dir,k_z_score_threshold)=sum(sum(data_per_dir(k_dir).df<z_score_threshold));
        number_responses_available(k_dir,k_z_score_threshold)=sum(sum(data_per_dir(k_dir).df<1e6));
    end
end






% Before looking at the behavioral data, I shoould do a plot of how  each
% of the methods that I have used behaved
for k_z_score_threshold=1:length(z_score_threshold_to_use)
    for k_dir=1:length(data_per_dir)
        svm_standard(k_dir,k_z_score_threshold)=mean(analysis_results_new(k_dir,k_z_score_threshold).linear_classifier.svm.lasso.performance_per_regularization_standard(1,:),2);
        log_standard(k_dir,k_z_score_threshold)=mean(analysis_results_new(k_dir,k_z_score_threshold).linear_classifier.logistic.lasso.performance_per_regularization_standard(1,:),2);
        svm_novel(k_dir,k_z_score_threshold)=mean(analysis_results_new(k_dir,k_z_score_threshold).linear_classifier.svm.lasso.performance_per_regularization_novel(1,:),2);
        log_novel(k_dir,k_z_score_threshold)=mean(analysis_results_new(k_dir,k_z_score_threshold).linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:),2);
        nn_novel(k_dir,k_z_score_threshold)=mean(analysis_results_new(k_dir,k_z_score_threshold).noisy_novel_testing_1_correct_0_error{1});
    end
end
index=4:12;

figure

a=errorbar(z_score_threshold_to_use(index),mean(log_novel(:,index)),std(log_novel(:,index))/sqrt(32),'g'),set(a,'LineWidth',2)
hold on
a=errorbar(z_score_threshold_to_use(index),mean(svm_novel(:,index)),std(svm_novel(:,index))/sqrt(32),'k'),set(a,'LineWidth',2)
hold on
a=errorbar(z_score_threshold_to_use(index),mean(nn_novel(:,index)),std(nn_novel(:,index))/sqrt(32),'r'),set(a,'LineWidth',2)
hold on
axis([-0.7 -0.17 0 1])
a=gca
set(a,'Box','off')
xlabel('Z score threshold')
ylabel('Performance')
legend('Log','SVM','NN')
title('Supp Figure 6B')
axis square


for k=1:length(index)
    [h,p_value_nn(k)]=ttest2(nn_novel(:,index(k)),nn_novel(:,index(5)));
    [h,p_value_svm(k)]=ttest2(svm_novel(:,index(k)),svm_novel(:,index(5)));
    [h,p_value_logistic(k)]=ttest2(log_novel(:,index(k)),log_novel(:,index(5)));
    
end



figure,a=plot(z_score_threshold_to_use(index),sum(number_responses_used(:,index)),'bx')
title('Supp Figure 6A')
set(a,'LineWidth',2)
axis([-0.7 -0.17 0 10e4])
a=gca
set(a,'Box','off')
xlabel('Z score threshold')
ylabel('Number of ROI odor responses')
axis square

