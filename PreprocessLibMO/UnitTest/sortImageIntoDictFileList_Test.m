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

a{1};

class(a{1});

b=a{1};

b{1};