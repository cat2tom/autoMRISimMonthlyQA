function time_stamp = getEachSliceTimeStamp(slice_file_name)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here



   info=dicominfo(slice_file_name);

   if isfield(info,'AcquisitionDate') && isfield(info,'StudyTime')  
       
      accquisition_date=info.AcquisitionDate;

      study_time=info.StudyTime;
      
      % get the time only down to seconds.
      
      [c,m]=strsplit(study_time,'.'); % split string using '.'.
      
      study_time=c{1}; % use only the minues and seconds parts. 
           
    
      time_stamp=strcat( accquisition_date,'.',study_time);% use . to separate the date and time 
                                                           % for writting
                                                          % it into
                                                           % database.
    
   end 
       
          
       
end

