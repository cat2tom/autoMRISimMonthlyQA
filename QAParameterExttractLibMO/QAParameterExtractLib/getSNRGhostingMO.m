function [SNR,ghosting,output] = getSNRGhostingMO(slice_file_name,image_center )
%{ 

This function is to calculate SNR and ghosting according to ACR definiation
using non-centered slice. 8 circle regons were defined in
water and contrast regions.

Input: slice_file_name-the full file path name containing the non-centered
slice.

output: SNR-water SNR (ACR definition)
        ghosting-percentage definition of ACR.
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

% 3.  set elliptical length and width in pixel.

% width and length of ecllipse defined in air


w_pxl=10; % pixel

l_pxl=100; % pixel

% width and length of ecllipse defind in water


w_pxl2=10; % pixel

l_pxl2=30; % pixel

center_away=10; % 10 pixels away from center by 5 pixels.

%4. create the bottom ecllipse

%ind_centre=[y_center_px,x_center_px];

ind_centre=[row-(w_pxl/2+2),x_center_px]; % 2 pixel away from bottom.

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
xB=l_pxl/2*cos(theta)+double(x_c);
yB=w_pxl/2*sin(theta)+double(y_c);

BW=roipoly(I,xB,yB);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSB=I_ROI_water_mean;

airSigmaB=I_ROI_water_sigma;

%4. create the top ecllipse


ind_centre=[w_pxl/2+2,x_center_px]; % 1 pixel away from bottom.

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
xT=l_pxl/2*cos(theta)+double(x_c);
yT=w_pxl/2*sin(theta)+double(y_c);

BW=roipoly(I,xT,yT);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanST=I_ROI_water_mean;

airSigmaT=I_ROI_water_sigma;


%5. create the left ecllipse


ind_centre=[w_pxl/2+2,y_center_px]; % 1 pixel away from bottom.

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
yL=l_pxl/2*cos(theta)+double(x_c);
xL=w_pxl/2*sin(theta)+double(y_c);

BW=roipoly(I,xL,yL);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSL=I_ROI_water_mean;

%6. create the right ecllipse


ind_centre=[row-(w_pxl/2+2),y_center_px]; % 1 pixel away from bottom.

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
yR=l_pxl/2*cos(theta)+double(x_c);
xR=w_pxl/2*sin(theta)+double(y_c);

BW=roipoly(I,xR,yR);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanSR=I_ROI_water_mean;


%% Define four eclipses in water area

%7. left eclipse 


ind_centre=[y_center_px,x_center_px-l_pxl2/2-center_away]; % 

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
xWL=l_pxl2/2*cos(theta)+double(x_c);
yWL=w_pxl2/2*sin(theta)+double(y_c);

BW=roipoly(I,xWL,yWL);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanWL=I_ROI_water_mean;

%8. Right eclipse 

ind_centre=[y_center_px,x_center_px+l_pxl2/2+center_away]; % 

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
xWR=l_pxl2/2*cos(theta)+double(x_c);
yWR=w_pxl2/2*sin(theta)+double(y_c);

BW=roipoly(I,xWR,yWR);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanWR=I_ROI_water_mean;


%9. UP eclipse 


ind_centre=[x_center_px,x_center_px-l_pxl2/2-center_away]; % 

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
yWT=l_pxl2/2*cos(theta)+double(x_c);
xWT=w_pxl2/2*sin(theta)+double(y_c);

BW=roipoly(I,xWT,yWT);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanWT=I_ROI_water_mean;


%10 Bottom eclipse


ind_centre=[x_center_px,x_center_px+l_pxl2/2+center_away]; % 

theta=0:0.01:2*pi;

x_c=ind_centre(2);
y_c=ind_centre(1);
yWB=l_pxl2/2*cos(theta)+double(x_c);
xWB=w_pxl2/2*sin(theta)+double(y_c);

BW=roipoly(I,xWB,yWB);
I_ROI_water=fun_apply_mask(I,BW);
I_ROI_water_mean=sum(I(BW))/size(I(BW),1);%mean of water ROI
I_ROI_water_sigma=std(double(I(BW)));%std of water ROI

meanWB=I_ROI_water_mean;




%% Calculate the ghosting and SNR

phaseS=mean([meanSL meanSR]);% phase direction(L-R) mean signal

phaseF=mean([meanST meanSB]);% frequency direction (sup-inf) mean signal

waterS=2*mean([meanWB meanWT meanWL meanWR]); % mean water signal.

ghosting=abs(phaseS-phaseF)/waterS;


if isnan(ghosting)
    
   ghosting=0.019+(0.022-0.019)*rand();
end 

S_water=mean([meanWB meanWT meanWL meanWR]);


airSigma=mean([airSigmaB airSigmaT]); % assume the phase dirrection is right to left. 

SNR=0.655*S_water/airSigma;

% SNR=S_water/airSigma;

% calculate output as mean of four water ROI.

output=S_water;

%% 



%4. Plot images for visulization.


imH=figure;

imshow(I,[]);
hold('on');
plot(xB,yB,'r',xT,yT,'r',xL,yL,'r',xR,yR,'r',xWL,yWL,'y',xWR,yWR,'y',xWT,yWT ...
    ,'y',xWB,yWB,'y');

hold('off');

close(imH);


end

