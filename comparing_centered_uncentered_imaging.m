load comparing_centered_uncentered_imaging

% Comparisson per recording day
for k_dir=1:length(uncentered.data_per_dir)
    uncenter_nn(k_dir)=mean(uncentered.analysis_results_new(k_dir).noisy_novel_testing_1_correct_0_error{1});
    center_nn(k_dir)=mean(center.analysis_results_new(k_dir).noisy_novel_testing_1_correct_0_error{1});
    
    uncenter_svm(k_dir)=mean(uncentered.analysis_results_new(k_dir).linear_classifier.svm.lasso.performance_per_regularization_novel(1,:))
    center_svm(k_dir)=mean(center.analysis_results_new(k_dir).linear_classifier.svm.lasso.performance_per_regularization_novel(1,:))
    
    uncenter_logistic(k_dir)=mean(uncentered.analysis_results_new(k_dir).linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:))
    center_logistic(k_dir)=mean(center.analysis_results_new(k_dir).linear_classifier.logistic.lasso.performance_per_regularization_novel(1,:))
end

figure,a=plot(uncenter_nn,center_nn,'ko'),set(a,'MarkerSize',24), hold on
axis([0 1 0 1])
axis square
[h,p]=ttest(uncenter_nn-center_nn)
text(0.8,0.2,['p=',num2str(p)])
plot([0 1],[0 1])
a=gca;set(a,'Box','off')
xlabel('Uncentered Z score')
ylabel('Centered Z score')
title('Supp Fig 5K, NN perf')

figure,a=plot(uncenter_svm,center_svm,'ko'),set(a,'MarkerSize',24), hold on
axis([0 1 0 1])
axis square
[h,p]=ttest(uncenter_svm-center_svm)
text(0.8,0.2,['p=',num2str(p)])
plot([0 1],[0 1])
a=gca,set(a,'Box','off')
xlabel('Uncentered Z score')
ylabel('Centered Z score')
title('Supp Fig 5H, SVM perf')


figure,a=plot(uncenter_logistic,center_logistic,'ko'),set(a,'MarkerSize',24), hold on
axis([0 1 0 1])
axis square
[h,p]=ttest(uncenter_logistic-center_logistic)
text(0.8,0.2,['p=',num2str(p)])
plot([0 1],[0 1])
a=gca,set(a,'XTickLabel',[]);set(a,'YTickLabel',[]);set(a,'Box','off')
xlabel('Uncentered Z score')
ylabel('Centered Z score')
title('Supp Fig E, logistic regressor perf')


% clear

% Plot an example of the centering
% Plot of the uncentered data

y_axis_ticks=1.5:1:15.5;


dir_to_use=11;
pretty_glom=73;

index_pretty=29
vial_struct=data_per_dir(index_pretty).all_vials_struct;

standard=find(vial_struct(:,2)==51);
novel=find(vial_struct(:,2)~=51);
reordered=[standard;novel];
reorder_df=data_per_dir(index_pretty).df(reordered,:);
reorder_df(reorder_df>z_score_threshold)=0;
training_data_go_1_no_go_m1=vial_struct(standard,3)<33;
testing_data_go_1_no_go_m1=vial_struct(novel,3)<33;



figure

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

AUC_standard=[];
AUC_novel=[];
for k=1:n_glom
    repeats_single_glom_standard_go_no_go=training_data_center(:,k);
    repeats_single_glom_novel_go_no_go=noisy_df_novel_center(:,k);
    [X,Y,g,AUC_standard(k),OPTROCPT] = perfcurve(training_data_go_1_no_go_m1,repeats_single_glom_standard_go_no_go,1);
    [X,Y,g,AUC_novel(k),OPTROCPT] = perfcurve(testing_data_go_1_no_go_m1,repeats_single_glom_novel_go_no_go,1);
end
rectified_auc=abs(AUC_standard-0.5)+0.5;
%figure,plot(rectified_auc)
[a,i]=max(rectified_auc);
%figure(777),plot(AUC_standard,'b');hold on,plot(AUC_novel,'r')
%X_tick=[1,i,n_glom];
X_tick=[];

figure
subplot(2,1,1),imagesc(training_data_center),caxis([min_color,max_color]);title('Supp Figure 5B Limonene')
a=gca;
set(a,'YTick',y_axis_ticks);
grid on
subplot(2,1,2),imagesc(noisy_df_novel_center),caxis([min_color,max_color]); ;title('Supp Figure 5B Methyl piruvate')
a=gca;
set(a,'YTick',y_axis_ticks);
xlabel('ROI number')
grid on

%Calculate the logistic linear classifier using centered data
training_data_go_1_no_go_m1=training_data_go_1_no_go_m1+0.0;
training_data_go_1_no_go_m1(training_data_go_1_no_go_m1==0)=-1;
[Mdl_log,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','logistic','Regularization','lasso','Lambda',0);
figure%a=plot(training_data_center*Mdl_log.Beta+Mdl_log.Bias,'bs'), set(a,'MarkerSize',24), set(a,'LineWidth',2)
hold on,a=plot(noisy_df_novel_center*Mdl_log.Beta+Mdl_log.Bias,'rs'),set(a,'MarkerSize',24),set(a,'LineWidth',2)
rango=max(abs(noisy_df_novel*Mdl_log.Beta+Mdl_log.Bias))+0.1;
a=gca;
axis square
set(a,'XLim',[0 16]), set(a,'YLim',[-rango +rango]);
set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('Logistic regressor output using centered data')
title('Supp Figure 5D')
xlabel('Go mixture                 NG mixture')
grid on

%Calculate the SVM linear classifier using centered data
[Mdl_svm,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','svm','Regularization','lasso','Lambda',0);
figure%a=plot(training_data_center*Mdl_svm.Beta+Mdl_svm.Bias,'bs'),set(a,'MarkerSize',24), set(a,'LineWidth',2)
hold on,a=plot(noisy_df_novel_center*Mdl_svm.Beta+Mdl_svm.Bias,'rs'),set(a,'MarkerSize',24), set(a,'LineWidth',2)
rango=max(abs(noisy_df_novel*Mdl_log.Beta+Mdl_log.Bias))+0.1;
a=gca;
axis square
set(a,'XLim',[0 16]), set(a,'YLim',[-rango +rango]);
set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('SVM regressor output using centered data')
title('Supp Figure 5G')
xlabel('Go mixture                 NG mixture')
grid on




% Do an example of the nearest neighbor, and mark the location of the
% nearest neighboir

similarity_matrix=training_data_center*noisy_df_novel_center';
figure,imagesc(similarity_matrix), hold on
for k_counter=1:16
    vector_to_check=similarity_matrix(:,k_counter);
    [peak,this_peak_index]=max(vector_to_check);
    %plot(k_counter,this_peak_index,'sk')
    a=rectangle('Position',[k_counter-0.5,this_peak_index-0.5,1,1])
    set(a,'LineWidth',4),
    set(a,'EdgeColor','r')
end
axis square
a=gca
set(a,'Xtick',[1 8 9 16])
xlabel('Go test mixture                 NG test mixture')
set(a,'Ytick',[1 8 9 16])
ylabel('Go train mixture                 NG train mixture')
title('Supp Fig 5J')


%%%%%%%%%%%%%%%%%%Uncentered plots
noisy_df_novel(testing_data>z_score_threshold)=0;
training_data(training_data>z_score_threshold)=0;

figure
low_value=min([min(min(noisy_df_novel)),min(min(training_data))]);
subplot(2,1,1),imagesc(training_data); caxis([low_value,0])
subplot(2,1,2),imagesc(noisy_df_novel); caxis([low_value,0])
colorbar

figure
subplot(2,1,1),imagesc(training_data); caxis([low_value,0]),title('Supp Fig 5A limonene')
a=gca;
set(a,'YTick',y_axis_ticks);
grid on
subplot(2,1,2),subplot(2,1,2),imagesc(noisy_df_novel); caxis([low_value,0]),title('Supp Fig 5A Methyl Piruvate'),
xlabel('Roi  Number')
a=gca;set(a,'YTick',y_axis_ticks);
grid on


%%%%%% Linear logistic  with the uncentered
[Mdl_log,FitInfo] = fitclinear(training_data,training_data_go_1_no_go_m1,'Learner','logistic','Regularization','lasso','Lambda',0);
figure%a=plot(training_data*Mdl_log.Beta+Mdl_log.Bias,'bs'), set(a,'MarkerSize',24), set(a,'LineWidth',2)
hold on,a=plot(noisy_df_novel*Mdl_log.Beta+Mdl_log.Bias,'rs'),set(a,'MarkerSize',24),set(a,'LineWidth',2)
rango=max(abs(noisy_df_novel*Mdl_log.Beta+Mdl_log.Bias))+0.1;
a=gca;
axis square
axis square
set(a,'XLim',[0 16]), set(a,'YLim',[-rango +rango]);
set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('Logistic regressor output using uncentered data')
title('Supp Figure 5C')
xlabel('Go mixture                 NG mixture')
grid on



[Mdl_svm,FitInfo] = fitclinear(training_data,training_data_go_1_no_go_m1,'Learner','svm','Regularization','lasso','Lambda',0);
figure
a=plot(noisy_df_novel*Mdl_svm.Beta+Mdl_svm.Bias,'rs'),set(a,'MarkerSize',24), set(a,'LineWidth',2)
rango=max(abs(noisy_df_novel*Mdl_svm.Beta+Mdl_svm.Bias))+0.1;
a=gca;
axis square
set(a,'XLim',[0 16]), set(a,'YLim',[-rango +rango]);set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Box','off')
set(a,'XLim',[0 16])
set(a,'Xtick',[1 8 9 16])
set(a,'XGrid','on')
set(a,'Box','off')
ylabel('SVMregressor output using uncentered data')
title('Supp Figure 5F')
xlabel('Go mixture                 NG mixture')
grid on


% Do an example of the nearest neighbor, and mark the location of the
% nearest neighboir

similarity_matrix=training_data*noisy_df_novel';
figure,imagesc(similarity_matrix), hold on
for k_counter=1:16
    vector_to_check=similarity_matrix(:,k_counter);
    [peak,this_peak_index]=max(vector_to_check);
    %plot(k_counter,this_peak_index,'sk')
    a=rectangle('Position',[k_counter-0.5,this_peak_index-0.5,1,1])
    set(a,'LineWidth',4),
    set(a,'EdgeColor','r')
end
axis square

a=gca
set(a,'Xtick',[1 8 9 16])
xlabel('Go test mixture                 NG test mixture')
set(a,'Ytick',[1 8 9 16])
ylabel('Go train mixture                 NG train mixture')
title('Supp Fig 5I uncentered')

