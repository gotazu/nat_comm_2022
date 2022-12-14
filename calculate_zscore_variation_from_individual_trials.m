% dir_with_single_trial_roi_response{1}=('E:\Gonzalo Imagin Experiments Good\reanalyzed_data_10262018\all_odors_0814\small files');
% dir_with_single_trial_roi_response{2}=('E:\Gonzalo Imagin Experiments Good\reanalyzed_data_10262018\all_odors_animal_4');
% dir_with_single_trial_roi_response{3}=('E:\Gonzalo Imagin Experiments Good\reanalyzed_data_10262018\animal_4_11132018_cineole_M311_novel_M1_3_M1_4');
% 
% index_air_period=(280-5*40):280;%index_air_period=11:270;
% 
% matrix_mean_value_bonito=[];
% matrix_std_matrix_error_line_fit=[];
% 
% for k_dir=1:length(dir_with_single_trial_roi_response)
%     cd(dir_with_single_trial_roi_response{k_dir}) 
%     clear odor_mix odor_mix_to_save
%     load('odor_mix_individual_frame_correction')
%     odor_mix=odor_mix_to_save;
%     %
%     A=1;
%     B=ones(1,10)/10; % Filter the signal
%     index_odor_response=(280+2*40):640;  % From 2 to end secons is where I calculate the average response
%     var_matrix_odor_roi=zeros(length(odor_mix),length(sROI));
%     mean_matrix_odor_roi=zeros(length(odor_mix),length(sROI));
%     odor_onset_frame=floor(7.121*40);
%     for k_odor=1:length(odor_mix)
%         this_odor_mix=odor_mix(k_odor);
%         response=NaN(length(sROI),length(this_odor_mix.file_roi_reads) );
%         for k_odor_presentation=1:length(this_odor_mix.file_roi_reads)
%             m=this_odor_mix.file_roi_reads{k_odor_presentation};
%             [number_analyzed_roi,trash]=size(m);
%             
%             %for k_roi_counter=1:length(sROI)
%             for k_roi_counter=1:number_analyzed_roi
%                 vector=m(k_roi_counter,:);
%                 filtrado=filter(B,A,vector);
%                 filtrado=(filtrado-mean(filtrado(index_air_period)))/std(filtrado(index_air_period));
%                 response(k_roi_counter,k_odor_presentation)=mean(filtrado(index_odor_response));
%             end
%         end
%         % Check the correlation of the response: that is fit to a line in
%         % the plot mean value response for each roi against the mean roi
%         % response. We then calculate the std for each roi for each odor,
%         % and we report that std
%         bonito=find(mean(response')<-0); % Index of the glom that have a decent average response to this odor
%         if length(bonito>4)  % At least 4 responses to have a good estimate of the line
%             mean_value_bonito=mean(response(bonito,:),2);
%             % for each repeat plot the mean verus the repeat
%             %figure,hold on
%             matrix_error_line_fit=zeros(length(bonito),length(this_odor_mix.file_roi_reads));
%             for k_odor_presentation=1:length(this_odor_mix.file_roi_reads)
%                 %plot(mean_value_bonito,response(bonito,k_odor_presentation))
%                 % Do the linear fit a lo Mathis
%                 P = polyfit(mean_value_bonito,response(bonito,k_odor_presentation),1);
%                 Y = polyval(P,mean_value_bonito);
%                 error_respect_line_fit=(Y-response(bonito,k_odor_presentation));
%                 matrix_error_line_fit(:,k_odor_presentation)=error_respect_line_fit;
%             end
%             %figure(21),hold on,plot(mean_value_bonito,std(matrix_error_line_fit'),'k.')
%             roi_odor_std=std(matrix_error_line_fit');
%             matrix_mean_value_bonito=[matrix_mean_value_bonito;mean_value_bonito];
%             matrix_std_matrix_error_line_fit=[matrix_std_matrix_error_line_fit,roi_odor_std];
%             
%         end
%         
%         
%         mean_matrix_odor_roi(k_odor,:)=mean(response');
%         var_matrix_odor_roi(k_odor,:)=var(response');
%     end
%     results(k_dir).mean_matrix_odor_roi=mean_matrix_odor_roi;
%     results(k_dir).var_matrix_odor_roi=var_matrix_odor_roi;
% end

load  calculate_zscore_variation_from_individual_trials
% Create the line example showing that responses across glomeruli are
% correlated to each other, and plot the uncorr var from Mathis et al
% using the above commented code

% Plot Supp. Figure 3B
figure,u=plot(response(15,:),response(7,:),'ko')
xlabel('Single trial response ROI 15 (z-score)')
ylabel('Single trial response ROI 7 (z-score)')
title('Supp Figure 3B')
axis([-12 2 -12 2])
set(u,'MarkerSize',12)
a=gca
set(a,'Box','off')


% Plot of the lines like Mathis et al 
% supplementary figure 3C
mean_value_display=mean(response,2);
%example_responses=response(:,[6,15,4])
example_responses=response(:,[6,15])
colores=['kg'];
figure,hold on
for k=1:length(colores)
    u=plot(mean_value_display,example_responses(:,k),[colores(k),'.']);
    set(u,'MarkerSize',30)
    sel=mean_value_display<-1;
    pp=polyfit(mean_value_display(sel),example_responses(sel,k),1);
    qq=polyval(pp,mean_value_display);
    u=plot(mean_value_display,qq,colores(k))
    set(u,'LineWidth',2)
end
a=gca
set(a,'Box','off')
xlabel('Average z-score(?)')
ylabel('Single trial responses (Z-score)')
title(' Supp Figure 3C')


% Plot of the uncorrelated variability Supp Figure 3D for WT mice
figure%u=plot(matrix_mean_value_bonito,(matrix_std_matrix_error_line_fit),'k.'), hold on
        plot_cloud_of_points(matrix_mean_value_bonito,matrix_std_matrix_error_line_fit,50,1/200)
%set(u,'MarkerSize',24)
% actually. it is the same fit
ft = fittype({'1','x.^2'});   % This is the fit I will use
f_uncorr=fit(matrix_mean_value_bonito(matrix_mean_value_bonito<0),...
      (matrix_std_matrix_error_line_fit(matrix_mean_value_bonito<0)').^2,...
      ft);
model_fit=ft(f_uncorr.a,f_uncorr.b,-10:0.1:0);

u=plot(-10:0.1:0,sqrt(model_fit),'m'), set(u,'LineWidth',2)
% Get the confidence intervals of the fit:
intervals_fit=confint(f_uncorr);
model_fit_low=ft(intervals_fit(1,1),intervals_fit(1,2),-10:0.1:0);
model_fit_high=ft(intervals_fit(2,1),intervals_fit(2,2),-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit_low),'m:'), set(u,'LineWidth',2)
u=plot(-10:0.1:0,sqrt(model_fit_high),'m:'), set(u,'LineWidth',2)
a=gca
set(a,'XLim',[-9 0]),set(a,'YLim',[0 3])
set(a,'Box','off')
xlabel('Average z-score(?)')
ylabel('Trial to trial uncorrelated variability (?uncorr)')
title('Supplementary Figure 3D')







all_mean_matrix_odor_roi=[];
all_var_matrix_odor_roi=[];
% Fit the coefficient of variation
upper_limit=[10 [0:-0.5:-8] ];
lower_limit=[0 ([0:-0.5:-8]-0.5)];
% upper_limit=[10 0 -0.25 -0.5 -0.75 -1 -1.25 -1.5 -1.75 ];
% lower_limit=[0 -0.25 -0.5 -0.75 -1 -1.25 -1.5 -1.75 -10];


% Do the analysis of the individual recording sessions variability against
% the mean response Figure 1I
figure,hold on
ft = fittype({'1','x.^2'});   % This is the fit I will use
%ft = fittype('a+b*x.^2','problem','a', 'independent','x');

all_animals_vector_var_matrix_odor_roi=[];
all_animals_vector_mean_matrix_odor_roi=[];

fit_counter=1;

for k_dir=1:length(dir_with_single_trial_roi_response)
    this_mean_matrix=results(k_dir).mean_matrix_odor_roi;
    this_var_matrix=results(k_dir).var_matrix_odor_roi;
    selection_good_response_roi=(sum(this_mean_matrix<-2)>0);
    number_roi_actually_used(k_dir)=sum(selection_good_response_roi);
    %plot(this_mean_matrix(:,selection_good_response_roi),this_var_matrix(:,selection_good_response_roi),'k.')
    
    % Only include the good responses
    good_mean_matrix=this_mean_matrix(:,selection_good_response_roi);
    good_var_matrix=this_var_matrix(:,selection_good_response_roi);
    [n_odors,n_rois]=size(good_mean_matrix);
    vector_mean_matrix_odor_roi=reshape(good_mean_matrix,1,n_odors*n_rois);
    vector_var_matrix_odor_roi=reshape( good_var_matrix,1,n_odors*n_rois);
   
    all_animals_vector_mean_matrix_odor_roi=[all_animals_vector_mean_matrix_odor_roi,vector_mean_matrix_odor_roi];
    all_animals_vector_var_matrix_odor_roi=[all_animals_vector_var_matrix_odor_roi,vector_var_matrix_odor_roi];   
end


figure,hold on
%u=plot(all_animals_vector_mean_matrix_odor_roi',sqrt(all_animals_vector_var_matrix_odor_roi'),'k.');
u=plot_cloud_of_points(all_animals_vector_mean_matrix_odor_roi',sqrt(all_animals_vector_var_matrix_odor_roi'),50,1/100)
for k=1:length(u)
    set(u{k},'MarkerSize',18)
end

f=fit(all_animals_vector_mean_matrix_odor_roi(all_animals_vector_mean_matrix_odor_roi<10)',...
      (all_animals_vector_var_matrix_odor_roi(all_animals_vector_mean_matrix_odor_roi<10)'),...
      ft);

model_fit=ft(f.a,f.b,-10:0.1:0);

u=plot(-10:0.1:0,sqrt(model_fit),'m'), set(u,'LineWidth',2)
% Get the confidence intervals of the fit:
intervals_fit=confint(f);
model_fit_low=ft(intervals_fit(1,1),intervals_fit(1,2),-10:0.1:0);
model_fit_high=ft(intervals_fit(2,1),intervals_fit(2,2),-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit_low),'m:'), set(u,'LineWidth',2)
u=plot(-10:0.1:0,sqrt(model_fit_high),'m:'), set(u,'LineWidth',2)
a=gca
set(a,'XLim',[-9 1]),set(a,'YLim',[0 3.5])
title('Figure 1I')
xlabel('Average z-score(?)')
ylabel('Trial to trial variability (?)')




