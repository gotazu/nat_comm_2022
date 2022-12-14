load plot_analysis_training_M3_5_limonene_cntnap2_WT_reduced_set_first_day_backgrounds
performance_matrix=NaN(length(data_dir),350);
performance_cntnap2_100_170=[];
performance_WT_100_170=[];
for k=1:length(data_dir)
    performance_matrix(k,1:length(perf_to_save{k}(1,:)))=perf_to_save{k}(1,:);
    number_trials_available=length(actual_perf_to_save{k});
    if  number_trials_available >=100
        end_trial=min([170,number_trials_available]);
        if genotype_cntnap2_1_WT_0(k)==1
            performance_cntnap2_100_170=[performance_cntnap2_100_170,actual_perf_to_save{k}(1,100:end_trial)];
        else
            performance_WT_100_170=[performance_WT_100_170,actual_perf_to_save{k}(1,100:end_trial)];
        end
    end
end

n_correct_cntnap2=sum(performance_cntnap2_100_170>0); n_cntnap2=length(performance_cntnap2_100_170);
n_correct_WT=sum(performance_WT_100_170>0); n_WT=length(performance_WT_100_170);

cntnap2_performance=n_correct_cntnap2/n_cntnap2
WT_performance=n_correct_WT/n_WT

table_cntnap2_WT=[n_correct_cntnap2,n_cntnap2-n_correct_cntnap2;n_correct_WT,n_WT-n_correct_WT];
[h,p_false_rejection] = fishertest(table_cntnap2_WT)



figure

hold on
a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==1,:)),'m'), set(a,'LineWidth',2)
n_cntnap2=sum(~isnan(performance_matrix(genotype_cntnap2_1_WT_0==1,:)));
error_cntanp2=nanstd(performance_matrix(genotype_cntnap2_1_WT_0==1,:))./sqrt(n_cntnap2);
a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==1,:))-error_cntanp2,'m:'),set(a,'LineWidth',2)
a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==1,:))+error_cntanp2,'m:'),set(a,'LineWidth',2)

a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==0,:)),'g'),set(a,'LineWidth',2)
n_WT=sum(~isnan(performance_matrix(genotype_cntnap2_1_WT_0==0,:)));
error_WT=nanstd(performance_matrix(genotype_cntnap2_1_WT_0==0,:))./sqrt(n_WT);
a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==0,:))-error_WT,'g:'),set(a,'LineWidth',2)
a=plot(nanmean(performance_matrix(genotype_cntnap2_1_WT_0==0,:))+error_WT,'g:'),set(a,'LineWidth',2)

axis([0 170 0.5 1])
a=gca
xlabel('Trial Number')
ylabel('Performance')
title('Figure 10E')

%index_start_counting;
% Calculate the NIV ( Doucette and Restrepo)
for k=1:length(data_dir)
    x=performance_matrix(k,1:170);
    niv(k)=nansum(x)/sum(~isnan(x));
end

niv_cntnap2_mean=mean(niv(genotype_cntnap2_1_WT_0==1))
niv_cntnap2_sem=std(niv(genotype_cntnap2_1_WT_0==1))/sqrt(sum(genotype_cntnap2_1_WT_0==1))

niv_WT_mean=mean(niv(genotype_cntnap2_1_WT_0==0))
niv_WT_sem=std(niv(genotype_cntnap2_1_WT_0==0))/sqrt(sum(genotype_cntnap2_1_WT_0==0))

[h,p] = ttest2(niv(genotype_cntnap2_1_WT_0==0),niv(genotype_cntnap2_1_WT_0==1))

