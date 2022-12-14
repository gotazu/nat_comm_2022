load calculate_zscore_variation_from_individual_trials_cntnap2

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
%        all_responses_dir_odor{k_dir,k_odor}=response; % Save all the responses to put a nice example of cntnap2        
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

% Create the line example showing that responses across glomeruli are
% correlated to each other, and second do the line fitting from Mathis et
% al, above code
response=all_responses_dir_odor{4,5};
%Supplementary Figure 12B
figure,u=plot(response(74,:),response(84,:),'ko')
axis([-10 4 -10 2])
set(u,'MarkerSize',12)
a=gca
set(a,'Box','off')
xlabel('Single trial response ROI 74 (Z-score)')
ylabel('Single trial response ROI 84(Z-score)')
title('Supplementary Figure 12B')

% Plot of the lines like Mathis et al Supplementary Figure 12C
mean_value_display=mean(response,2);
%example_responses=response(:,[6,15,4])
example_responses=response(:,[4,14])
colores=['kg'];

figure,hold on
for k=1:length(colores)
    u=plot(mean_value_display,example_responses(:,k),[colores(k),'.']);
    set(u,'MarkerSize',30)
    sel=mean_value_display<0;
    pp=polyfit(mean_value_display(sel),example_responses(sel,k),1);
    qq=polyval(pp,mean_value_display);
    u=plot(mean_value_display,qq,colores(k))
    set(u,'LineWidth',2)
end
a=gca
set(a,'Box','off')
xlabel('Average response (Z-score)')
ylabel('Single trial responses (Z-score)')
title('Supplementary Figure 12C')
