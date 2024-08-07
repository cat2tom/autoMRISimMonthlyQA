 function [centered_slice,centered_im]=findCenterSliceMO(same_day_file_list)

%{
This funciton goes through all the images contained in dir_name to find the
center slice position. 

Methodology: first sum up all pixel values and then find the maximum value
which correspond the slice containg the lagest circle.
 
Input: same_day_file_list-cell containg all file list for same day.
 
output: 
 
      centered_slice-the slice where cross line were seen most clearly
 
      centered_im: the image matrix for centered slice
 
      
 %}
% hold all summed pixel value for each slice.
tmp_values=[];
% create a map to hold the file name and mean Pixel value
dict=containers.Map();

% list all file name.
tmp1=same_day_file_list;

%2. go through all *.IMA files

for i=1:length(tmp1)
    
        
    full_file_name=tmp1{i};
    
    im=dicomread(full_file_name);
    
    summed_pixel_value=sum(im(:)); % get summmed pixel value.
    
    tmp_values(i)=summed_pixel_value;
        
    dict(num2str( summed_pixel_value))=full_file_name;
    
   
    
end 



max_tmp=max(tmp_values);

% center slice file with full path
centered_slice=dict(num2str(max_tmp));

% center slice matrix image.
centered_im=dicomread(centered_slice);


imagesc(centered_im)


end
