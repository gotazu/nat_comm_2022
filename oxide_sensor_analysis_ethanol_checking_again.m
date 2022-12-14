load oxide_sensor_analysis_ethanol_checking_again
% plot to estimate the fast delay from snout valve opening to odor delivery

figure,plot(-matrix_responses,'k')
a=gca
set(a,'XTick',[7000 7121]),set(a,'XTickLabel',{'0', '121'}) 
xlabel('time from snout valve opening(ms)')
ylabel('Volts')
title('Supp Figure 2B')
axis([6800 7350 1.24 1.40])

% Calculate the deflection of the odor
base_noise=matrix_responses(6999,:);%base_noise=matrix_responses(6990:7000,50:250);
[r,s]=size(base_noise);
noise_as_vector=reshape(base_noise,r*s,1);
for k=7000:7300
    %[h,p(k)]=ttest(matrix_responses(k,50:250)-noise_as_vector, 'Tail','left');    
    [h,p(k)]=ttest((matrix_responses(k,:)-base_noise)');    
end




