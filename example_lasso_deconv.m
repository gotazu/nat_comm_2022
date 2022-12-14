
load example_lasso_deconv
increased_dictionary=NaN(number_extra_elements,n_glomeruli);
increased_dictionary_trained=NaN(number_extra_elements+11,n_glomeruli);
increased_dictionary=randn(size(increased_dictionary));

% I will replace the trained dictionary with an element for
% each glomerulus.
mu=mean(df);
Sigma=cov(df);
R = mvnrnd(mu,Sigma,number_extra_elements+11);
%increased_dictionary_trained=randn(size(increased_dictionary_trained));
increased_dictionary_trained=R;



full_dictionary_trained=[trained_odor_dictionary_reordered;increased_dictionary_trained]; %full_dictionary_trained=[trained_odor_dictionary;increased_dictionary_trained];
B_basis_trained=full_dictionary_trained*NaN;
[total_dictionary_n,trash]=size(B_basis_trained);
for k=1:total_dictionary_n
    x=full_dictionary_trained(k,:);
    x=x-mean(x);
    B_basis_trained(k,:)=x/sqrt(dot(x,x));
end

% margin_correct=NaN(1,length(Ytest));
% cpa_margin_correct=NaN(1,length(Ytest));

k_distances=1;
    R=X_test(k_distances,:);
    B_only_trained = lasso(B_basis_trained',R,'Lambda',lambda);%B_only_trained = lasso(B_basis_trained',R);
    
    this_trial_go=Ytest(k_distances);
    
    go_values=B_only_trained(1:2);
    no_go_values=B_only_trained(3:4);


reordered_lasso=B_only_trained; 
figure,bar(1:2,reordered_lasso(1:2),'b')
hold on
bar(4:5,reordered_lasso(3:4),'r')
bar(7:11,reordered_lasso(5:9),'k')
other_elements=reordered_lasso(10:end)
for_plot_others=(1:length(other_elements))/length(other_elements)*30+12;
stem(for_plot_others,other_elements,'k')
a=gca
%set(a,'YTick',[0 0.1 0.2 0.3])
%set(a,'XTick',[1 2 4 5 7:11 max(for_plot_others)])
axis([0 max(for_plot_others) 0 4])
set(a,'XTick',[1.5,3.5,7,9, 250]),set(a,'XTickLabel',[])
set(a,'Box','off')
axis([0 max(for_plot_others) 0 20])
legend('Go odor','No Go','Known background','Other dictionary elements')
xlabel('Dictionary number')
ylabel('Lasso estimated concentration')
title('Figure 7E') 
