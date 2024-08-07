
function autoMonthlyQAProcessorSingleConfigFileMO(oneConfigFile)

%{
Description: Given a sigle confige file for one sequence, this function will do all anaysis.

Input: dirs a cell read from config file and contains the follows.

       image_dir_name-directory where all MRI images are stored. 

    
       tmpTxtFileName-txt file name for temporary recording the new QA
       resutls.
       
       recordTxtFileName-txt file for all QA resutls recorded.

       
       mat_file-record the file list history.

       headCell-the cell containig the headline for txt file.


Notice: this version has no images added to the pdf report. 
        added write to excel file function. 

        added database connection.
        added laser support.
        added file list support. Save a file list into a .mat file. Then 
        Next time when the server restarts, it will pick up whatever was
        left last time. 

        This version  is intenede to be used along with window task to run the program. 
        

%}

% read dirs from one single file.

dirs=readConfigFileMO(oneConfigFile); %

% get the dirs from dirs cell structures.

image_dir_name=dirs{1}; % directory where all patient QA images sit

tmpTxtFileName=dirs{2}; % txt file holding new QA resutls for new added images list

recordTxtFileName=dirs{3};% use as txt database holding all QA restuls.

headCell=dirs{4};% cell structrue containing the head title for txt file.

mat_file=dirs{5};% matlab mat file to record the QA file history.


% Read file from the matfile to get the file list last time 

previousFileList={}; % holding the file list before the loop start

% mat file is located in N drive.


if exist(mat_file,'file')==2
    
    mat_obj=matfile(mat_file,'Writable',true);
    
    previousFileList=mat_obj.previousFileList;
    
    
else   
    
     save(mat_file,'previousFileList');
    
end 

% copy the images file to a writable directory 

% get the file list before loop starts.

dir_content =dir(image_dir_name);



dirIndex_last = [dir_content.isdir];   
fileList_last = {dir_content(~dirIndex_last).name}'; % get the current list of function. 
filenames =fileList_last;


current_files = filenames;


% pre process the file list before loop starts.

pNewFileList=setdiff(current_files,previousFileList);

% process the new file list.


if ~isempty(pNewFileList)
        
        % process the new files.
        
       disp(['Processing the files from dir:  '  image_dir_name]);        
       disp( [ 'total: '  num2str(length(pNewFileList)) ' :new file were found before the loop starts.']) 
       
       % Set the number of new imags to be 11 as each QA images contains 11
       % images. 128 slice is for SE. other is 113 and 320.
       %if rem(length(pNewFileList),128)==0 || rem(length(pNewFileList),113)==0 || rem(length(pNewFileList),320)==0 % as 128 images for each QA, then to see if all 10 images arrived.
                      
           % the key part for auto processing the images and auto report
           % generation.
           
           % full path to the file which are required by 
           
            pNewFileList2=fullfile(image_dir_name,pNewFileList);
            
          
           
           % call main function to process the file list.
           
    
           
            [dic,cell,op_cell,strct]= getMonthlyQAResultsFileListLaserOperatorMO(pNewFileList2); % pNewFileLis2-cell containing all new dicom file list
            
            % write resutls to tmp.txt.
            
            cell2=[cell op_cell'];
          
            
            tmpFileName=tmpTxtFileName;
            
       
            writeMonthlyQAToTxtUniqueMO(tmpFileName,cell2,headCell);
           
                   
           
          
           % write the daily QA resutls to text file for analysis and
           % recored.
           
            writeDailyQAToTxtMO(recordTxtFileName,cell2,headCell);
           
           % use the cell containing QA resutls to generate pdf report. 
           
    
                        
           close all
           
       %end % remove the number of slice restrictions for each sequences. 
       
end 

% after finished write the differnce to file


previousFileList=[ previousFileList; pNewFileList(:) ]; % flatten the file and concatenate two files. 


save(mat_file,'previousFileList');

% cleanup to delete temp files.
%delete('C:\autoMRItmp\*.*');
%     
 end