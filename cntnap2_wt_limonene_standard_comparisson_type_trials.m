load cntnap2_wt_limonene_standard_comparisson_type_trials

% Novel odors
figure,hold on
cntnap2_novel=hist(all_animals_cntnap2_novel,-2:2)
wt_novel=hist(all_animals_WT_novel,-2:2)
fraction_cntnap2_novel=cntnap2_novel/sum(cntnap2_novel);
fraction_wt_novel=wt_novel/sum(wt_novel);
bar(-2:2,[fraction_wt_novel',fraction_cntnap2_novel'])

[PHAT_cntnap2, PCI_cntnap2] = binofit(cntnap2_novel,sum(cntnap2_novel),0.05)
bar_pos=[-2:2]+0.15;
for k=1:length(bar_pos)
    a=errorbar(bar_pos(k),PHAT_cntnap2(k),PCI_cntnap2(k,1)-PHAT_cntnap2(k),PCI_cntnap2(k,2)-PHAT_cntnap2(k),'k'),set(a,'LineWidth',2)
end
[PHAT_wt, PCI_wt] = binofit(wt_novel,sum(wt_novel),0.05)
bar_pos=[-2:2]-0.15;
for k=1:length(bar_pos)
    a=errorbar(bar_pos(k),PHAT_wt(k),PCI_wt(k,1)-PHAT_wt(k),PCI_wt(k,2)-PHAT_wt(k),'k'),set(a,'LineWidth',2)
end

symbols='sx+^';

for k=1:length(per_animal_type_of_trial_cntnap2_novel)
    this_symbol=['k',symbols(k)];
    a=plot( (-2:2)+0.15 , per_animal_type_of_trial_cntnap2_novel{k}/sum(per_animal_type_of_trial_cntnap2_novel{k}),this_symbol);set(a,'MarkerSize',16),set(a,'LineWidth',2)
end
for k=1:length(per_animal_type_of_trial_WT_novel)
    this_symbol=['k',symbols(k)];
    a=plot( (-2:2)-0.15 , per_animal_type_of_trial_WT_novel{k}/sum(per_animal_type_of_trial_WT_novel{k}),this_symbol);set(a,'MarkerSize',16),set(a,'LineWidth',2)
end
axis([-2.5 0.5 0 0.45])
a=gca
set(a,'XTick',[-2.15 -1.85 -1.15 -0.85 -0.15 +0.15  ])
set(a,'XTickLabel',{'FA WT','FA cntnap2','Miss WT','Miss cntnap2','EL WT','EL cntnap2'})
ylabel('Fraction of trials'),set(a,'Box','off')
xlabel('Novel')
title('Figure 10H')

% Standard odors
figure,hold on
cntnap2_standard=hist(all_animals_cntnap2_standard,-2:2)
wt_standard=hist(all_animals_wt_standard,-2:2)
fraction_cntnap2_standard=cntnap2_standard/sum(cntnap2_standard);
fraction_wt_standard=wt_standard/sum(wt_standard);
bar(-2:2,[fraction_wt_standard',fraction_cntnap2_standard'])

[PHAT_cntnap2, PCI_cntnap2] = binofit(cntnap2_standard,sum(cntnap2_standard),0.05)
bar_pos=[-2:2]+0.15;
for k=1:length(bar_pos)
    a=errorbar(bar_pos(k),PHAT_cntnap2(k),PCI_cntnap2(k,1)-PHAT_cntnap2(k),PCI_cntnap2(k,2)-PHAT_cntnap2(k),'k'),set(a,'LineWidth',2)
end

[PHAT_wt, PCI_wt] = binofit(wt_standard,sum(wt_standard),0.05)
bar_pos=[-2:2]-0.15;
for k=1:length(bar_pos)
    a=errorbar(bar_pos(k),PHAT_wt(k),PCI_wt(k,1)-PHAT_wt(k),PCI_wt(k,2)-PHAT_wt(k),'k'),set(a,'LineWidth',2)
end

symbols='sx+^';
for k=1:length(per_animal_type_of_trial_cntnap2_standard)
    this_symbol=['k',symbols(k)];
    a=plot( (-2:2)+0.15 , per_animal_type_of_trial_cntnap2_standard{k}/sum(per_animal_type_of_trial_cntnap2_standard{k}),this_symbol);set(a,'MarkerSize',16),set(a,'LineWidth',2)
end
for k=1:length(per_animal_type_of_trial_wt_standard)
    this_symbol=['k',symbols(k)];
    a=plot( (-2:2)-0.15 , per_animal_type_of_trial_wt_standard{k}/sum(per_animal_type_of_trial_wt_standard{k}),this_symbol);set(a,'MarkerSize',16),set(a,'LineWidth',2)
end
axis([-2.5 0.5 0 0.45])
a=gca
set(a,'XTick',[-2.15 -1.85 -1.15 -0.85 -0.15 +0.15  ])
set(a,'XTickLabel',{'FA WT','FA cntnap2','Miss WT','Miss cntnap2','EL WT','EL cntnap2'})
ylabel('Fraction of trials'),set(a,'Box','off')
xlabel('Known')
title('Figure 10G')
set(a,'Box','off')



for k=1:5
    tabla=[cntnap2_novel(k),sum(cntnap2_novel)-cntnap2_novel(k);wt_novel(k),sum(wt_novel)-wt_novel(k)];
    [h,p_value_novel(k)]=fishertest(tabla)
end

for k=1:5
    tabla=[cntnap2_standard(k),sum(cntnap2_standard)-cntnap2_standard(k);wt_standard(k),sum(wt_standard)-wt_standard(k)];
    [h,p_value_standard(k)]=fishertest(tabla)
end

% Comparisson to Misses in novel background odors
table_miss_vs_false_alarm=[cntnap2_novel(2),sum(cntnap2_novel)-cntnap2_novel(2);cntnap2_novel(1),sum(cntnap2_novel)-cntnap2_novel(1)];
[h,p_miss_vs_false_alarm]=fishertest(table_miss_vs_false_alarm)
table_miss_vs_early_lick=[cntnap2_novel(2),sum(cntnap2_novel)-cntnap2_novel(2);cntnap2_novel(3),sum(cntnap2_novel)-cntnap2_novel(3)];
[h,p_miss_vs_early_lick]=fishertest(table_miss_vs_early_lick)

table_miss_vs_false_alarm_wt=[wt_novel(2),sum(wt_novel)-wt_novel(2);wt_novel(1),sum(wt_novel)-wt_novel(1)];
[h,p_miss_vs_false_alarm_wt]=fishertest(table_miss_vs_false_alarm_wt)
table_miss_vs_early_lick_wt=[wt_novel(2),sum(wt_novel)-wt_novel(2);wt_novel(3),sum(wt_novel)-wt_novel(3)];
[h,p_miss_vs_early_lick_wt]=fishertest(table_miss_vs_early_lick_wt)

% Comparisson to Misses in standard background odors
table_miss_vs_false_alarm_standard=[cntnap2_standard(2),sum(cntnap2_standard)-cntnap2_standard(2);cntnap2_standard(1),sum(cntnap2_standard)-cntnap2_standard(1)];
[h,p_miss_vs_false_alarm_standard]=fishertest(table_miss_vs_false_alarm_standard)
table_miss_vs_early_lick_standard=[cntnap2_standard(2),sum(cntnap2_standard)-cntnap2_standard(2);cntnap2_standard(3),sum(cntnap2_standard)-cntnap2_standard(3)];
[h,p_miss_vs_early_lick_standard]=fishertest(table_miss_vs_early_lick_standard)

table_miss_vs_false_alarm_wt_standard=[wt_standard(2),sum(wt_standard)-wt_standard(2);wt_standard(1),sum(wt_standard)-wt_standard(1)];
[h,p_miss_vs_false_alarm_wt_standard]=fishertest(table_miss_vs_false_alarm_wt_standard)
table_miss_vs_early_lick_wt_standard=[wt_standard(2),sum(wt_standard)-wt_standard(2);wt_standard(3),sum(wt_standard)-wt_standard(3)];
[h,p_miss_vs_early_lick_wt_standard]=fishertest(table_miss_vs_early_lick_wt_standard)

