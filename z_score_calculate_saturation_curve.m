load z_score_calculate_saturation_curve
% Fit a line 
figure
axis square
plot([-10 0] , [-10 0],'k')
hold on
axis square
sum_of_glom_activity_all=df_all(1,:)+df_all(2,:);

activity_of_sum_all=df_all(3,:);

larger_than_zero=(df_all(3,:)<0)&(df_all(2,:)<0)&(df_all(1,:)<0);

line_through_origin = @(k,xdata) k*xdata;
saturating_hyperbola_through_origin = @(A,xdata) 2*A(1)./(1+exp(xdata*A(2)))  - A(1);

A0=[-5,3];
xdata=sum_of_glom_activity_all(larger_than_zero);
ydata=activity_of_sum_all(larger_than_zero);
plot(xdata,ydata,'ro')
A = lsqcurvefit(saturating_hyperbola_through_origin,A0,xdata,ydata);


plot_x_data=-10:0.001:0;
fitted_hyperbola=saturating_hyperbola_through_origin(A,plot_x_data);

plot(plot_x_data,fitted_hyperbola,'g')
axis([-10 0 -10 0])
axis square


s=(ydata-xdata)./xdata;
fitted_hyperbola_for_calculation=saturating_hyperbola_through_origin(A,xdata);
s_hyp=(fitted_hyperbola_for_calculation-xdata)./xdata;
mean(s_hyp)
std(s_hyp)/sqrt(length(s_hyp))


std(ydata-fitted_hyperbola_for_calculation)
xlabel('Z-score A  plus  z-score of odor B')
ylabel('Z-score of odor A and odor B presented simultaneously')
title('Supp Figure 13B ')

