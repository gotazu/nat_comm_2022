% cd('E:\Gonzalo Imagin Experiments Good\reanalyzed_data_10262018\all_odors_animal_4')
% %load('odor_mix_individual_frame');
% load ('odor_mix_individual_frame_correction')
% cd('C:\NYIT Data\captcha_paper\nat_comm_revisions\na_comm_third_round_revisions\Figure_creating_m_files')
% save plots_individual_trials


% Create example plots 1GH
load plots_individual_trials

odor_mix(18) % check_roi 50
matrix_propyl_butyrate=zeros(length(odor_mix(18).file_roi_reads),640);
A=1;
B=ones(1,10)/10;
odors_for_plotting=[18 18 5 5]
roi_for_plotting=[2 42 1 50]
odor_onset_frame=floor(7.121*40);

threshold_level=-0.42;
odor_period_s=[2 9];
air_period_s=[-5 0];

odor_period_frame=floor(odor_period_s*40+odor_onset_frame);
air_period_frame=floor(air_period_s*40+odor_onset_frame);


for k_roi_counter=1:length(roi_for_plotting)
    this_odor=odors_for_plotting(k_roi_counter);
    this_roi=roi_for_plotting(k_roi_counter);
    n_samples=length(odor_mix(this_odor).file_roi_reads);
    clear matrix_odor_roi
    for k=1:n_samples
        m=odor_mix(this_odor).file_roi_reads{k};
        vector=m(this_roi,:);
        filtrado=filter(B,A,vector);
        filtrado=(filtrado-mean(filtrado(11:270)))/std(filtrado(11:270));
        matrix_odor_roi(k,:)=filtrado;
    end
    figure
    a=subplot(2,1,1)
    
    imagesc(matrix_odor_roi(:,1:end)), hold on
    set(a,'XLim',[81 640]) , hold on
    points_of_seconds=union([284:-40:1],[284:40:640])
    set(a,'XTick', points_of_seconds);
    set(a,'XTickLabel', []);
%     set(a,'YTickLabel',[]);
    set(a,'Box','off')
    
    a=plot([odor_onset_frame odor_onset_frame], [0.5 n_samples+0.5] ,'m:')
    set(a,'LineWidth',2)
    caxis([-10 2])  
    
    
    a=subplot(2,1,2)
    plot(mean(matrix_odor_roi(:,1:end)))
    title(['Fig 1GH',' roi=',num2str(this_roi)])
    axis([81 640 -5 1])
    set(a,'XTick', points_of_seconds);
    set(a,'XTickLabel', []);
    set(a,'Box','off')
    %set(a,'YTickLabel',[]);
    %axis off
    hold on
    a=plot([odor_onset_frame odor_onset_frame], [-5 1],'m:' )
    set(a,'LineWidth',2)
    
    a=plot([odor_period_frame], [-1 -1],'r' )
    set(a,'LineWidth',1)
    
    a=plot([air_period_frame], [0 0],'g' )
    set(a,'LineWidth',1)
    
    a=plot([81 640], [threshold_level threshold_level],'k:' )
    set(a,'LineWidth',2)
    
end
