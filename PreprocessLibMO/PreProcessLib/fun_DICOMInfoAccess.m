function [fld_value]=fun_DICOMInfoAccess(I_path,fld_name)
% This function read the DICOM image info and get the value of any info
% user specified
%
% Input:
%   I_path (optional)
%   fld_name (optional)
% Output:
%   fld_value
% Usage: 
%   pxl_size=fun_DICOMInfoAccess()
%   pxl_size=fun_DICOMInfoAccess('img_path','PixelSpacing')
% HW: (search for HW)
%    image path is HW if no path input then read this path
%
% Author: Jidi Sun
% Version: v.1
% History: v.1 (27/03/13)
% 
% Copyright: Please consult with the University of Newcastle before using
%            this script outside the University of Newcastle and Calvary 
%            Mater Hospital.
%
% Acknowledgement: My study is funded by the Cancer Council NSW, Australia,
%                  project grant RG11-05. PhD under the University of 
%                  Newcastle and the Calvary Mater Newcastle Hospital 
%                  provides me the office and the MR scanner to work with.

%1.check if I_path input exists
if ~exist('I_path','var')||isempty(I_path)
    [f_n,p_n]=uigetfile('test_images\S1.dcm');%HW:image path
    I_path=fullfile(p_n,f_n);
end
%2.check if fld_name input exist
if ~exist('fld_name','var')||isempty(fld_name)
    disp('Here are common names for Matlab:');
    disp('Numeric:');
    disp('               Pixel size (mm): PixelSpacing');
    disp('          Slice thickness (mm): SliceThickness');
    disp('                Slice gap (mm): SpacingBetweenSlices');
    disp('          Repetition time (ms): RepetitionTime');
    disp('                Echo time (ms): EchoTime');
    disp('                   Matrix size: Rows/Columns or Width/Height');
    disp('                   Echo number: EchoNumber');
    disp('Number of phase encoding steps: NumberOfPhaseEncodingSteps');
    disp('                    Flip angle: FlipAngle');
    disp('                           SAR: SAR');
    disp('String:');
    disp('                      Modality: Modality');
    disp('                 Sequence name: SeriesDescription');
    disp('                      Sequence: ScanningSequence');
    disp('              Acquisition type: MRAcquisitionType');
    disp('                 Protocol name: ProtocolName');
    disp('              Acquisition time: AcquisitionTime');
    disp('                  Content time: ContentTime');
    disp('                   Series time: SeriesTime');
    fld_name=input('Which field do you want to search?\n','s');
end
%3.read DICOM info
info=dicominfo(I_path);
%4.get the value
fld_value=getfield(info,fld_name);
end