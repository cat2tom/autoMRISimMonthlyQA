function image_dict = sortImagesIntoDict(dir_IMA )
%{

This fuction is to get the list of  the accquisition date and study time in
a cell structure and list of all files in another cell structure. 

Input: dir_IMA-the directory where all IMA images were set. 

output: file_list-list of IMA files in the directory

        accquistion_datetime_list-list of acquistion date and time for all
        these file. 

useage:

%}  
% create an empty map

dict=containers.Map();


% use a cell to hold all file date and files themself.

tmp_datetime_cell={}; 

tmp_file_cell={};

% tmp_file_array=[];

% list all IMA file regarding the subfolder 

all_file_list=getFileList(dir_IMA);

all_IMA_file=listEPIDDicomFile(all_file_list);


% loop the file list to get all time stamp

for k=1:length(all_IMA_file)
    
    slice_file=all_IMA_file{k};
    
   info=dicominfo(slice_file);% added here to exclude non-standard Dicom images.

   if isfield(info,'AcquisitionDate') && isfield(info,'StudyTime')  
       
    
    time_stamp = getEachSliceTimeStamp(slice_file);
    

    tmp_file_cell{k}=slice_file;
    
    tmp_datetime_cell{k}=time_stamp;
    
   end  
        
end 


% go through the uniqued datetime cell



for k=1:length(tmp_datetime_cell)
    
    % grab each key
    
    key_tmp=tmp_datetime_cell{k};
    
    
    % find indices for each key using datetime array
    
    index_tmp=findCellStringIndex(tmp_datetime_cell,key_tmp);
    
    % find all file having same datetime using file cell array
    
    values_tmp=tmp_file_cell(index_tmp);
    
    % fill the dict
    
    dict(key_tmp)=values_tmp; 
    
    
end 

image_dict=dict;
end

