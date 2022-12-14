load z_score_decoder_analysis_from_indiv_odors_correla_batch


av_corr_matrix=0;
large_matrix_response=[];
for k_dir=1:length(files_indiv_animals)
    av_corr_matrix=av_corr_matrix+correlation_matrix_ordered{k_dir}/length(files_indiv_animals);
    large_matrix_response=[large_matrix_response,df_reorder{k_dir}];
end
large_matrix_response(large_matrix_response>z_score_threshold)=0;

% Get the plot of the average number of glomeruli affected by odor
[n_odors,n_glom]=size(large_matrix_response);
df_reorder=large_matrix_response;
figure,bar(-mean(df_reorder'))
hold on
mean_glom_acti=mean(df_reorder');
sem_glom_acti=std(df_reorder')/sqrt(n_glom);
for k=1:20
    a=errorbar(k,-mean_glom_acti(k),sem_glom_acti(k),'k')
    set(a,'LineWidth',2)
end
var_to_save.average_odor_response=mean(df_reorder');
% Add the averages of the individual animals
for k_dir=1:length(files_indiv_animals)
    this_animals_df=df_reorder_per_animal{k_dir};
    this_animal_mean_activation=mean(this_animals_df');
    for k=1:20
        a=plot(k,-this_animal_mean_activation(k),'ks')
        set(a,'LineWidth',2)
    end
end

a=gca
set(a,'XTick',1:20)
set(a,'XTickLabel',[])
set(a,'YTick',0:0.5:2)
ylabel('Average glomerular activation ( -z-score)')
title('Figure 1K')


correct_spell_reordered_odor_name;
set(a,'XTick',1:20)
set(a,'YTick',1:20)
set(a,'XTickLabelRotation',90)
labels=get(a,'YTickLabel')
for k=1:20
    labels{k}=correct_spell_reordered_odor_name{k};
end

set(a,'FontSize',11)
set(a,'XTickLabelRotation',90)
set(a,'XAxisLocation', 'bottom')
set(a,'XTickLabel',labels)

set(a,'FontSize',14)
set(a,'FontName','Arial')

%%%%% Given that we know the threshold, we can plot the fraction of
%%%%% glomeruli that are activated per odor
figure,bar(sum(large_matrix_response<0,2)/n_glom)
var_to_save.fraction_responsive_glom=sum(large_matrix_response<0,2)/n_glom;
hold on
% Calculate the errorbar as the 90% confidence intervals
 [PHAT, PCI] = binofit(sum(large_matrix_response<0,2),n_glom,0.1);
a=errorbar(1:20,PHAT,PHAT-PCI(:,1),-PHAT+PCI(:,2),'LineStyle','none')
set(a,'LineWidth',2)
set(a,'Color','k')
a=gca;
set(a,'XTick',1:20)
set(a,'XTickLabel',[])
set(a,'YTick',0:0.1:0.7)
title('Figure 1J')
ylabel('Fraction of responsive glomeruli')

% Add the fraction of responsive glomeruli per individual animal
for k_dir=1:length(files_indiv_animals)
    this_animals_df=df_reorder_per_animal{k_dir};
    this_animal_mean_activation=sum(this_animals_df'<z_score_threshold);
    [this_animal_n_odors,this_animal_n_glom]=size(this_animals_df);
    for k=1:20
        a=plot(k,this_animal_mean_activation(k)/this_animal_n_glom,'ks')
        set(a,'LineWidth',2)
    end
end


load correct_spell_reordered_odor_name
correct_spell_reordered_odor_name;
a=gca
set(a,'XTick',1:20)
set(a,'YTick',1:20)
set(a,'XTickLabelRotation',90)
labels=get(a,'YTickLabel')
for k=1:20
    labels{k}=correct_spell_reordered_odor_name{k};
end

set(a,'FontSize',11)
set(a,'XTickLabelRotation',90)
set(a,'XAxisLocation', 'bottom')
set(a,'XTickLabel',labels)

set(a,'FontSize',14)
set(a,'FontName','Arial')

