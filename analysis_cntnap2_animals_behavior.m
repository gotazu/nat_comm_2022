load analysis_cntnap2_animals_behavior
novel_performance_correct=sum(sum(novel_performance_n_correct));
novel_performance_total=sum(sum(novel_performance_n_total));

standard_performance_correct=sum(sum(standard_performance_n_correct));
standard_performance_total=sum(sum(standard_performance_n_total));


% Do the plot of the type of errors that the CNTNAP2 animals do
standard_presentation=all_animals.odor_id(:,2)==51;
first_presentation=(all_animals.day_number==1)&(all_animals.odor_presentation_per_session==1);
good_day=all_animals.behavior_standard_performance>0.8;
% Bar plot of the animals solving the task
standard_presentation=all_animals.odor_id(:,2)==51;
first_presentation=(all_animals.day_number==1)&(all_animals.odor_presentation_per_session==1);

s=all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(standard_presentation');%&good_day);
standard_correct=sum(s>0);
standard_total=length(s);

n_false_rejection_standard=sum(s==-1);



s=all_animals.correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0(~standard_presentation');%&good_day);
n_false_rejection_novel=sum(s==-1);
novel_correct=sum(s>0);
novel_total=length(s);
a=hist(s,[-2:2]);


[PHAT_novel, PCI_novel] = binofit(novel_correct,novel_total,0.05)
Y=binopdf(novel_correct,novel_total,0.5);
format long
p_novel=Y







%imaging_full_set_correct_1_inc_0

[PHAT_neurotypical, PCI_neurotypical] = binofit(neurotypical.novel_performance_correct,neurotypical.novel_performance_total,0.05)
[PHAT_cntnap2, PCI_cntnap2] = binofit(novel_performance_correct,novel_performance_total,0.05)
table_signi_cntnap2=[neurotypical.novel_performance_correct,neurotypical.novel_performance_total-neurotypical.novel_performance_correct;...
                     novel_performance_correct,novel_performance_total-novel_performance_correct]                
[H,P] = fishertest(table_signi_cntnap2)

table_signi_cntnap2_standard=[neurotypical.standard_performance_correct,neurotypical.standard_performance_total-neurotypical.standard_performance_correct;...
                     standard_performance_correct,standard_performance_total-standard_performance_correct]                
[H,P] = fishertest(table_signi_cntnap2_standard)


figure, bar([1,2],[PHAT_neurotypical,PHAT_cntnap2],'r')
hold on
errorbar(1,PHAT_neurotypical,PCI_neurotypical(1)-PHAT_neurotypical,PCI_neurotypical(2)-PHAT_neurotypical,'k')
errorbar(2,PHAT_cntnap2,PCI_cntnap2(1)-PHAT_cntnap2,PCI_cntnap2(2)-PHAT_cntnap2,'k')
a=gca
set(a,'XTick',[1,2])
set(a,'XTickLabel',{'WT novel', 'cntnap2 novel'})
ylabel('Performance')
set(a,'Box','off')
title('Figure 10B')


axis([0.5 2.5 0.5 1])
a=gca;
set(a,'YTick',[0.5 0.6 0.7 0.8 0.9 1])
set(a,'Box','off')


% Add symbols for individual animals
indiv_perf_novel_cntnap2=sum(novel_performance_n_correct,2)./sum(novel_performance_n_total,2);
indiv_perf_novel_neurotypical=sum(neurotypical.novel_performance_n_correct,2)./sum(neurotypical.novel_performance_n_total,2);
hold on
a=plot(2,indiv_perf_novel_cntnap2,'ko')
set(a,'MarkerSize',24)
a=plot(1,indiv_perf_novel_neurotypical,'ko')
set(a,'MarkerSize',24)

% I will do the plot of the response of the animal before the onset of the
% novel stimuli and compare the C57Bl6 with the CNTNAP2
neurotyp_stand_n_correct=sum(sum(neurotypical_before_novel_start.standard_performance_n_correct));
neurotyp_stand_n_total=sum(sum(neurotypical_before_novel_start.standard_performance_n_total));

cntnap2_stand_n_correct=sum(sum(cntnap2_before_novel_start.standard_performance_n_correct));
cntnap2_stand_n_total=sum(sum(cntnap2_before_novel_start.standard_performance_n_total));


[PHAT_neurotypical_before, PCI_neurotypical_before] = binofit(neurotyp_stand_n_correct,neurotyp_stand_n_total,0.05)
[PHAT_cntnap2_before, PCI_cntnap2_before] = binofit(cntnap2_stand_n_correct,cntnap2_stand_n_total,0.05)
table_signi_cntnap2_standard_before=[neurotyp_stand_n_correct,neurotyp_stand_n_total-neurotyp_stand_n_correct;...
                     cntnap2_stand_n_correct,cntnap2_stand_n_total-cntnap2_stand_n_correct]                
[H,P] = fishertest(table_signi_cntnap2_standard_before)

figure, bar([1,2],[PHAT_neurotypical_before,PHAT_cntnap2_before],'b')
hold on
errorbar(1,PHAT_neurotypical_before,PCI_neurotypical_before(1)-PHAT_neurotypical_before,PCI_neurotypical_before(2)-PHAT_neurotypical_before,'k')
errorbar(2,PHAT_cntnap2_before,PCI_cntnap2_before(1)-PHAT_cntnap2_before,PCI_cntnap2_before(2)-PHAT_cntnap2_before,'k')

axis([0.5 2.5 0.5 1])
a=gca;
set(a,'YTick',[0.5 0.6 0.7 0.8 0.9 1])
set(a,'XTick',[1,2])
set(a,'XTickLabel',{'WT known', 'cntnap2 known'})
ylabel('Performance')
set(a,'Box','off')
title('Figure 10A')

% Add symbols for individual animals
indiv_perf_novel_cntnap2=sum(cntnap2_before_novel_start.standard_performance_n_correct,2)./sum(cntnap2_before_novel_start.standard_performance_n_total,2);
indiv_perf_novel_neurotypical=sum(neurotypical_before_novel_start.standard_performance_n_correct,2)./sum(neurotypical_before_novel_start.standard_performance_n_total,2);
hold on
a=plot([2.1 2 2 1.9],indiv_perf_novel_cntnap2,'ko')
set(a,'MarkerSize',24)
a=plot(1,indiv_perf_novel_neurotypical,'ko')
set(a,'MarkerSize',24)


