cd('C:\NYIT Data\NYIT_imaging')
cntnap2=load('revision_behavior_imaging_from_artificial_mixtures_cntnap2');
WT=load('revision_behavior_imaging_from_artificial_mixtures_WT');

[wtr,wts]=size(WT.animals_svm_average(:,WT.index_where_mixtures_used,1));
wt_svm=reshape(WT.animals_svm_average(:,WT.index_where_mixtures_used,1),1, wtr*wts);
wt_log=reshape(WT.animals_logistic_average(:,WT.index_where_mixtures_used,1),1, wtr*wts);
wt_nn=reshape(WT.animals_nn_average(:,WT.index_where_mixtures_used,1),1, wtr*wts);


[cntnap2_r,cntnap2_s]=size(cntnap2.animals_svm_average(:,WT.index_where_mixtures_used,1));
cntnap2_svm=reshape(cntnap2.animals_svm_average(:,cntnap2.index_where_mixtures_used,1),1, wtr*wts);
cntnap2_log=reshape(cntnap2.animals_logistic_average(:,cntnap2.index_where_mixtures_used,1),1, wtr*wts);
cntnap2_nn=reshape(cntnap2.animals_nn_average(:,cntnap2.index_where_mixtures_used,1),1, wtr*wts);

% Plot the responses from individual animals
wt_svm_animal=mean(WT.animals_svm_average(:,WT.index_where_mixtures_used,1)');
wt_log_animal=mean(WT.animals_logistic_average(:,WT.index_where_mixtures_used,1)');
wt_nn_animal=mean(WT.animals_nn_average(:,WT.index_where_mixtures_used,1)');

cntnap2_svm_animal=mean(cntnap2.animals_svm_average(:,cntnap2.index_where_mixtures_used,1)');
cntnap2_log_animal=mean(cntnap2.animals_logistic_average(:,cntnap2.index_where_mixtures_used,1)');
cntnap2_nn_animal=mean(cntnap2.animals_nn_average(:,cntnap2.index_where_mixtures_used,1)');

figure
bar([mean(wt_svm),mean(wt_log),mean(wt_nn) ;mean(cntnap2_svm),mean(cntnap2_log),mean(cntnap2_nn)]'),hold on
a=errorbar([1,2,3]-0.15,[mean(wt_svm),mean(wt_log),mean(wt_nn)],[std(wt_svm),std(wt_log),std(wt_nn)]/sqrt(length(wt_nn)),'k','LineStyle','none')
set(a,'LineWidth',2)
a=plot([1,2,3]-0.1,[wt_svm_animal;wt_log_animal;wt_nn_animal],'^k'),set(a,'MarkerSize',12)
a=plot([1,2,3]+0.20,[cntnap2_svm_animal;cntnap2_log_animal;cntnap2_nn_animal],'sk'),set(a,'MarkerSize',12)


a=errorbar([1,2,3]+0.15,[mean(cntnap2_svm),mean(cntnap2_log),mean(cntnap2_nn)],[std(cntnap2_svm),std(cntnap2_log),std(cntnap2_nn)]/sqrt(length(cntnap2_nn)),'k','LineStyle','none')
set(a,'LineWidth',2)
a=gca;
set(a,'YLim',[0 1]), set(a,'Box','off')
set(a,'YTick',0:0.1:1),set(a,'XTickLabel',[1,2,3]),set(a,'XTickLabel',{'SVM','Logistic', 'Nearest Neighbor'})
legend('WT','Cntnap2')
ylabel('Performance')
title('Figure 9H')


