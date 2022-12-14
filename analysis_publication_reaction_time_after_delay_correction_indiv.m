% Do the reaction time analysis for both the synch and async case
%load analysis_publication_5_animals_sync
load analysis_publication_5_animals_sync_after_delay_correction
standard_presentation=all_animals.odor_id(:,2)==51;
day_1=all_animals.day_number==1;
good_day=all_animals.behavior_standard_performance>0.8;
first_presentation=(all_animals.odor_presentation_per_session==1)&day_1;

rt_novel_not_first_exposure=all_animals.rt_sniffs_before_reaction(~standard_presentation'&good_day&~first_presentation);
rt_novel_first_exposure=all_animals.rt_sniffs_before_reaction(~standard_presentation'&good_day&first_presentation);
rt_standard_trial_5_animals_sync=all_animals.rt_sniffs_before_reaction(standard_presentation&good_day');
rt_all_novel_trials_5_animals_sync=all_animals.rt_sniffs_before_reaction(~standard_presentation&good_day');

p_value_5_animals_sync=ranksum(rt_all_novel_trials_5_animals_sync,rt_standard_trial_5_animals_sync)

% Add the value of the 5 animals novel and standard odors 
for k_animal=1:length(unique(all_animals.kdir))
    this_animal=all_animals.kdir==k_animal;
    this_animal_rt_sniffs_before_reaction_standard=all_animals.rt_sniffs_before_reaction(standard_presentation&good_day'&this_animal');
    this_animal_rt_sniffs_before_reaction_novel=all_animals.rt_sniffs_before_reaction(~standard_presentation&good_day'&this_animal');
    sync_animal_rt_standard(k_animal)=nanmean(this_animal_rt_sniffs_before_reaction_standard);
    sync_animal_rt_novel(k_animal)=nanmean(this_animal_rt_sniffs_before_reaction_novel);
end


%load analysis_publication_4_animals
load analysis_publication_4_animals_after_delay_correction
standard_presentation=all_animals.odor_id(:,2)==51;
day_1=all_animals.day_number==1;
good_day=all_animals.behavior_standard_performance>0.8;
first_presentation=(all_animals.odor_presentation_per_session==1)&day_1;

rt_novel_not_first_exposure=all_animals.rt_sniffs_before_reaction(~standard_presentation'&good_day&~first_presentation);
rt_novel_first_exposure=all_animals.rt_sniffs_before_reaction(~standard_presentation'&good_day&first_presentation);
rt_standard_trial_4_animals=all_animals.rt_sniffs_before_reaction(standard_presentation&good_day');
rt_all_novel_trials_4_animals=all_animals.rt_sniffs_before_reaction(~standard_presentation&good_day');

p_value_non_first_novel_4_animals=ranksum(rt_all_novel_trials_4_animals,rt_standard_trial_4_animals)

% Add the value of the 5 animals novel and standard odors 
for k_animal=1:length(unique(all_animals.kdir))
    this_animal=all_animals.kdir==k_animal;
    this_animal_rt_sniffs_before_reaction_standard=all_animals.rt_sniffs_before_reaction(standard_presentation&good_day'&this_animal');
    this_animal_rt_sniffs_before_reaction_novel=all_animals.rt_sniffs_before_reaction(~standard_presentation&good_day'&this_animal');
    async_animal_rt_standard(k_animal)=nanmean(this_animal_rt_sniffs_before_reaction_standard);
    async_animal_rt_novel(k_animal)=nanmean(this_animal_rt_sniffs_before_reaction_novel);
end

figure, hold on
bar(2,nanmean(rt_all_novel_trials_4_animals),'r')
u=errorbar(2,nanmean(rt_all_novel_trials_4_animals),nanstd(rt_all_novel_trials_4_animals)/sqrt(sum(~isnan(rt_all_novel_trials_4_animals))),'k')
set(u,'LineWidth',2)
bar(1,nanmean(rt_standard_trial_4_animals),'b')
u=errorbar(1,nanmean(rt_standard_trial_4_animals),nanstd(rt_standard_trial_4_animals)/sqrt(sum(~isnan(rt_standard_trial_4_animals))),'k')
set(u,'LineWidth',2)

a=plot([1,2],[async_animal_rt_standard;async_animal_rt_novel],'k');
set(a,'Marker','s'),set(a,'MarkerSize',12)




text_in_paper_1=['The lick reaction time for the asynchronous case for novel background odors was ', ...
    num2str(nanmean(rt_all_novel_trials_4_animals)),...
    '±',...
    num2str(nanstd(rt_all_novel_trials_4_animals)/sqrt(sum(~isnan(rt_all_novel_trials_4_animals)))),...
    'ms and it was significantly slower (n=',...
    num2str(sum(~isnan(rt_all_novel_trials_4_animals))),...
    'lick responses, 4 animals, p=',...
    num2str(p_value_non_first_novel_4_animals),...
    'Wilcoxon rank-sum test) than the response for the known background odors (',...
    num2str(nanmean(rt_standard_trial_4_animals)),...
    '±',...
    num2str(nanstd(rt_standard_trial_4_animals)/sqrt(sum(~isnan(rt_standard_trial_4_animals)))),...
    'ms, ', ...
    num2str(sum(~isnan(rt_standard_trial_4_animals))),...
    'lick responses, see Fig. 6A).']
    


bar(5,nanmean(rt_all_novel_trials_5_animals_sync),'r')
u=errorbar(5,nanmean(rt_all_novel_trials_5_animals_sync),nanstd(rt_all_novel_trials_5_animals_sync)/sqrt(sum(~isnan(rt_all_novel_trials_5_animals_sync))),'k')
set(u,'LineWidth',2)
bar(4,nanmean(rt_standard_trial_5_animals_sync),'b')
u=errorbar(4,nanmean(rt_standard_trial_5_animals_sync),nanstd(rt_standard_trial_5_animals_sync)/sqrt(sum(~isnan(rt_standard_trial_5_animals_sync))),'k')
set(u,'LineWidth',2)
axis([0 6 0 1400])
a= gca
set(a,'YTick',[0:100:1300])
set(a,'XTick',[1,2,4,5])
set(a,'XTickLabel',{'Async known','Async novel','Sync known','Sync novel'})
title('WT full set Fig 10J')
label('Lick latency (ms)')


set(a,'Box','off')

a=plot([4,5],[sync_animal_rt_standard;sync_animal_rt_novel],'k');
set(a,'Marker','s'),set(a,'MarkerSize',12)



    
text_in_paper_2=['The reaction time for novel background odors for the synchronous case was '...
    num2str(nanmean(rt_all_novel_trials_5_animals_sync)),...
    '±',...
    num2str(nanstd(rt_all_novel_trials_5_animals_sync)/sqrt(sum(~isnan(rt_all_novel_trials_5_animals_sync)))),...
    'and  it  was also significantly slower (',...
    num2str(sum(~isnan(rt_all_novel_trials_5_animals_sync))),...
    'lick responses, 5 animals',...
    'p=',num2str(p_value_5_animals_sync),...
    'Wilcoxon rank-sum test) than the reaction time for known background odors(',...
    num2str(nanmean(rt_standard_trial_5_animals_sync)),...
    '± ',...
    num2str(nanstd(rt_standard_trial_5_animals_sync)/sqrt(sum(~isnan(rt_standard_trial_5_animals_sync)))), 'ms, n=',...
    num2str(sum(~isnan(rt_standard_trial_5_animals_sync))),...
    'trials). ']

