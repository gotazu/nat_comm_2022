load z_score_postprocess_decoder_non_param_decoder_reduced_set_batch

for k_dir=1:length(data_per_dir)
    data=analysis_results_new(k_dir);
    nn_reduced_set(k_dir)=mean(data.no_sel_noisy_novel_testing_1_correct_0_error);
    svm_reduced_set(k_dir)=mean(data.linear_classifier.svm.lasso.performance_per_regularization_novel(1,:));
    logistic_reduced_set(k_dir)=mean(data.linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:));
end





% Add the plot of the individual animals
performance_individual_animals_reduced=sum(novel_performance_n_correct,2)./sum(novel_performance_n_total,2);
performance_individual_animals_full=async_full_set.novel_correct_per_animal./async_full_set.novel_total_per_animal;

%Behavior 
[PHAT_full_behavior, PCI_full_behavior] = binofit(257,334,0.05) % data from 4 anials asyn
[PHAT_restrict_behavior, PCI_restrict_behavior] = binofit(novel_performance_correct,novel_performance_total,0.05)
table_signi_behavior=[257,334-257;...
                     novel_performance_correct,novel_performance_total-novel_performance_correct]
[H,P] = fishertest(table_signi_behavior)


figure 
x=bar([1,2],[mean(full_mixture.nn_novel),mean(nn_reduced_set)])
hold on
a=errorbar(1,mean(full_mixture.nn_novel),std(full_mixture.nn_novel)/sqrt(32),'k'), set(a,'LineWidth',2)
a=errorbar(2,mean(nn_reduced_set),std(nn_reduced_set)/sqrt(32),'k'), set(a,'LineWidth',2)

bar([4,5],[mean(full_mixture.svm_novel),mean(svm_reduced_set)])
hold on
a=errorbar(4,mean(full_mixture.svm_novel),std(full_mixture.svm_novel)/sqrt(32),'k'), set(a,'LineWidth',2)
a=errorbar(5,mean(svm_reduced_set),std(svm_reduced_set)/sqrt(32),'k'), set(a,'LineWidth',2)

bar([7,8],[mean(full_mixture.log_novel),mean(logistic_reduced_set)])
hold on
a=errorbar(7,mean(full_mixture.log_novel),std(full_mixture.log_novel)/sqrt(32),'k'), set(a,'LineWidth',2)
a=errorbar(8,mean(logistic_reduced_set),std(logistic_reduced_set)/sqrt(32),'k'), set(a,'LineWidth',2)



bar([11,12],[PHAT_full_behavior,PHAT_restrict_behavior],'r')
hold on
a=errorbar(11,PHAT_full_behavior,PCI_full_behavior(1)-PHAT_full_behavior,PCI_full_behavior(2)-PHAT_full_behavior,'k'), set(a,'LineWidth',2)
a=errorbar(12,PHAT_restrict_behavior,PCI_restrict_behavior(1)-PHAT_restrict_behavior,PCI_restrict_behavior(2)-PHAT_restrict_behavior,'k'), set(a,'LineWidth',2)
a=plot(12,performance_individual_animals_reduced,'ks')
set(a,'MarkerSize',12)
a=plot(11,performance_individual_animals_full,'ks')
set(a,'MarkerSize',12)

plot([0 13],[0.5 0.5],'k:')


axis([0 13 0.4 1])
a=gca;
set(a,'YTick',[0.5 0.6 0.7 0.8 0.9 1])
set(a,'XTick',[1,2,4,5,7,8,11,12]),set(a,'XTickLabel',{'NN full', 'NN reduc','SVM full', 'SVM reduc','Log full', 'Log reduc','Behav full', 'Behav reduc'})
title('Figure 7C')
set(a,'Box','off')
ylabel('Perf with test set (novel backgrounds)')

