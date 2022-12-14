function conv_gauss = create_inh_psth(peak_inh_1_peak_exh_m1_ms)
[n_trials,bins]=size(peak_inh_1_peak_exh_m1_ms);
inhalation_matrix=(peak_inh_1_peak_exh_m1_ms==1)+0;
ALPHA=2.5% Reverse of the standard deviation;
window_gauss=gausswin(200,ALPHA);
window_gauss=window_gauss/sum(window_gauss);
conv_gauss=NaN(n_trials,bins);
for k=1:n_trials
    vector=inhalation_matrix(k,:);
    %s=conv(window_gauss,vector);
    s=filtfilt(window_gauss,1,vector);
    conv_gauss(k,:)=s;
end

