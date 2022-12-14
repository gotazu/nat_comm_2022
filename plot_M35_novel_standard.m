load plot_M35_novel_standard
% Extract individual animals performance on M35 when it is used as a novel
% odor
x=cntnap2_limonese_standard;
for k_animal_id=1:length(x.directories_to_check)
    behavior=[];
    for k_file=1:3
        odors=x.all_files_trial_analysis{k_file,k_animal_id}.odor_id(:,2);
        this_odor_selection=odors==39;
        behavior_this_odor_selection=x.all_files_trial_analysis{k_file,k_animal_id}.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
        behavior=[behavior,behavior_this_odor_selection];
    end
    cntnap2_indiv_animals_M35_novel(k_animal_id)=sum(behavior>0)/length(behavior);
end
x=WT_limonese_standard;
for k_animal_id=1:length(x.directories_to_check)
    behavior=[];
    for k_file=1:3
        if ~isempty(x.all_files_trial_analysis{k_file,k_animal_id})
        odors=x.all_files_trial_analysis{k_file,k_animal_id}.odor_id(:,2);
        this_odor_selection=odors==39;
        behavior_this_odor_selection=x.all_files_trial_analysis{k_file,k_animal_id}.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
        behavior=[behavior,behavior_this_odor_selection];
        end
    end
    wt_indiv_animals_M35_novel(k_animal_id)=sum(behavior>0)/length(behavior);
end



% Get the fraction correct for the M35 as novel odor in WT
x=WT_limonese_standard;
this_odor_selection=x.all_animals.odor_id(:,2)==39;
behavior_this_odor_selection=x.all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
wt_novel_correct=sum(behavior_this_odor_selection>0);
wt_novel_n_total=length(behavior_this_odor_selection);
[PHAT_wt_novel, PCI_wt_novel] = binofit(wt_novel_correct,wt_novel_n_total,0.05)

% Get the fraction correct for the M35 as novel odor in CNTNAP2
x=cntnap2_limonese_standard;
this_odor_selection=x.all_animals.odor_id(:,2)==39;
behavior_this_odor_selection=x.all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
cntnap2_novel_correct=sum(behavior_this_odor_selection>0);
cntnap2_novel_n_total=length(behavior_this_odor_selection);
[PHAT_cntnap2_novel, PCI_cntnap2_novel] = binofit(cntnap2_novel_correct,cntnap2_novel_n_total,0.05)

% Get the fraction correct for the M35 as standard in WT
x=WT_M35_standard;
this_odor_selection=x.all_animals.odor_id(:,2)==39;
behavior_this_odor_selection=x.all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
wt_standard_correct=sum(behavior_this_odor_selection>0);
wt_standard_n_total=length(behavior_this_odor_selection);
[PHAT_wt_standard, PCI_wt_standard] = binofit(wt_standard_correct,wt_standard_n_total,0.05)
single_wt_animal_standard=sum(x.standard_performance_n_correct')./sum(x.standard_performance_n_total');

% Get the fraction correct for the M35 as standard in CNTNAP2
x=cntnap2_M35_standard;
this_odor_selection=x.all_animals.odor_id(:,2)==39;
behavior_this_odor_selection=x.all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(this_odor_selection);
cntnap2_standard_correct=sum(behavior_this_odor_selection>0);
cntnap2_standard_n_total=length(behavior_this_odor_selection);
[PHAT_cntnap2_standard, PCI_cntnap2_standard] = binofit(cntnap2_standard_correct,cntnap2_standard_n_total,0.05)
single_cntnap2_animal_standard=sum(x.standard_performance_n_correct')./sum(x.standard_performance_n_total');

%imaging_full_set_correct_1_inc_0
means=[PHAT_wt_novel PHAT_wt_standard PHAT_cntnap2_novel PHAT_cntnap2_standard ];
figure, b=bar([1 2 5 6],means)

b.FaceColor = 'flat';
b.CData(2,:) = [0 1 0];b.CData(1,:) = [0 1 0];
b.CData(3,:) = [1 0 1];b.CData(4,:) = [1 0 1];


hold on
a=errorbar(1,PHAT_wt_novel,PCI_wt_novel(1)-PHAT_wt_novel,PCI_wt_novel(2)-PHAT_wt_novel,'k'),set(a,'LineWidth',2)
a=errorbar(2,PHAT_wt_standard,PCI_wt_standard(1)-PHAT_wt_standard,PCI_wt_standard(2)-PHAT_wt_standard,'k'),set(a,'LineWidth',2)
a=errorbar(5,PHAT_cntnap2_novel,PCI_cntnap2_novel(1)-PHAT_cntnap2_novel,PCI_cntnap2_novel(2)-PHAT_cntnap2_novel,'k'),set(a,'LineWidth',2)
a=errorbar(6,PHAT_cntnap2_standard,PCI_cntnap2_standard(1)-PHAT_cntnap2_standard,PCI_cntnap2_standard(2)-PHAT_cntnap2_standard,'k'),set(a,'LineWidth',2)
%Plot individual animals
a=plot([5.2,5,4.8,5],cntnap2_indiv_animals_M35_novel,'ko'), set(a,'MarkerSize',18),set(a,'LineWidth',2)
a=plot(1,wt_indiv_animals_M35_novel,'ko'), set(a,'MarkerSize',18),set(a,'LineWidth',2)

a=plot([1.8,2.2,2],single_wt_animal_standard,'ks'), set(a,'MarkerSize',18),set(a,'LineWidth',2)
a=plot(6,single_cntnap2_animal_standard,'ks'), set(a,'MarkerSize',18),set(a,'LineWidth',2)

correct=[wt_novel_correct;wt_standard_correct];
incorrect=[wt_novel_n_total-wt_novel_correct;wt_standard_n_total-wt_standard_correct];
wt_table= table(correct,incorrect,'VariableNames',{'correct','error'},'RowNames',{'novel','standard'})
[H,P_wt] = fishertest(wt_table)

correct=[cntnap2_novel_correct;cntnap2_standard_correct];
incorrect=[cntnap2_novel_n_total-cntnap2_novel_correct;cntnap2_standard_n_total-cntnap2_standard_correct];
cntnap2_table= table(correct,incorrect,'VariableNames',{'correct','error'},'RowNames',{'novel','standard'})
[H,P_cntnap2] = fishertest(cntnap2_table)
a=gca, set(a,'Box','off')

set(a,'YLim',[0.3 1]),set(a,'XTick',[1,2,5,6]),set(a,'XTickLabel',{'WT as novel','WT as known','cntnap2 as novel','cntnap2 as known'})
ylabel('Perf on butyl propionate')
title('Figure 10C')



correct=[wt_standard_correct;cntnap2_standard_correct];
incorrect=[wt_standard_n_total-wt_standard_correct; cntnap2_standard_n_total-cntnap2_standard_correct];
wt_cntnap2__st_table= table(correct,incorrect,'VariableNames',{'correct','error'},'RowNames',{'WT','cntnap2'})
[H,P_stand_wt_cntnap2] = fishertest(wt_cntnap2__st_table,'Tail','both')




