
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

imq_dic.keys

imq_dic.values


