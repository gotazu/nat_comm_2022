cd('C:\NYIT Data\NYIT_imaging')
%load z_score_postprocess_decoder_batch_result_center_train data_per_dir
%load z_score_postprocess_decoder_batch_result_center_train_6_animals data_per_dir
%load z_score_postprocess_decoder_batch_result_center_train_5_animals data_per_dir
load z_score_postprocess_decoder_batch_result_center_train_6_animals data_per_dir
z_score_threshold=-0.42;
decoding_standard_threshold=0.6;
repeats_per_presentation=100; % We use this to calcualte the sginificance of the difference in the correlation between behavior and NN and behavior and the linear models and behavior;
CV=0.25; %coefficient of variation to unocrrelated noise
for k_dir=1:length(data_per_dir)
    
    %analysis_results_new(k_dir)=z_score_postprocess_decoder_analysis_different_decoders(data_per_dir(k_dir),z_score_threshold);
    %analysis_results_new(k_dir)=z_score_postprocess_decoder_analysis_non_param_decoder(data_per_dir(k_dir),z_score_threshold);
    %analysis_results_new(k_dir)=z_score_postprocess_decoder_analysis_non_param_decoder_noise_2(data_per_dir(k_dir),z_score_threshold,CV);
    correlation_results_new(k_dir)=z_score_postprocess_decoder_analysis_correlation_mixtures(data_per_dir(k_dir),z_score_threshold,CV);
    %analysis_results_just_signi(k_dir)=z_score_postprocess_decoder_analysis_calcu_signi_correl(data_per_dir(k_dir),z_score_threshold,CV,repeats_per_presentation)
    %     noisy(k_dir)=mean(analysis_results_new(k_dir).noisy_novel_testing_1_correct_0_error);
    %     clean(k_dir)=mean(analysis_results_new(k_dir).novel_testing_1_correct_0_error);
end

% Calculate the correlations from individual odors
files_indiv_animals{1}='z_score_postprocess_decoder_analysis_from_indiv_odors'
files_indiv_animals{2}='z_score_postprocess_decoder_analysis_from_indiv_odors_0814'

files_indiv_animals{3}='z_score_postprocess_decoder_analysis_from_indiv_odors_Thy1Gcamp6_win_061721'
files_indiv_animals{4}='z_score_postprocess_decoder_analysis_from_indiv_odors_bl6_rec_start_01142021'
files_indiv_animals{5}='z_score_postprocess_decoder_analysis_from_indiv_odors_bl6_rec_start_031921'

clear data
for k_files_indiv_animals=1:length(files_indiv_animals)
    %for k_files_indiv_animals=1:length(files_indiv_animals)
    cd('C:\NYIT Data\NYIT_behavioral_data')
    load(files_indiv_animals{k_files_indiv_animals},'df','all_vials_struct_measured')
    data.all_vials_struct=all_vials_struct_measured;
    data.df=df;
    correlation_result_just_targets(k_files_indiv_animals)=z_score_postprocess_decoder_analysis_correlation_targets(data,z_score_threshold,CV)
end



correlation_target_go_30_32_no_go_34_36_novel{4,4}=[];
correlation_target_go_30_32_no_go_34_36_standard{4,4}=[];
for k_dir=1:length(data_per_dir)
    for k=1:4
        for kk=1:4
            correlation_target_go_30_32_no_go_34_36_novel{k,kk}=[correlation_target_go_30_32_no_go_34_36_novel{k,kk},...
                correlation_results_new(k_dir).correlation_target_go_30_32_no_go_34_36_novel{k,kk}];
            correlation_target_go_30_32_no_go_34_36_standard{k,kk}=[correlation_target_go_30_32_no_go_34_36_standard{k,kk},...
                correlation_results_new(k_dir).correlation_target_go_30_32_no_go_34_36_standard{k,kk}];
        end
    end
end

% do the plot of the correlations between the 4 different targets

for k=1:4
    for kk=1:4
        average_correlation_target_go_30_32_no_go_34_36_novel(k,kk)=mean(correlation_target_go_30_32_no_go_34_36_novel{k,kk});
        average_correlation_target_go_30_32_no_go_34_36_standard(k,kk)=mean(correlation_target_go_30_32_no_go_34_36_standard{k,kk});
    end
end

figure,subplot(1,3,2),imagesc(average_correlation_target_go_30_32_no_go_34_36_standard),caxis([0.3 1])
title('Figure 1O corr target in stand back')
axis square


subplot(1,3,3),imagesc(average_correlation_target_go_30_32_no_go_34_36_novel),caxis([0.3 1])
title('Figure 1Q corr target in novel back')
axis square



all_single_target_correlations=[];
for k_files_indiv_animals=1:length(files_indiv_animals)
    all_single_target_correlations = cat(1,all_single_target_correlations,correlation_result_just_targets(k_files_indiv_animals).correlation_target_go_30_32_no_go_34_36);
end

subplot(1,3,1),imagesc(squeeze(mean(all_single_target_correlations)))
caxis([0.3 1])

title('Figure 1M target corr')
axis square