load nat_comm_reviews_compare_thy1_intrinsic

%     upper_limit=[10,  0 -0.25 -0.5 -0.75 -1 -1.25 -1.5     -1.75   -2     -2.25 -3    -3.25    -4 ,-5,-7];
%     lower_limit=[0,  -0.25 -0.5 -0.75 -1 -1.25 -1.5 -1.75  -2     -2.25   -3    -3.25          -4 ,-5,-7,-10];
upper_limit=[10, [0:-0.3:-4],-5,-7];
lower_limit=[0,  [-0.3:-0.3:-4] ,-5,-7,-10];
for k=1:length(lower_limit);
    this_range=(df_intrinsic>lower_limit(k))&(df_intrinsic<upper_limit(k));
    intrinsic_for_fit(k)=mean(df_intrinsic(this_range));
    gcamp_for_fit(k)=mean(df_gcamp(this_range));
    %std_err_gcamp_for_fit(k)=std(df_gcamp(this_range))/sqrt(sum(sum(this_range)));
    std_err_gcamp_for_fit(k)=std(df_gcamp(this_range));
    %u=plot(mean(df_intrinsic(this_range)),mean(df_gcamp(this_range)),'ro');
end





% I will fit using only the glomeruli that had at least one stron
% response
good_roi_responder=(sum(df_intrinsic<0)>1);
df_intrinsic_good=df_intrinsic(:,good_roi_responder);
df_gcamp_good=df_gcamp(:,good_roi_responder);
[n_odors,n_rois]=size(df_intrinsic_good);



df_intrinsic_vector=reshape(df_intrinsic_good,n_odors*n_rois,1);
df_gcamp_vector=reshape(df_gcamp_good,n_odors*n_rois,1);

value_infinity=mean(df_gcamp_vector(df_intrinsic_vector<-5));

p0=[1,0.01];%,5];


figure
plot(df_intrinsic_vector(df_intrinsic_vector<10),df_gcamp_vector(df_intrinsic_vector<10),'k.')
hold on
us=plot(intrinsic_for_fit',gcamp_for_fit','bo'),hold on
set(us,'LineWidth',2);
set(us, 'MarkerSize',12);

eb=errorbar(intrinsic_for_fit',gcamp_for_fit',std_err_gcamp_for_fit,'b')
set(eb,'LineWidth',2)

set(us,'LineWidth',2)

%plot(u,rr,'g')
% Plot the confidence interval of the fit


hold on
%plot(u,rr_low,'g:')
%plot(u,rr_high,'g:')
axis([-10 4 -15 70])
axis square
plot([-10 4],[0 0],'k:')
plot([0 0],[-15 70],'k:')
uu=gca;
set(uu,'Box','off')
xlabel('Z-score intrinsic imaging')
ylabel('Z-score fluorescent signal')
title('Supp figure 4F')

% I want to fit the responses to dtermine when the responses
% exceed the threshold
[n_odors,n_rois]=size(df_gcamp);
df_gcamp_as_vector=reshape(df_gcamp,n_odors*n_rois,1);
df_intrinsic_as_vector=reshape(df_intrinsic,n_odors*n_rois,1);
base_gcamp=df_gcamp_as_vector(df_intrinsic_as_vector>0);

clear significance center_of_intrinsic
for k=1:length(upper_limit)
    selection=(df_intrinsic_as_vector>lower_limit(k))&(df_intrinsic_as_vector<upper_limit(k));
    [h,p]=ttest2(df_gcamp_as_vector(selection),base_gcamp);
    significance(k)=p;
    center_of_intrinsic(k)=mean(df_intrinsic_as_vector(selection));
end



