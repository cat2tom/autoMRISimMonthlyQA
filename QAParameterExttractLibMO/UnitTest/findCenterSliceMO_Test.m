
% Given a dir to get file list and sort it into dic according to data and
% time

% image directory

imDir='C:\Aitang\InHouseSoftware\autoMRIMonthQA\sampleImages\zzzz_SE\unknown\MR\unknown\unknown';

% get file list

fileList=getFileList(imDir);

% get dicom file list


dicomFileList =listEPIDDicomFile(fileList);


% sor the file list


image_dict = sortImagesIntoDictFileList(dicomFileList );

image_dict.keys;



a=image_dict.values;

% one file list

oneDayFileList=a{1}; 

class(oneDayFileList);

[centered_slice,centered_im]=findCenterSliceMO(oneDayFileList);

centered_slice

imagesc(centered_im);
