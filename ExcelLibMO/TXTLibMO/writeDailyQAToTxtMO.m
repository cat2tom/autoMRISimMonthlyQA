function  writeDailyQAToTxtMO( txtFileName,monthlyQACell,headCell)
%{ 
Write daily QA resutls to a txt file for later analysis.

Input: 

txtFileName-file name to be written.

dailyQACell-the cell array containing daily QA resutls.

headCell-the head appears at first lien of file.

%}

testData=monthlyQACell;


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

