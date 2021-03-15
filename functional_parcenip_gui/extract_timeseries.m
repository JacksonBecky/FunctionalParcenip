function timeseries = extract_timeseries(coords, func_image)

fun_i = extract_read_image(func_image);

len = size(coords);
len = len(1);

for i = 1 : len
    
   temp = fun_i(coords(i,1), coords(i,2), coords(i,3),:);
   temp = squeeze(temp)';
   timeseries(i,:)  = temp;
    
end

end
