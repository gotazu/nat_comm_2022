% Plot of reaction time for the WT animals doing the reduced training task
load analysis_novel_backgrounds_with_respiration_3WT_reduced_set_resp
time_sec=((1:12501)-7000)/1000;
% Do the analysis of the reaction times
[animals,sessions]=size(all_data_standard_reaction_time_correct);
all_animal_all_sessions_reaction_time_correct_standard=[];
all_animal_all_sessions_reaction_time_correct_novel=[];
all_animal_all_sessions_reaction_time_incorrect_standard=[];
all_animal_all_sessions_reaction_time_incorrect_novel=[];

for k_animals=1:animals
    for k_sessions=1:sessions
        all_animal_all_sessions_reaction_time_correct_standard=[all_animal_all_sessions_reaction_time_correct_standard,all_data_standard_reaction_time_correct{k_animals,k_sessions}];
        all_animal_all_sessions_reaction_time_correct_novel=[all_animal_all_sessions_reaction_time_correct_novel,all_data_novel_reaction_time_correct{k_animals,k_sessions}];
        all_animal_all_sessions_reaction_time_incorrect_standard=[all_animal_all_sessions_reaction_time_incorrect_standard,all_data_standard_reaction_time_incorrect{k_animals,k_sessions}];
        all_animal_all_sessions_reaction_time_incorrect_novel=[all_animal_all_sessions_reaction_time_incorrect_novel,all_data_novel_reaction_time_incorrect{k_animals,k_sessions}];              
    end
end

% Remove the NaN as the correspond to no go stimuli
all_animal_all_sessions_reaction_time_correct_novel=all_animal_all_sessions_reaction_time_correct_novel(~isnan(all_animal_all_sessions_reaction_time_correct_novel));
all_animal_all_sessions_reaction_time_correct_standard=all_animal_all_sessions_reaction_time_correct_standard(~isnan(all_animal_all_sessions_reaction_time_correct_standard));

rt_sniffs_before_novel_reaction=rt_sniffs_before_novel_reaction(~isnan(rt_sniffs_before_novel_reaction))/1000;
rt_sniffs_before_standard_reaction=rt_sniffs_before_standard_reaction(~isnan(rt_sniffs_before_standard_reaction))/1000;

rt_sniffs_before_novel_reaction=rt_sniffs_before_novel_reaction(~isnan(rt_sniffs_before_novel_reaction));
rt_sniffs_before_standard_reaction=rt_sniffs_before_standard_reaction(~isnan(rt_sniffs_before_standard_reaction));

figure, hold on
bar(1,mean(rt_sniffs_before_standard_reaction),'b')
bar(3,mean(rt_sniffs_before_novel_reaction),'r')
n_standard_trials=length(rt_sniffs_before_standard_reaction);
n_novel_trials=length(rt_sniffs_before_novel_reaction);
a=errorbar(1,mean(rt_sniffs_before_standard_reaction),std(rt_sniffs_before_standard_reaction)/sqrt(n_standard_trials),'k');set(a,'LineWidth',2)
a=errorbar(3,mean(rt_sniffs_before_novel_reaction),std(rt_sniffs_before_novel_reaction)/sqrt(n_novel_trials),'k');set(a,'LineWidth',2)
ss=gca;
set(ss,'YTick',[0.2 0.4 0.6 0.8])
set(ss,'XTick',[1,3])
set(ss,'XTickLabel',{'WT known','WT novel'})
ylabel('Lick Response Latency')
% I will add the individual animals reaction times
all_data_rt_sniffs_before_novel_reaction;
all_data_rt_sniffs_before_standard_reaction;
for k_dir=1:length(directories_to_check)
    per_animal_rt_novel(k_dir)=nanmean([all_data_rt_sniffs_before_novel_reaction{k_dir,1},all_data_rt_sniffs_before_novel_reaction{k_dir,2},all_data_rt_sniffs_before_novel_reaction{k_dir,3}]);
    per_animal_rt_standard(k_dir)=nanmean([all_data_rt_sniffs_before_standard_reaction{k_dir,1},all_data_rt_sniffs_before_standard_reaction{k_dir,2},all_data_rt_sniffs_before_standard_reaction{k_dir,3}]);
end
a=plot([1,3],[per_animal_rt_standard/1000;per_animal_rt_novel/1000],'k');
set(a,'Marker','s'),set(a,'MarkerSize',12)
ranksum(rt_sniffs_before_standard_reaction,rt_sniffs_before_novel_reaction)










