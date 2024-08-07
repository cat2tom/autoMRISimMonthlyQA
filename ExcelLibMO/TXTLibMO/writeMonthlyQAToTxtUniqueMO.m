function  writeMonthlyQAToTxtUniqueMO( txtFileName,monthlyQACell,headCell)
%{ 
Write daily QA resutls to a txt file for later analysis.

Input: 

txtFileName-file name to be written.

monthlyQACell-the cell array containing monthly QA resutls.

headCell-cell containg the head for file.

This version is to remove the duplicated QA resutls from the file.

%}

testData=monthlyQACell;


% newTableQA=cell2table(testData,'VariableNames',{'DateTime',	'SNR','Uniformity',...
%     'Contrast',	'Ghosting','D45','D135','Output','LaserX',	'LaserY',	'LaserZ','Operator'});



newTableQA=cell2table(testData,'VariableNames',headCell);


if exist(txtFileName,'file')==2
    
   oldTableQA=readtable(txtFileName,'Format','%s%f%f%f%f%f%s');
   
   tableQASum=[oldTableQA;newTableQA];
   
   tableQASum=unique(tableQASum);
   
   writetable(tableQASum,txtFileName);
  
else
    
  writetable(newTableQA,txtFileName); 

end 


end

