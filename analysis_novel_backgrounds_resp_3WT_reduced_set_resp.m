load analysis_novel_backgrounds_with_respiration_3WT_reduced_set_resp
time_sec=((1:12501)-7000)/1000;

rate_standard=create_inh_psth(breathing_rate_standard_trial)*1000;
figure(5555),hold on,a=plot(time_sec,nanmean(rate_standard),'b')
set(a,'LineWidth',2)
hold on
[number_traces_used,number_points]=size(breathing_rate_standard_trial);
a=plot(time_sec,nanmean(rate_standard)+nanstd(rate_standard)/sqrt(number_traces_used),'b:'),set(a,'LineWidth',2)
a=plot(time_sec,nanmean(rate_standard)-nanstd(rate_standard)/sqrt(number_traces_used),'b:'),set(a,'LineWidth',2)

rate_novel=create_inh_psth(breathing_rate_novel_trial)*1000;
a=plot(time_sec,nanmean(rate_novel),'g'),set(a,'LineWidth',2)
[number_traces_used,number_points]=size(breathing_rate_novel_trial);
a=plot(time_sec,nanmean(rate_novel)-nanstd(rate_novel)/sqrt(number_traces_used),'g:'),set(a,'LineWidth',2)
a=plot(time_sec,nanmean(rate_novel)+nanstd(rate_novel)/sqrt(number_traces_used),'g:'),set(a,'LineWidth',2)
axis([-1 4.5 0 8])
a=plot([0 0],[0 8],'k'),set(a,'LineWidth',2)
a=plot([0.75 0.75],[0 8],'m'),set(a,'LineWidth',2)
a=plot([1.5 1.5],[0 8],'c'),set(a,'LineWidth',2)
ss=gca;
set(ss,'YTick',[0 2 4 6 8])
%set(ss,'YTickLabel',[])
set(ss,'XTick',[0 0.75 1.5 3 4])
%set(ss,'XTickLabel',[])
set(ss,'Box','off')

%load analysis_novel_backgrounds_with_respiration_4_animals

load analysis_novel_backgrounds_with_respiration_4_cntnap2_animals
time_sec=((1:12501)-7000)/1000;

rate_standard=create_inh_psth(breathing_rate_standard_trial)*1000;
figure(5555),a=plot(time_sec,nanmean(rate_standard),'k')
set(a,'LineWidth',2)
hold on
[number_traces_used,number_points]=size(breathing_rate_standard_trial);
a=plot(time_sec,nanmean(rate_standard)+nanstd(rate_standard)/sqrt(number_traces_used),'k:'),set(a,'LineWidth',2)
a=plot(time_sec,nanmean(rate_standard)-nanstd(rate_standard)/sqrt(number_traces_used),'k:'),set(a,'LineWidth',2)

rate_novel=create_inh_psth(breathing_rate_novel_trial)*1000;
a=plot(time_sec,nanmean(rate_novel),'m'),set(a,'LineWidth',2)
[number_traces_used,number_points]=size(breathing_rate_novel_trial);
a=plot(time_sec,nanmean(rate_novel)-nanstd(rate_novel)/sqrt(number_traces_used),'m:'),set(a,'LineWidth',2)
a=plot(time_sec,nanmean(rate_novel)+nanstd(rate_novel)/sqrt(number_traces_used),'m:'),set(a,'LineWidth',2)
axis([-1 4.5 0 8])
a=plot([0 0],[0 8],'k'),set(a,'LineWidth',2)
a=plot([0.75 0.75],[0 8],'m'),set(a,'LineWidth',2)
a=plot([1.5 1.5],[0 8],'c'),set(a,'LineWidth',2)
ss=gca;
set(ss,'YTick',[0 2 4 6 8])
%set(ss,'YTickLabel',[])
set(ss,'XTick',[0 0.75 1.5 3 4])
%set(ss,'XTickLabel',[])
xlabel('Stimulus Onset')
ylabel('Sniffs per second')
title('Figure 10I')
