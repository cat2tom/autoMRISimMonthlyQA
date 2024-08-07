function [PIU,output] = getUniformityMO(slice_file_name,image_center )
%{ 

This function is to calculate percentage image intensity unifromity and
contrast factor using non-centered slice. 8 circle regons were defined in
water and contrast regions.

Input: slice_file_name-the full file path name containing the non-centered
slice.

output: PIU=100*(1-(maxS-minS)/(maxS+minS).ACR definition.
             
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

[row,col]=size(I);

x_center_px=image_center(1);

y_center_px=image_center(2);

% 3.  set the circle area in cm^2 and calculate the radius.

area_ROI_water=3; % 3 cm circle for water region

radius_cm=sqrt(area_ROI_water/pi);
radius_mm=radius_cm*10;
radius_pxl=radius_mm/pxl_sz(1,1);%from this line, use ellipse ROI if image
theta=0:0.01:2*pi;      

area_ROI_water2=0.8; % 0.8 cm circle for contrast region

radius_cm2=sqrt(area_ROI_water2/pi);
radius_mm2=radius_cm2*10;
radius_pxl2=radius_mm2/pxl_sz(1,1);%from this line, use ellipse ROI if image
theta=0:0.01:2*pi;      



%is anisotropic (see test.m for working)

%4. create the centered circle

ind_centre=[y_center_px,x_center_px];

xC=radius_pxl*cos(theta)+double(ind_centre(1,2));
yC=radius_pxl*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xC,yC);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSCenter=I_ROI_water_mean;

%5. Create left circle

% shifted up by 2 px in y and 40 px in x separation.
ind_centre=[y_center_px-2,x_center_px-35];% 35 pixel separation in x, shifted up by 3px.

xL=radius_pxl*cos(theta)+double(ind_centre(1,2));
yL=radius_pxl*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xL,yL);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSL=I_ROI_water_mean;

% 6. create right circle

ind_centre=[y_center_px-2,x_center_px+35];% 35 pixel separation in x, shifted up by 3px.

xR=radius_pxl*cos(theta)+double(ind_centre(1,2));
yR=radius_pxl*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xR,yR);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSR=I_ROI_water_mean;

% 7. Create Top circle

ind_centre=[y_center_px-32,x_center_px];% 32 pixel separation in y, shifted up by 3px.

xT=radius_pxl*cos(theta)+double(ind_centre(1,2));
yT=radius_pxl*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xT,yT);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanST=I_ROI_water_mean;

% 8 Create the bottom circle
ind_centre=[y_center_px+32,x_center_px];% 32 pixel separation in y, shifted up by 3px.

xB=radius_pxl*cos(theta)+double(ind_centre(1,2));
yB=radius_pxl*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xB,yB);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSB=I_ROI_water_mean;

%9 create UP left circle in high signal region

ind_centre=[y_center_px-25,x_center_px-25];% 32 pixel separation in y and x

xUL=radius_pxl2*cos(theta)+double(ind_centre(1,2));
yUL=radius_pxl2*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xUL,yUL);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSTL=I_ROI_water_mean;

%10 create bottom right circle in high signal region

ind_centre=[y_center_px+25,x_center_px+25];% 25 pixel separation in y and x

xBR=radius_pxl2*cos(theta)+double(ind_centre(1,2));
yBR=radius_pxl2*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xBR,yBR);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSBR=I_ROI_water_mean;

%11 create bottom left circle in high signal region

ind_centre=[y_center_px+21,x_center_px-21];% 20 pixel separation in y and x

xBL=radius_pxl2*cos(theta)+double(ind_centre(1,2));
yBL=radius_pxl2*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xBL,yBL);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSBL=I_ROI_water_mean;

%12. Create Top right circle in contrast region.

ind_centre=[y_center_px-21,x_center_px+21];% 22 pixel separation in y and x

xTR=radius_pxl2*cos(theta)+double(ind_centre(1,2));
yTR=radius_pxl2*sin(theta)+double(ind_centre(1,1));
BW=roipoly(I,xBR,yBR);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSTR=I_ROI_water_mean;

%13. Calculate PIU

maxWaterS=max([meanSL,meanSR,meanST,meanSB]);

minWaterS=min([meanSL,meanSR,meanST,meanSB]);

PIU=100*(1-(maxWaterS-minWaterS)/(maxWaterS+minWaterS));


% use mean water signal as output
meanWaterS=mean([meanSL  meanSR  meanST meanSB]);
output=meanWaterS;

%4. Plot images


imH=figure;

imshow(I,[]);
hold('on');
plot(xC,yC,'r',xL,yL,'r',xR,yR,'r',xT,yT,'r',xB,yB,'r',xUL,yUL,'g'...
     ,xBR,yBR,'g',xBL,yBL,'g',xTR,yTR,'g');
 
hold('off');

 close(imH);
end

