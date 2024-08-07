function sorted_images =sortDicomImages( dicom_image_dir )
%{
To sort the dicom images according to their accquistion date and time.The
sorrted images were put into a dictionary. Date time as key and value is
the list of dicom images files name aquired at same day. 

Input:

output: 


%}  

% get all file list and datetime list

[file_list,accquistion_datetime_list] = getAccquisitionDateTime(dicom_image_dir );

% create an empty map

tmp_dict=containers.Map();


% loop the key first and then loop the files

for k=1:length(accquistion_datetime_list)
    
      % key
      
      tmp_key=accquistion_datetime_list{k};
    
      % hold the files for this key 
      tmp_file_holder={};
      
      % loop all the files
      
      for j=1:length(file_list)
          
          file_name=file_list{j}
          
          % asseble the datetime string
          
          time_stamp = getEachSliceTimeStamp(file_name);
          
          
          if strcmp(time_stamp,tmp_key)
              tmp_file_holder{j}=file_name;
              
          end 
          
          
      end 
      
      tmp_dict(accquistion_datetime_list{k})=tmp_file_holder;
    
    
    
end 

sorted_images=tmp_dict;



end

