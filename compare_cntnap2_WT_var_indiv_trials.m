% Create plots of the variability  of cntnap2 and WT
% Supplementary  Figure 12D and Figure 8C
load  compare_cntnap2_WT_var_indiv_trials

% Plot of the uncorrelated variability of the cntnap2 mice and compare it
% to the variability of the WT
% Supplementary  Figure 12D
figure,hold on,
u=plot_cloud_of_points(WT.uncorr_mean,WT.uncorr_std,50,1/200)
%Also plot the fit
ft = fittype({'1','x.^2'});   % This is the fit I will use
f_uncorr=fit(WT.uncorr_mean,...
      WT.uncorr_std'.^2,...
      ft);
model_fit=ft(f_uncorr.a,f_uncorr.b,-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit),'m'), set(u,'LineWidth',2)
% Get the confidence intervals of the fit:
intervals_fit=confint(f_uncorr);
model_fit_low=ft(intervals_fit(1,1),intervals_fit(1,2),-10:0.1:0);
model_fit_high=ft(intervals_fit(2,1),intervals_fit(2,2),-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit_low),'m:'), set(u,'LineWidth',2)
u=plot(-10:0.1:0,sqrt(model_fit_high),'m:'), set(u,'LineWidth',2)

u=plot_cloud_of_points(cntnap2.uncorr_mean,cntnap2.uncorr_std,50,1/100)
for k=1:length(u)
    set(u{k},'Color','r')
end
%set(u,'MarkerSize',24)
% actually. it is the same fit

f_uncorr=fit(cntnap2.uncorr_mean,...
      cntnap2.uncorr_std'.^2,...
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
title('Supplementary Figure 12D')
xlabel('Average z-score(?)')
ylabel('Trial to trial uncorrelated variability (?uncorr)')
title('Supplementary figure 12D')


% Plot of all the variabilities of the WT and Cntnap2 (correlated and uncorrealted)
% Figure 8C
figure,hold on
u=plot_cloud_of_points(WT.all_mean_corr_and_uncorr,WT.all_std_corr_and_uncorr,50,1/100)
for k=1:length(u)
    set(u{k},'MarkerSize',24)
end
f=fit(WT.all_mean_corr_and_uncorr(WT.all_mean_corr_and_uncorr<10),...
      ((WT.all_std_corr_and_uncorr(WT.all_mean_corr_and_uncorr<10))).^2,...
      ft);
model_fit=ft(f.a,f.b,-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit),'m'), set(u,'LineWidth',2)
intervals_fit=confint(f);
model_fit_low=ft(intervals_fit(1,1),intervals_fit(1,2),-10:0.1:0);
model_fit_high=ft(intervals_fit(2,1),intervals_fit(2,2),-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit_low),'m:'), set(u,'LineWidth',2)
u=plot(-10:0.1:0,sqrt(model_fit_high),'m:'), set(u,'LineWidth',2)
a=gca
set(a,'XLim',[-9 1]),set(a,'YLim',[0 3.5])

%Add in red the variabilities of the cntnap2 animals 
hold on
u=plot_cloud_of_points(cntnap2.all_mean_corr_and_uncorr,cntnap2.all_std_corr_and_uncorr,50,1/50)
for k=1:length(u)
    set(u{k},'MarkerSize',24);
    set(u{k},'Color','r');
end
f=fit(cntnap2.all_mean_corr_and_uncorr(WT.all_mean_corr_and_uncorr<10),...
      ((cntnap2.all_std_corr_and_uncorr(WT.all_mean_corr_and_uncorr<10))).^2,...
      ft);
model_fit=ft(f.a,f.b,-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit),'m'), set(u,'LineWidth',2)
intervals_fit=confint(f);
model_fit_low=ft(intervals_fit(1,1),intervals_fit(1,2),-10:0.1:0);
model_fit_high=ft(intervals_fit(2,1),intervals_fit(2,2),-10:0.1:0);
u=plot(-10:0.1:0,sqrt(model_fit_low),'m:'), set(u,'LineWidth',2)
u=plot(-10:0.1:0,sqrt(model_fit_high),'m:'), set(u,'LineWidth',2)
xlabel('Average z-score(?)')
ylabel('Trial to trial variability (?)')
title('Figure 8C')



 



