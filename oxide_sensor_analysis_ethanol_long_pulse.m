% File to plot and calculate the long delay of the odor machine from odor
% vial to animal snout
load oxide_sensor_analysis_ethanol_long_pulse
figure,plot(-matrix_responses(1:11500,:),'k')
a=gca
set(a,'XTick',[0,2408,7000,11500])
set(a,'XTickLabel',{'0','2.4','7','11.5'})
xlabel('Time in seconds from odor vial and snout valve opening')
ylabel('TGS 2620 Voltage (V)')
title('Supp Figure 2A')




% Calculate the deflection of the odor
base_noise=matrix_responses(1:2000,:);
[r,s]=size(base_noise);
noise_as_vector=reshape(base_noise,r*s,1);
for k=2000:4000
    [h,p(k)]=ttest2(matrix_responses(k,:),noise_as_vector, 'Tail','left');    
    %[h,p(k)]=ttest((matrix_responses(k,50:250)-base_noise)');    
end

%Calculate the coefficient of variation in the odor delivery period.
base_signal=matrix_responses(7000:11500,:);
[r,s]=size(base_signal);
signal_as_vector=reshape(base_signal,r*s,1);
nanstd(base_signal)/nanmean(base_signal)


