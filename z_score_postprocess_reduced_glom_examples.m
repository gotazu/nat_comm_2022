load z_score_postprocess_reduced_glom_examples
y_axis_ticks=1.5:1:15.5;

% Figure 1 N-P
%for k_dir=7:7%1:length(n_32)  % 7 is for linear classifier FIg3 related. kdir =2 is for the

index_pretty=25;
vial_struct=data_per_dir(index_pretty).all_vials_struct;

standard=find(vial_struct(:,2)==51);
novel=find(vial_struct(:,2)~=51);
reordered=[standard;novel];
reorder_df=data_per_dir(index_pretty).df(reordered,:);
reorder_df(reorder_df>z_score_threshold)=0;
low_value=min(min(reorder_df));
figure

subplot(2,1,1),imagesc(data_per_dir(index_pretty).df(standard,:)); caxis([low_value,z_score_threshold])
title('Figure 1N-P')
subplot(2,1,2),imagesc(data_per_dir(index_pretty).df(novel,:)); caxis([low_value,z_score_threshold])
colorbar
figure

subplot(2,1,1),imagesc(data_per_dir(index_pretty).df(standard,:)); caxis([low_value,z_score_threshold])
title('Figure 1N-P')
a=gca;
set(a,'XTick',[]),set(a,'YTick',y_axis_ticks);set(a,'YTickLabel',[]);
grid on
subplot(2,1,2),imagesc(data_per_dir(index_pretty).df(novel,:)); caxis([low_value,z_score_threshold])
a=gca;
set(a,'YTick',y_axis_ticks);
grid on
xlabel('ROI number')



% Figure 3 linear classifier ands nearest neighbor classifier
index_pretty=20;
vial_struct=data_per_dir(index_pretty).all_vials_struct;

standard=find(vial_struct(:,2)==51);
novel=find(vial_struct(:,2)~=51);
reordered=[standard;novel];
reorder_df=data_per_dir(index_pretty).df(reordered,:);
reorder_df(reorder_df>z_score_threshold)=0;
training_data_go_1_no_go_m1=vial_struct(standard,3)<33;
testing_data_go_1_no_go_m1=vial_struct(novel,3)<33;





training_data=data_per_dir(index_pretty).df(standard,:);
testing_data=data_per_dir(index_pretty).df(novel,:);
noisy_df_novel=testing_data+ CV*randn(size(testing_data)).*testing_data;
[n_train,n_glom]=size(training_data);
% Let's do the centering
clear noisy_df_novel_center training_data_center
for k=1:n_glom %We centered each glomerulus based on the mean value of the activation produced by the standard trial
    noisy_df_novel_center(:,k)=noisy_df_novel(:,k)-mean(training_data(:,k));
    training_data_center(:,k)=training_data(:,k)-mean(training_data(:,k));
end
noisy_df_novel_center(testing_data>z_score_threshold)=0;
training_data_center(training_data>z_score_threshold)=0;
% Determine the color axis
max_color=max([max(max(training_data_center)),max(max(noisy_df_novel_center))]);
min_color=min([min(min(training_data_center)),min(min(noisy_df_novel_center))]);

%Locate the most sensitive ROI (Figure 2B)
% Do the process for the best ROI.
% Step 1: plot the best ROI auROC for novel and for standard odor
AUC_standard=[];
AUC_novel=[];
for k=1:n_glom
    repeats_single_glom_standard_go_no_go=training_data_center(:,k);
    repeats_single_glom_novel_go_no_go=noisy_df_novel_center(:,k);
    [X,Y,g,AUC_standard(k),OPTROCPT] = perfcurve(training_data_go_1_no_go_m1,repeats_single_glom_standard_go_no_go,1);
    [X,Y,g,AUC_novel(k),OPTROCPT] = perfcurve(testing_data_go_1_no_go_m1,repeats_single_glom_novel_go_no_go,1);
end
rectified_auc=abs(AUC_standard-0.5)+0.5;
%         figure,plot(rectified_auc)
[a,i]=max(rectified_auc);

X_tick=[1,i,n_glom];


figure
subplot(2,1,1),imagesc(training_data_center),caxis([min_color,max_color]);
title('Figure 3A training set')
a=gca;
set(a,'XTick',X_tick),set(a,'YTick',y_axis_ticks);
grid on
subplot(2,1,2),imagesc(noisy_df_novel_center),caxis([min_color,max_color]);
title('Figure 3A test set')
a=gca;
set(a,'XTick',X_tick),set(a,'YTick',y_axis_ticks);
grid on

%Calculate the result of the logistic linear classifier
%figure 3C
[Mdl_log,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','logistic','Regularization','lasso','Lambda',0);
figure,a=plot(training_data_center*Mdl_log.Beta+Mdl_log.Bias,'bs'), set(a,'MarkerSize',24), set(a,'LineWidth',2)
hold on,a=plot(noisy_df_novel_center*Mdl_log.Beta+Mdl_log.Bias,'rs'),set(a,'MarkerSize',24),set(a,'LineWidth',2)
a=gca;
axis square
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('Logistic regressor output')
title('Figure 3C')
xlabel('Go mixture                 NG mixture')
grid on

%Calculate the result of the SVM linear classifier
%figure 3E
[Mdl_svm,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','svm','Regularization','lasso','Lambda',0);
figure,a=plot(training_data_center*Mdl_svm.Beta+Mdl_svm.Bias,'bs'),set(a,'MarkerSize',24), set(a,'LineWidth',2)
hold on,a=plot(noisy_df_novel_center*Mdl_svm.Beta+Mdl_svm.Bias,'rs'),set(a,'MarkerSize',24), set(a,'LineWidth',2)
a=gca;
axis square
set(a,'XLim',[0 16])
set(a,'Box','off')
a=gca;
axis square
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
xlabel('Go test mixture                 NG test mixture')
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('SVM regressor output')
title('Figure 3E')
grid on


% Plot the weights of the example: Figure 3B
figure,a=plot(Mdl_log.Beta,'g'); set(a,'LineWidth',2)
hold on,a=plot(Mdl_svm.Beta,'k'); set(a,'LineWidth',2)
legend({'Logistic weights','SVM weights'})
a=gca;
set(a,'XLim',[0.5 n_glom+0.5]);
xlabel('ROI number')
ylabel('Weight')
set(a,'Box','off')
title('Figure 3B')




% Do an example of the nearest neighbor, and mark the location of the
% nearest neighboir
% Figure 3G
similarity_matrix=training_data_center*noisy_df_novel_center';
figure,imagesc(similarity_matrix), hold on
for k_counter=1:16
    vector_to_check=similarity_matrix(:,k_counter);
    [peak,this_peak_index]=max(vector_to_check);
    %plot(k_counter,this_peak_index,'sk')
    a=rectangle('Position',[k_counter-0.5,this_peak_index-0.5,1,1])
    xlabel('Test set')
    ylabel('Training set')
    set(a,'LineWidth',4),
    set(a,'EdgeColor','r')
    title('Figure 3G')
    
end
axis square
a=gca
set(a,'Xtick',[1 8 9 16])
xlabel('Go test mixture                 NG test mixture')
set(a,'Ytick',[1 8 9 16])
ylabel('Go train mixture                 NG train mixture')


% Example plot of the best glomerulus performance (Figure 2)
index_pretty=28;
vial_struct=data_per_dir(index_pretty).all_vials_struct;

standard=find(vial_struct(:,2)==51);
novel=find(vial_struct(:,2)~=51);
reordered=[standard;novel];
reorder_df=data_per_dir(index_pretty).df(reordered,:);
reorder_df(reorder_df>z_score_threshold)=0;
training_data_go_1_no_go_m1=vial_struct(standard,3)<33;
testing_data_go_1_no_go_m1=vial_struct(novel,3)<33;

training_data=data_per_dir(index_pretty).df(standard,:);
testing_data=data_per_dir(index_pretty).df(novel,:);
noisy_df_novel=testing_data+ CV*randn(size(testing_data)).*testing_data;   % I am using noise on the test signal so the actual displayed image might be different
[n_train,n_glom]=size(training_data);
% Let's do the centering
clear noisy_df_novel_center training_data_center
for k=1:n_glom %We centered each glomerulus based on the mean value of the activation produced by the standard trial
    noisy_df_novel_center(:,k)=noisy_df_novel(:,k)-mean(training_data(:,k));
    training_data_center(:,k)=training_data(:,k)-mean(training_data(:,k));
end
noisy_df_novel_center(testing_data>z_score_threshold)=0;
training_data_center(training_data>z_score_threshold)=0;
% Determine the color axis
max_color=max([max(max(training_data_center)),max(max(noisy_df_novel_center))]);
min_color=min([min(min(training_data_center)),min(min(noisy_df_novel_center))]);

%Locate the most sensitive ROI (Figure 2B)
% Do the process for the best ROI.
% Step 1: plot the best ROI auROC for novel and for standard odor
AUC_standard=[];
AUC_novel=[];
for k=1:n_glom
    repeats_single_glom_standard_go_no_go=training_data_center(:,k);
    repeats_single_glom_novel_go_no_go=noisy_df_novel_center(:,k);
    [X,Y,g,AUC_standard(k),OPTROCPT] = perfcurve(training_data_go_1_no_go_m1,repeats_single_glom_standard_go_no_go,1);
    [X,Y,g,AUC_novel(k),OPTROCPT] = perfcurve(testing_data_go_1_no_go_m1,repeats_single_glom_novel_go_no_go,1);
end
rectified_auc=abs(AUC_standard-0.5)+0.5;
[a,i]=max(rectified_auc);

figure,plot(AUC_standard,'b');hold on,plot(AUC_novel,'r')
legend({'training set','test set'})
%xlabel()
X_tick=[1,i,n_glom];
ss=gca; set(ss,'XTick',X_tick)
xlabel('Roi Number')
ylabel('Area under ROC')
title('Figure 2B')

figure
subplot(2,1,1),imagesc(training_data_center),caxis([min_color,max_color]);
title('Figure 2A training set')
a=gca;
set(a,'XTick',X_tick),set(a,'YTick',y_axis_ticks);
grid on
subplot(2,1,2),imagesc(noisy_df_novel_center),caxis([min_color,max_color]);
title('Figure 2A test set')
a=gca;
set(a,'XTick',X_tick),set(a,'YTick',y_axis_ticks);
grid on



% Lets do the plot of the best ROI ROC curve (Figure 2D)
[a,i]=max(rectified_auc);
k=i;
repeats_single_glom_standard_go_no_go=training_data_center(:,k);
if AUC_standard(k)>0.5
    [X,Y,g,AUC_standardbest,OPTROCPT] = perfcurve(training_data_go_1_no_go_m1,repeats_single_glom_standard_go_no_go,1);
    figure,a=plot(X,Y,'k'),set(a,'LineWidth',2)
    hold on,
    a=plot(OPTROCPT(1),OPTROCPT(2),'ko')
    axis([0 1 0 1]), axis square, a=gca, set(a,'YTickLabel',[]);set(a,'XTickLabel',[]);
else
    [X,Y,g,AUC_standardbest,OPTROCPT] = perfcurve(training_data_go_1_no_go_m1,repeats_single_glom_standard_go_no_go,0);
    figure,a=plot(Y,X,'k'),set(a,'LineWidth',2)
    hold on,
    a=plot(OPTROCPT(2),OPTROCPT(1),'ko')
    axis([0 1 0 1]), axis square, a=gca, set(a,'YTickLabel',[]);set(a,'XTickLabel',[]);
end
xlabel('False positive rate'),ylabel('True Positive Rate')
title('Figure 2D Best ROI ROC curve')

% Show the z-score of the the best ROI for the example (Figure 2E)
optimal_threshold_standard_go_larger_than_no_go=g((X==OPTROCPT(1))&(Y==OPTROCPT(2)));
figure,a=plot(repeats_single_glom_standard_go_no_go,'bs'),set(a,'MarkerSize',18),set(a,'LineWidth',2)
hold on
a=plot(testing_data(:,i),'rs'),set(a,'MarkerSize',18),set(a,'LineWidth',2)
plot([0 16],[optimal_threshold_standard_go_larger_than_no_go,optimal_threshold_standard_go_larger_than_no_go],'k')
a=gca,
set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
xlabel('Go mixture                 NG mixture')
ylabel('Zscore of best ROI')
title('Figure 2E')
axis square







