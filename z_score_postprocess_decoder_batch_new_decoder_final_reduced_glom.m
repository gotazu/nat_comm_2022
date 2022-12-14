load z_score_postprocess_decoder_batch_new_decoder_final_reduced_glom

z_score_threshold=-0.42;
decoding_standard_threshold=0.6;
repeats_per_presentation=100; % We use this to calcualte the sginificance of the difference in the correlation between behavior and NN and behavior and the linear models and behavior;
CV=0.25; %coefficient of variation to unocrrelated noise
for k_dir=1:length(data_per_dir)
    number_odors_used(k_dir)=length(data_per_dir(k_dir).odor_mix);
end

y_axis_ticks=1.5:1:15.5;

index_pretty=29;%n_32(k_dir);
vial_struct=data_per_dir(index_pretty).all_vials_struct;

standard=find(vial_struct(:,2)==51);
novel=find(vial_struct(:,2)~=51);
reordered=[standard;novel];
reorder_df=data_per_dir(index_pretty).df(reordered,:);
reorder_df(reorder_df>z_score_threshold)=0;
training_data_go_1_no_go_m1=vial_struct(standard,3)<33;
testing_data_go_1_no_go_m1=vial_struct(novel,3)<33;



%figure

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

figure
subplot(2,1,1),imagesc(training_data_center),caxis([min_color,max_color]);
a=gca;
set(a,'YTick',y_axis_ticks);;
grid on
subplot(2,1,2),imagesc(noisy_df_novel_center),caxis([min_color,max_color]);
a=gca;
set(a,'YTick',y_axis_ticks);
grid on

%Calculate the logistic classifier
lambda_to_use=[0  0.05 0.1] ;
training_data_go_1_no_go_m1=training_data_go_1_no_go_m1+0.000;
training_data_go_1_no_go_m1(training_data_go_1_no_go_m1==0)=-1;
max_plot=0.1;
min_plot=-0.1;
colors_to_use='gmkrb';
clear n_glom_used
for k_lambda=1:length(lambda_to_use)
    %[Mdl_log,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1);
    rng(2);
    [Mdl_log,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','logistic','Regularization','lasso','Lambda',lambda_to_use(k_lambda), 'IterationLimit',4e5);
    figure(210),hold on, a=plot(Mdl_log.Beta,colors_to_use(k_lambda));
    title('Figure 4C')
    xlabel('Roi Number')
    ylabel('Logistic regresor weights')
    n_glom_used(k_lambda)=sum(Mdl_log.Beta~=0)
    set(a,'LineWidth',2);
    a=gca,set(a,'XLim',[0.5 n_glom+0.5]);
    
    
    fitted_to_standard=training_data_center*Mdl_log.Beta+Mdl_log.Bias;
    fitted_to_novel=noisy_df_novel_center*Mdl_log.Beta+Mdl_log.Bias;
    
    figure(200+k_lambda)%,a=plot(fitted_to_standard,'bs'), set(a,'MarkerSize',24), set(a,'LineWidth',2)
    hold on,a=plot(fitted_to_novel,'rs'),set(a,'MarkerSize',24),set(a,'LineWidth',2)
    a=gca;
    axis square
    set(a,'XLim',[0 16])
    set(a,'XTick',[1,8,9,16])
    
    set(a,'XGrid','on')
    set(a,'Box','off')
    %ylabel('Logistic regressor output')
    title(['Figure 4D lambda=',num2str(lambda_to_use(k_lambda))])
    xlabel('test Go mixture                 test NG mixture')
    ylabel('Logistic regressor output')
    
    %grid on
    set(a,'Box','off')
    
    max_plot=max([max_plot;fitted_to_novel]);
    max_plot=max([max_plot;fitted_to_standard]);
    min_plot=min([min_plot;fitted_to_novel]);
    min_plot=min([min_plot;fitted_to_standard]);
end
for k_lambda=1:length(lambda_to_use)
    figure(200+k_lambda),a=gca;
    set(a,'YLim',[min_plot,max_plot]);
end
figure(210)
legend('lambda=0','lambda=0.05','lambda=0.1')

%%%%%%%%%%%%SVM%%%%%%%%%%%%%%%%%%%%%%
%Calculate the SVM linear classifier
lambda_to_use=[0  0.1  0.2]
training_data_go_1_no_go_m1=training_data_go_1_no_go_m1+0.000;
training_data_go_1_no_go_m1(training_data_go_1_no_go_m1==0)=-1;
max_plot=0.1;
min_plot=-0.1;
colors_to_use='gmkrb';
clear n_glom_used
for k_lambda=1:length(lambda_to_use)
    %[Mdl_log,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1);
    rng(1);
    [Mdl_svm,FitInfo] = fitclinear(training_data_center,training_data_go_1_no_go_m1,'Learner','svm','Regularization','lasso','Lambda',lambda_to_use(k_lambda),'IterationLimit',4e5);
    figure(310),hold on, a=plot(Mdl_svm.Beta,colors_to_use(k_lambda));
    title('Figure 4A')
    xlabel('ROI number')
    ylabel('SVM regressor weights')
    
    n_glom_used(k_lambda)=sum(Mdl_svm.Beta~=0)
    set(a,'LineWidth',2);
    a=gca,set(a,'XLim',[0.5 n_glom+0.5]);
    
    fitted_to_standard=training_data_center*Mdl_svm.Beta+Mdl_svm.Bias;
    fitted_to_novel=noisy_df_novel_center*Mdl_svm.Beta+Mdl_svm.Bias;
    figure(300+k_lambda)%,a=plot(fitted_to_standard,'bs'), set(a,'MarkerSize',24), set(a,'LineWidth',2)
    hold on,a=plot(fitted_to_novel,'rs'),set(a,'MarkerSize',24),set(a,'LineWidth',2)
    a=gca;
    axis square
    set(a,'XLim',[0 16])
    
    set(a,'XTick',[1,8,9,16])
    xlabel('test Go mixture                 test NG mixture')
    
    set(a,'XGrid','on')
    set(a,'Box','off')
    %ylabel('Logistic regressor output')
    title(['Figure 4B lambda=',num2str(lambda_to_use(k_lambda))])
    xlabel('test Go mixture                 test NG mixture')
    ylabel('SVM regressor output')
    
    
    %grid on
    set(a,'Box','off')
    
    max_plot=max([max_plot;fitted_to_novel]);
    max_plot=max([max_plot;fitted_to_standard]);
    min_plot=min([min_plot;fitted_to_novel]);
    min_plot=min([min_plot;fitted_to_standard]);
end
for k_lambda=1:length(lambda_to_use)
    figure(300+k_lambda),a=gca;
    set(a,'YLim',[min_plot,max_plot]);
end

% Do an example of the nearest neighbor, and mark the location of the
% nearest neighboir
%Locate the most sensitives ROI from the  training set to threshold the
%number of glomeruli used

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




n_glom_nn=[];
rectifi_auc_thresholds=[0.5 0.55 0.6];
for k_recti_threshold=1:length(rectifi_auc_thresholds)
    selected_glom=rectified_auc>=rectifi_auc_thresholds(k_recti_threshold);
    n_glom_nn(k_recti_threshold)=sum(selected_glom);
    similarity_matrix=training_data_center(:,selected_glom)*noisy_df_novel_center(:,selected_glom)';
    figure(500+k_recti_threshold),imagesc(similarity_matrix), hold on
    for k_counter=1:16
        vector_to_check=similarity_matrix(:,k_counter);
        [peak,this_peak_index]=max(vector_to_check);
        %plot(k_counter,this_peak_index,'sk')
        a=rectangle('Position',[k_counter-0.5,this_peak_index-0.5,1,1])
        set(a,'LineWidth',4),
        set(a,'EdgeColor','r')
    end
    a=gca
    set(a,'Xtick',[1 8 9 16])
    xlabel('Go test mixture                 NG test mixture')
    set(a,'Ytick',[1 8 9 16])
    ylabel('Go train mixture                 NG train mixture')
    
    axis square
    title(['Fig 4E sel glom =',num2str(n_glom_nn(k_recti_threshold))])
end
