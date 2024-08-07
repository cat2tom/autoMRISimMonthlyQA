% Given a dir to get file list and sort it into dic according to data and
% time

% image directory

imDir='C:\Aitang\InHouseSoftware\autoMRIMonthQA\sampleImages\zzzz_SE\unknown\MR\unknown\unknown';

% get file list

fileList=getFileList(imDir);

% get dicom file list


dicomFileList =listEPIDDicomFile(fileList);


% feed dicom file list to the test function

[imq_dic,imq_cell,op_cell,imq_struct]= getMonthlyQAResultsFileListLaserOperatorMO(dicomFileList);

keys=imq_dic.keys;


    
headCell={'DateTime',	'SNR','Uniformity',...
   	'Ghosting','Diameter','Output','Operator'};
txtFileName='test.txt';

cell2=[ imq_cell op_cell];
monthlyQACell=cell2;

% feed to test function


image_dir_name=imDir;

tmpTxtFileName='C:\Aitang\InHouseSoftware\autoMRIMonthQA\MainLibMO\UnitTest\tmpMonthlySE.txt';
recordTxtFileName='C:\Aitang\InHouseSoftware\autoMRIMonthQA\MainLibMO\UnitTest\monthlySE.txt';

matFile='C:\Aitang\InHouseSoftware\autoMRIMonthQA\MainLibMO\UnitTest\SEFileList.mat';

autoMonthlyQAProcessorDirMO(image_dir_name,tmpTxtFileName,recordTxtFileName,matFile,headCell)




% writeMonthlyQAToTxtUniqueMO( txtFileName,monthlyQACell,headCell)



