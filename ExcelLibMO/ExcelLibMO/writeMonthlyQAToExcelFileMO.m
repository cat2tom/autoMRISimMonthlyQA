function excel_file_name = writeMonthlyQAToExcelFileMO(excel_file_name,monthly_QA_results,headCell )
%{

Description: write an one dimentional cell array to an excel file. If the file exist,
read data from  it and add new data. rewrite the data into it. Assume that
the new data cell has same number colum as the data exisitng in excel file.

Input: 
       excel_file_name-the name of excel file where the results to be
       written.
       monthly_QA_resutls-cell arrray containig QA resutls. 
       headCell-the cell title appeared on excel sheet.

output: excel_file_name-the name of excel file. 


%}   

daily_QA_results=monthly_QA_results;

% if file exist.
if exist(excel_file_name,'file')
    
    % read the data from file first
    
    old_results=ReadFromExcel(excel_file_name,'all');
    
    [row,col]=size(old_results);
    
    % to see if the head included. Other wise include the head data.
    
     test= strcmp(old_results(1,1),'Date');
    
    if ~strcmp(old_results(1,1),'Date')
        
        % include the head data
        
        % Adding the head to existing data
    
%         head_data={'Date','SNR','Pecentage Uniformity','Contrast','Ghosting', ...
%         'Diagnal Distance(45 degree}','Diagnal Distance (145)','Output'};

        head_data=headCell;
    
        % merge the data.
    
          
        merged_data(1,:)=head_data;
    
        merged_data(2:row+1,:)= old_results;
        
        old_results=merged_data;
        
    end 
    
    % get the new size.
    
    [row,col]=size(old_results); 
    
    % get size of old and new data
    
    
    [row1,col1]=size(daily_QA_results);
    
    % define the range for new data. The daily QA from A to H.
    
%     added_range=strcat('A',num2str(row+1),':','H',num2str(row1+row)); % define a new square area for new data.
    added_range=strcat('A1',':','H',num2str(row1+row));
    
    %Merge teh new data into old one.
    
     old_results(row+1:row+row1,:)=daily_QA_results;
    
    % write merged data into file
    
%     Write2Excel(excel_file_name,0,added_range,daily_QA_results);
    
    Write2Excel(excel_file_name,0,added_range,old_results);
    
    
else
    
    % if the file does not exist.
    
    % Adding the head to existing data
    
%     head_data={'Date','SNR','Pecentage Uniformity','Contrast','Ghosting', ...
%         'Diagnal Distance(45 degree}','Diagnal Distance (145)','Output'};
    head_data=headCell;
    % merge the data.
    
    [row,col]=size(daily_QA_results);
    
    merged_data={};
    
    merged_data(1,:)=head_data;
    
    
    merged_data(2:row+1,:)=daily_QA_results;
    
    % write merged data into file.
    
    xlswrite(excel_file_name,merged_data);
    
    
end 



end

