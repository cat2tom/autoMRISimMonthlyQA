function output = getOutPutMO(slice_file_name,image_center )
%{ 


Description: A concept of output similar to LA was proposed as Smean/Sdt over 
             a region defined on center slice. It was found that it was
             good indices to indicate the machine performance. 

Input: slice_file_name-the full path file name for non-centered slice.

       image_center-the coordinates of image center in pixel.

output: output=Smean/Sdt.


%}


%1.load image and find pixel size
I=dicomread(slice_file_name);
pxl_sz=fun_DICOMInfoAccess(slice_file_name,'PixelSpacing');
if pxl_sz(1,1)~=pxl_sz(2,1)
    h=errordlg(['Your image is not isotropic!'...
        'Please check pixel size. I continue from here though.']);
    uiwait(h);
end

%2. find the center of FOV in pixel

% lenght and with of square and separations

side_px=26;

sep_px=6; 

[row,col]=size(I);

x_center_px=image_center(1);

y_center_px=image_center(2);

% 3. create centered square.

xmin=x_center_px-side_px/2;


xmax=x_center_px+side_px/2;
ymin=y_center_px-side_px/2;
ymax=y_center_px+side_px/2;

sqx1=[xmin xmin xmax xmax xmin];
sqy1=[ymin ymax ymax ymin ymin];
BW_1=roipoly(I,sqx1,sqy1);
ROI_1=fun_apply_mask(I,BW_1);
ROI_1_mu=sum(sum(ROI_1))/size(find(ROI_1),1);%ROI 1 mean

ROI_1_std=std(ROI_1(:));

output=ROI_1_mu/ROI_1_std;% changed use ROI SNR as output.

%4. Plot images


imH=figure;

imshow(I,[]);
hold on;
plot(sqx1,sqy1,'r');

hold off;

% close(imH);

end

