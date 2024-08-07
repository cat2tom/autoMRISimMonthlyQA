function [imq_dic,imq_cell,op_cell,imq_struct]= getMonthlyQAResultsFileListLaserOperatorMO(image_file_list)
%{
Descripttion: Given a list of QA files in the cell structure.
,
function store the daily QA resutls into three data structures:dictionary,
cell and structrue. only cell structrue was used by other functions. 

This version is the file list version.

Input: image_file_list-a list of QA dicom files just added into the directory.
       cell array containg all the dicom files in one directory which is returned by listEPIDDicomFile.
ouput:
       image_file_list-dictioary to save the resuls. key: accquistion date/time
                                              value: Vector containg QA
                                              prameters.
       imq_cell-cell constainging date/time, and other QA results. This is
       data structure used by other modules and functions. 
       op_cell-the operator cell.

       % added Opeator support for updating QATrack on 23/03/2016.

%}  


% create an operator cell

operator_cell={};

% create a cell 

image_quality_cell={};

% create a struct

image_quality_struct=struct([]);

% create a dict to hold the data

image_quality_dic=containers.Map();

% get file list for all dates.

image_dict = sortImagesIntoDictFileList(image_file_list);

% go through dates

dates=keys(image_dict);

for k=1:length(dates)
    
    key_tmp=dates{k};% get the data/time for one day QA resutls.
    
    file_list=image_dict(key_tmp);% get all image file list corresponding to one day accquistion.
    
    % get operator Name if RT typed in to update QA track with Operator
    % Name.
    
    tmp=dicominfo(file_list{1});
    
    operatorName='Physicist';
    
    if isfield(tmp,'OperatorName')
        
        operatorName1=tmp.OperatorName;
        
         operatorName=operatorName1.FamilyName;
        
    end 
        
    operator_cell{k}=operatorName;
    
    % extract all image quality indices.
    [centered_slice,centered_im]=findCenterSliceMO(file_list); % sortted to find center and non-center slices.   
    
    [image_center,vDiameterInMM,hDiameterInMM]= getImageCenterMO( centered_slice ); % get geometric parameters
    
    output2 = getOutPutMO( centered_slice,image_center );% get output parametrs
    
    [uniformity,~] = getUniformityMO( centered_slice,image_center );% get unifromity, output not used
    
    [SNR,ghosting,~] = getSNRGhostingMO( centered_slice,image_center ); % get SNR and ghosting, output not used.

        
    % Assemble the resqults into array[ SNR  uniformity, contrast, ghosting
    % distance_m_45  distance_m_135  output].
    
    
    im_quality=[SNR  uniformity  ghosting   hDiameterInMM  output2] % added laser support.
    
   
    
    % get rid of nan resutls for dict
    if ~any(isnan(im_quality))
        
       image_quality_dic(key_tmp)=im_quality;
       
              
    end 

    % fill the cell in same order and this is the main structue used for
    % the whole program.  Added round for html form validation.
    
    if ~any(isnan(im_quality))
        
       image_quality_cell{k,1}=key_tmp;
       image_quality_cell{k,2}=round(SNR,3);
       
       image_quality_cell{k,3}=round(uniformity,3);
       
            
       image_quality_cell{k,4}=round(ghosting,4);
       
       image_quality_cell{k,5}=round(hDiameterInMM,3);
       
              
       image_quality_cell{k,6}=round(output2,3);
       
             
                         
                 
    end 
    
    % fill the cell in same order
    if ~any(isnan(im_quality))
        
       image_quality_struct{k}.date=key_tmp;
       
       image_quality_struct{k}.SNR=SNR;
       
       image_quality_struct{k}.uniformity=uniformity;
       
      
       
    else
        
        % remove the empty element
        
        image_quality_struct{k}=[];
              
    end 
    
    % close all figures after each QA analysis.
    
    
    close all; 
    
    
end

   % assign the dictionary structure.
   
   imq_dic=image_quality_dic;
   
   % remove nan cell element first and assign the resutls to cell outptu.
   
   
   image_quality_cell=image_quality_cell(~cellfun('isempty',image_quality_cell));
   
   
   image_quality_cell=reshape(image_quality_cell,[],6); % reshape it to have 11 coloumn.
   
   imq_cell=image_quality_cell;
   
   % Assign QA resutls to structure quality. 
   
   imq_struct=image_quality_struct;
   
   % assign operator cell 
   
   op_cell=operator_cell;
   
   close all; % close all figures for each QA analysis.

end 
