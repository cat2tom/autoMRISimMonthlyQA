function [image_center,vDiameterInMM,hDiameterInMM]= getImageCenterMO( slice_file_name )
%{

Description: This function is to get the coordinates of image center using
centroid centers of images and calculate two diameters passing through the
cener.

Input: slice_file_nanme-the center-slice file name
Output: image_center-coodinates of image center
        vDiameterInMM-vertical diameters in mm
        hDiameterInMM-horizontal diameter in mm

 Note: added support if the images are not properly accquired.

%}  

%load image and find pixel size
I=dicomread(slice_file_name);
pxl_sz=fun_DICOMInfoAccess(slice_file_name,'PixelSpacing');
if pxl_sz(1,1)~=pxl_sz(2,1)
    h=errordlg(['Your image is not isotropic!'...
        'Please check pixel size. I continue from here though.']);
    uiwait(h);
end



% get the image matrix

im=dicomread(slice_file_name);

% get shreshold 

level=graythresh(im);

% convert to BW 

bw=im2bw(im,level);

% set element structure and closing images

se=strel('disk',5);

closed_bw=imclose(bw,se);

% open the image to remove two small dots

opened_bw=imopen(closed_bw,se);



% get the centroid of region

region_prop=regionprops(opened_bw,'Centroid'); % Centroid ordered from top to bottom 
                                               %then left to right.

% get the x, y of centroids for points: LT,LB, RT,RB

if ~isempty(region_prop) && length(region_prop)==1 % added equal conditions if the four high constrast regions not found and in some case then non-centered slice is not as normal before.

   % get the x, y of centroids for points: LT,LB, RT,RB
   Tx=region_prop(1).Centroid(1);

   Ty=region_prop(1).Centroid(2);


   
 
    x_pixel=Tx;

    y_pixel=Ty;


    image_center=[x_pixel  y_pixel];

    % round to integer

    image_center=int16(image_center);
    
    % to calculate two diameters vertical and horizantal diameters using
    
    
    vVect=opened_bw(:,image_center(1));
    
    hVect=opened_bw(image_center(2),:);
    
    vTemp=find(vVect);
    hTemp=find(hVect);
    
    vDiameterInPixel=abs(vTemp(end)-vTemp(1));
    
    hDiameterInPixel=abs(hTemp(end)-hTemp(1));
    
    vDiameterInMM=vDiameterInPixel*pxl_sz(1,1); % vertical diameters
    
    hDiameterInMM=hDiameterInPixel*pxl_sz(2,1); % horizontal diameters
    
   % visual show.

   imH=figure;
   imshow(opened_bw);

   hold on ;


   for k=1:length(region_prop)
    
       plot(region_prop(k).Centroid(1),region_prop(k).Centroid(2),'r*');
    
    
   end 

   plot(x_pixel,y_pixel,'g*');
   
   hold off;
   
     
    close(imH);
   
  

else
    
    image_center=[size(I,2)/2, size(I,1)/2];% using FOV center instead.
    
    vDiameterInMM=size(I,2)/2*pxl_sz(1,1); % added to deal with dixon. 
    
    hDiameterInMM=size(I,1)/2*pxl_sz(1,1);
    
        

end 


end

