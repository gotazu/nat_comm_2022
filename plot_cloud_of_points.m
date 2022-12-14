function u=plot_cloud_of_points(x_values,y_values,number_divisions,subsampling)
rng(1); % So it will always show the same points
%plot(matrix_mean_value_bonito,(matrix_std_matrix_error_line_fit),'k.'), hold on
% x_values=all_animals_vector_mean_matrix_odor_roi';
% y_values=sqrt(all_animals_vector_var_matrix_odor_roi');
% subsampling=1/5;
% number_divisions=10;
% I will divide the x-range in 10 parts, and then I will sample equal number
% of points i
%u=plot(all_animals_vector_mean_matrix_odor_roi',sqrt(all_animals_vector_var_matrix_odor_roi'),'k.');
min_x=min(x_values);
max_x=max(x_values);
step_size=(max_x-min_x)/number_divisions;

hold on
begin_step=min_x;
end_step=min_x+step_size;
number_samples_per_step=floor(length(x_values)*subsampling);


for k=1:number_divisions
    selection=find((x_values>=begin_step)&(x_values<end_step));
    % I will only choice
    samples_to_plot=min(length(selection),number_samples_per_step);
    x_values_in_range=x_values(selection);
    y_values_in_range=y_values(selection);
    % shuffle the points, just in case
    index_shuffler=randperm(length(x_values_in_range));
    x_values_in_range=x_values_in_range(index_shuffler);
    y_values_in_range=y_values_in_range(index_shuffler);
    
    x_values_to_plot=x_values_in_range(1:samples_to_plot);
    y_values_to_plot=y_values_in_range(1:samples_to_plot);
    
    u{k}=plot(x_values_to_plot,y_values_to_plot,'k.')
    set(u{k},'MarkerSize',24)
    begin_step=end_step;
    end_step=end_step+step_size;
end
