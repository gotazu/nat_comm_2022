% Supplementary Figures 14A, 14B, 14C
load plot_comparisson_cntnap2_WT_nn_SVM_log_real_mixtures

% supplementary Figure 14A
mean_values_SVM=[mean(WT.svm_novel),mean(svm_novel)];
std_values_SVM=[std(WT.svm_novel),std(svm_novel)];
figure,a=bar(mean_values_SVM)
axis([0.2 3 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])
set(a,'XTick',[1,2])
set(a,'XTickLabel',{'Low var','High var'})
set(a,'Box','off')
ylabel('SVM performance')
hold on
n_plot=sqrt(length(data_per_dir));
errorbar([1],mean_values_SVM(:,1),std_values_SVM(:,1)/n_plot,'k','LineStyle','none')
errorbar([2],mean_values_SVM(:,2),std_values_SVM(:,2)/n_plot,'k','LineStyle','none')
    title('Supplementary Figure 14A')
    
% supplementary Figure 14B
mean_values_log=[mean(WT.log_novel),mean(log_novel)];
std_values_log=[std(WT.log_novel),std(log_novel)];
figure,a=bar(mean_values_log)

axis([0.2 3 0 1])
a=gca;
set(a,'YTick',[0:0.1:1])
%set(a,'XTickLabel',[])

set(a,'XTick',[1,2])
set(a,'XTickLabel',{'Low var','High var'})
set(a,'Box','off')
hold on
n_plot=sqrt(length(data_per_dir));

    errorbar([1],mean_values_log(:,1),std_values_log(:,1)/n_plot,'k','LineStyle','none')
    errorbar([2],mean_values_log(:,2),std_values_log(:,2)/n_plot,'k','LineStyle','none')    
 title('Supplementary Figure 14B')
 ylabel('Logistic performance')
    
    
    
% supplementary Figure 14C    
mean_values_nn=[mean(WT.nn_novel),mean(nn_novel);mean(WT.nn_novel),mean(nn_novel)];
std_values_nn=[std(WT.nn_novel),std(nn_novel);std(WT.nn_novel),std(nn_novel)];
figure,a=bar(mean_values_nn)

axis([0.5 1.5 0 1])
a=gca;
set(a,'YLim',[0 1])
set(a,'YTick',[0:0.1:1])
%set(a,'XTickLabel',[])
%set(a,'XTick',[1,2])
set(a,'Box','off')
hold on
n_plot=sqrt(length(data_per_dir));
    errorbar([1-0.15,2-0.15],mean_values_nn(:,1),std_values_nn(:,1)/n_plot,'k','LineStyle','none')
    errorbar([1+0.15,2+0.15],mean_values_nn(:,2),std_values_nn(:,2)/n_plot,'k','LineStyle','none')    
    set(a,'XTick',[0.85,1.15])
set(a,'XTickLabel',{'Low var','High var'})
 ylabel('Nearest Neighbor performance')
  title('Supplementary Figure 14C')
    
