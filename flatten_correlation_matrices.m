function flatten_correlation=flatten_correlation_matrices(correlation_matrix_1)
[number_samples,number_samples]=size(correlation_matrix_1);
extracted_correlation_1=NaN(1,(number_samples^2-number_samples)/2);

counter=1;
for k=1:(number_samples-1)
   
    for kk=(k+1):number_samples
        extracted_correlation_1(counter)=correlation_matrix_1(k,kk);
        
        counter=counter+1;
    end
end
flatten_correlation=extracted_correlation_1;