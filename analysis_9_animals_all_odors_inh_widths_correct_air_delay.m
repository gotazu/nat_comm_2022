% nature communications supplementary figure 10C 10D
load analysis_9_animals_all_odors_inh_widths_correct_air_delay


% 
% fast_sniffing_first=list_of_12_first_inhalation_width_ms_after_novel_onset<75;
% slow_sniffing_first=list_of_12_first_inhalation_width_ms_after_novel_onset>75;
standard_odor=list_of_12_odor_id==51; % 51 is the code for limonene
novel_odor=list_of_12_odor_id~=51;
no_licking=(list_of_12_correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0==2)|(list_of_12_correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0==-1);


% For nat comm, add symbols for individual animals
animals_symbols=['o','x', '+','*','s','d','v','^','p'];

% Plot of second sniff width
correct=list_of_12_correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0>0;
incorrect=list_of_12_correctgo_1_correctng_2_falsereject_m1_falsealarm_m2_early_0<0;
fast_sniffing_novel_correct=list_of_12_first_inhalation_width_ms_after_novel_onset;

correct_novel=list_of_12_second_inhalation_width_ms_after_novel_onset(correct&novel_odor);
incorrect_novel=list_of_12_second_inhalation_width_ms_after_novel_onset(incorrect&novel_odor);
correct_standard=list_of_12_second_inhalation_width_ms_after_novel_onset(correct&standard_odor);
incorrect_standard=list_of_12_second_inhalation_width_ms_after_novel_onset(incorrect&standard_odor);

figure, hold on
% Supplementary Figure 10D
bar([1,2],[nanmean(correct_novel),nanmean(incorrect_novel)],'r')

% No licking

hold on
rr=errorbar(1,nanmean(correct_novel), nanstd(correct_novel)/sqrt(length(correct_novel))  ,'k')
set(rr,'LineWidth',2)
rr=errorbar(2,nanmean(incorrect_novel), nanstd(incorrect_novel)/sqrt(length(incorrect_novel))  ,'k')
set(rr,'LineWidth',2)
[p_novel,h_novel] = ranksum(correct_novel,incorrect_novel,'Tail','left')

bar([4,5],[nanmean(correct_standard),nanmean(incorrect_standard)],'b')
hold on
rr=errorbar(4,nanmean(correct_standard), nanstd(correct_standard)/sqrt(length(correct_standard))  ,'k')
set(rr,'LineWidth',2)
rr=errorbar(5,nanmean(incorrect_standard), nanstd(incorrect_standard)/sqrt(length(incorrect_standard))  ,'k')
set(rr,'LineWidth',2)
[p_standard,h_standard] = ranksum(correct_standard,incorrect_standard,'Tail','left')

for k_animal=1:length(directories_to_check)
    this_animal=list_of_12_animal_id==k_animal;
    correct_novel_this_animal=list_of_12_second_inhalation_width_ms_after_novel_onset(correct&novel_odor&this_animal);
    incorrect_novel_this_animal=list_of_12_second_inhalation_width_ms_after_novel_onset(incorrect&novel_odor&this_animal);
    correct_standard_this_animal=list_of_12_second_inhalation_width_ms_after_novel_onset(correct&standard_odor&this_animal);
    incorrect_standard_this_animal=list_of_12_second_inhalation_width_ms_after_novel_onset(incorrect&standard_odor&this_animal);
    u=plot(1,nanmean(correct_novel_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)
    u=plot(2,nanmean(incorrect_novel_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)    
    
    u=plot(4,nanmean(correct_standard_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)
    u=plot(5,nanmean(incorrect_standard_this_animal),['k',animals_symbols(k_animal)]) ,set(u,'MarkerSize',12) 
end

axis([0 6 80 160])
ss=gca;
set(ss,'YTick',0:10:160)
set(ss,'XTick',[1,2,4,5])
set(ss,'XTickLabel',{'Correct','Incorrect','Correct','Incorrect'})
set(ss,'FontName','arial'), set(ss,'FontSize',24)
set(ss,'Box','off')
ylabel('Inhalation Width(ms)')
title('Supp. Figure 10D')


text_in_paper_1=['This second sniff width was significantly shorter (p=',num2str(p_novel),...
    ', Wilcoxon rank sum test, single tailed) in the correct trials (',num2str(nanmean(correct_novel) ),...
    '+-',num2str(  nanstd(correct_novel)/sqrt(length(correct_novel))   ),...
    'ms', num2str(length(correct_novel)),...
    'trials, 9 animals) compared to the incorrect trials (',...
    num2str(nanmean(incorrect_novel) ),...
    '±',...
    num2str(  nanstd(incorrect_novel)/sqrt(length(incorrect_novel))   ),...
    'ms,',...
    num2str(length(incorrect_novel)),...
    ' trials).'] 
    
text_in_paper_2=['Interestingly, fast sniffing was not correlated with better performance for known backgrounds; the second inhalation width after (s)-(-)limonene onset was not significantly shorter for known backgrounds (',...
                'p='...
                num2str(p_standard),...
                ',Wilcoxon rank sum test, single tailed), with a width of ' ...
                num2str(nanmean(correct_standard) ),...
                ' ± ',...
                num2str(  nanstd(correct_standard)/sqrt(length(correct_standard))   ), ...
                '(n=',...
               num2str(length(correct_standard)),...
               'trials) for the correct trials and ' ,...
               num2str(nanmean(incorrect_standard) ),...
               '±',...
               num2str(  nanstd(incorrect_standard)/sqrt(length(incorrect_standard))   ),...
               'ms,',...
                '(n=',...
               num2str(length(incorrect_standard)),...
               'for the incorrect trials']
               




 % Do the same plot for the first sniff after onset of novel
 % Supplementary Figure 10C
 correct_novel=list_of_12_first_inhalation_width_ms_after_novel_onset(correct&novel_odor);
 incorrect_novel=list_of_12_first_inhalation_width_ms_after_novel_onset(incorrect&novel_odor);
 correct_standard=list_of_12_first_inhalation_width_ms_after_novel_onset(correct&standard_odor);
 incorrect_standard=list_of_12_first_inhalation_width_ms_after_novel_onset(incorrect&standard_odor);

figure, hold on


bar([1,2],[nanmean(correct_novel),nanmean(incorrect_novel)],'r')
hold on
rr=errorbar(1,nanmean(correct_novel), nanstd(correct_novel)/sqrt(length(correct_novel))  ,'k')
set(rr,'LineWidth',2)
rr=errorbar(2,nanmean(incorrect_novel), nanstd(incorrect_novel)/sqrt(length(incorrect_novel))  ,'k')
set(rr,'LineWidth',2)
[p_novel,h_novel] = ranksum(correct_novel,incorrect_novel,'Tail','left')

text_3=['However, there was no difference in inhalation width (p=',...
        num2str(p_novel),...
        'single trailed Wilcoxon sum test) between correct trials (',...
        num2str(nanmean(correct_novel)), ...
        ' ± ',...
        num2str(nanstd(correct_novel)/sqrt(length(correct_novel))),...
        ' ms, ', ...
        num2str(length(correct_novel)), ...
        'trials) and incorrect trials (', ... 
        num2str(nanmean(incorrect_novel)),...
        ' ± ', ...
        num2str(nanstd(incorrect_novel)/sqrt(length(incorrect_novel))), ...
        'ms',...
        num2str( length(incorrect_novel) ),...
        'trials)']

bar([4,5],[nanmean(correct_standard),nanmean(incorrect_standard)],'b')
hold on
rr=errorbar(4,nanmean(correct_standard), nanstd(correct_standard)/sqrt(length(correct_standard))  ,'k')
set(rr,'LineWidth',2)
rr=errorbar(5,nanmean(incorrect_standard), nanstd(incorrect_standard)/sqrt(length(incorrect_standard))  ,'k')
set(rr,'LineWidth',2)
[p_standard,h_standard] = ranksum(correct_standard,incorrect_standard,'Tail','left')
for k_animal=1:length(directories_to_check)
    this_animal=list_of_12_animal_id==k_animal;
    correct_novel_this_animal=list_of_12_first_inhalation_width_ms_after_novel_onset(correct&novel_odor&this_animal);
    incorrect_novel_this_animal=list_of_12_first_inhalation_width_ms_after_novel_onset(incorrect&novel_odor&this_animal);
    correct_standard_this_animal=list_of_12_first_inhalation_width_ms_after_novel_onset(correct&standard_odor&this_animal);
    incorrect_standard_this_animal=list_of_12_first_inhalation_width_ms_after_novel_onset(incorrect&standard_odor&this_animal);
    u=plot(1,nanmean(correct_novel_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)
    u=plot(2,nanmean(incorrect_novel_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)    
    
    u=plot(4,nanmean(correct_standard_this_animal),['k',animals_symbols(k_animal)]),set(u,'MarkerSize',12)
    u=plot(5,nanmean(incorrect_standard_this_animal),['k',animals_symbols(k_animal)]) ,set(u,'MarkerSize',12) 
end
axis([0 6 80 150])
ss=gca;
set(ss,'YTick',0:10:150)
set(ss,'XTick',[1 2 4 5])
set(ss,'XTickLabel',{'Correct','Incorrect','Correct','Incorrect'})
set(ss,'FontName','arial'), set(ss,'FontSize',24)
ylabel('Inhalation width (ms)')
set(ss,'Box','off')
title('Supplementary figure 10C')

 text_4=['There was also no difference (p=',...
         num2str([p_standard]),...
         'Wilcoxon test) for the known backgrounds, with ',...
         num2str(nanmean(correct_standard)), ...
         '±',...
         num2str(nanstd(correct_standard)/sqrt(length(correct_standard))),...
         'ms (',...
         num2str(length(correct_standard)),...
         'trials) for the correct trials and ',...
         num2str(nanmean(incorrect_standard)),...
         '±',...
         num2str(nanstd(incorrect_standard)/sqrt(length(incorrect_standard))),...
         'ms (',...
         num2str(length(incorrect_standard)),... 
         'trials) for the incorrect trials.  Faster sniffing increased odor identification performance only for novel background odors.']




 




