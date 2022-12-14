

file_fluo_intrinsic={'roi_10_odor_5_470nm.csv'  , 'roi_17_odor_13_470nm.csv',  'roi_46_odor_19_470nm.csv';...  
 'roi_10_odor_5.csv',         'roi_17_odor_13.csv',        'roi_46_odor_19.csv'};        

t_fluo=(1:80)*16/80-7-0.121;
base_fluo=t_fluo<0;
t_intrin=(1:640)*16/640-7-0.121;
base_intrin=t_intrin<0;

B=ones(1,10)/10;
A=1;

B_fluo=ones(1,4)/4;

for k=1:3
    x=readtable(file_fluo_intrinsic{1,k});
    xx=table2array(x);
    raw_fluo=xx(:,2:end);
    air_fluo=raw_fluo(base_fluo);
    z_score_glomerulus_fluo=(raw_fluo-mean(air_fluo))/std(air_fluo);
    z_score_glomerulus_fluo = filtfilt(B_fluo, A, z_score_glomerulus_fluo);
    figure, m=plot(t_fluo,z_score_glomerulus_fluo,'r'),hold on
    set(m,'LineWidth',2)
    
    x=readtable(file_fluo_intrinsic{2,k});
    xx=table2array(x);
    raw_intrin=xx(:,2:end);
    air_intrin=raw_intrin(base_intrin);
    z_score_glomerulus_intrin=(raw_intrin-mean(air_intrin))/std(air_intrin);
    z_score_glomerulus_intrin = filtfilt(B, A, z_score_glomerulus_intrin);
    
    m=plot(t_intrin,z_score_glomerulus_intrin,'k')
    set(m,'LineWidth',2)
    u=gca;
    set(u,'XLim',[-2 9])
    %set(u,'XTickLabel',[]);set(u,'YTickLabel',[]);
    xlabel('Time from stimulus onset(s)')
    ylabel('Zscore')
    title(['Sup fig 4 ROI ', file_fluo_intrinsic{1,k}(5:6)])
    set(u,'Box','off')
end


