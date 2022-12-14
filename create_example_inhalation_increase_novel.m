
% Create figure 5D
load create_example_inhalation_increase_novel


 start_trace=(respiration.index_ttl_on(10)-20000);
 end_trace=(respiration.index_ttl_on(11)+20000);
resp_trace=respiration.respiration_filtered_50hz(start_trace : end_trace);


figure,a=plot(resp_trace)
set(a,'LineWidth',1)
start_standard=respiration.index_ttl_on(10)+7000-start_trace;
hold on
a=plot([start_standard start_standard],[-0.25 0.25],'k')
set(a,'LineWidth',2)
a=plot([start_standard start_standard]+750,[-0.25 0.25],'m')
set(a,'LineWidth',2)
a=plot([start_standard start_standard]+1500,[-0.25 0.25],'c')
set(a,'LineWidth',2)
plot([0 80000],[0 0],'k:')
lick_10=G_control.list_of_trial_analysis(10).lick_response_to_target_sec*1000+start_standard+1500;
a=plot([lick_10],[0.1],'kv')




start_novel=respiration.index_ttl_on(11)+7000-start_trace;
hold on
a=plot([start_novel start_novel],[-0.25 0.25],'k')
set(a,'LineWidth',2)
a=plot([start_novel start_novel]+750,[-0.25 0.25],'m')
set(a,'LineWidth',2)
a=plot([start_novel start_novel]+1500,[-0.25 0.25],'c')
set(a,'LineWidth',2)
axis([2.1e4 6.6e4 -0.2 0.2])
ss=gca;
start_11=55028-3000;
set(ss,'XTick',[2.4e4 3.1e4 start_11 start_11+0.7e4])
set(ss,'XTickLabel',[])
set(ss,'YTick',[-0.2 0 0.2])
set(ss,'YTickLabel',[])
axis([2.1e4 6.6e4 -0.2 0.2])
title('figure 5D')
%

% Use this other to zoom on the standard
% axis([2.4e4 3.1e4 -0.2 0.2])
% Use this other to zoom on the novel
% axis([start_11 start_11+0.7e4 -0.2 0.2])
