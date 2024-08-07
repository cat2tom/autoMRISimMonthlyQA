
% Given a dir to get file list and sort it into dic according to data and
% time

% image directory

%imDir='C:\autoMRIMonthQA\sampleImages\zzz123456_dixon_monthlyQA_dixon^do_not_delete';

imDir='C:\autoMRIMonthQA\sampleImages\zzzz_60Chanel_60ChanelCoilCheck^check_GE'

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

% pass center slice file to getImageCenterMO

[image_center,vD,hD]= getImageCenterMO( centered_slice );

% pass to the getSNRghosting

[SNR,ghosting,output] = getSNRGhostingMO(centered_slice,image_center );

