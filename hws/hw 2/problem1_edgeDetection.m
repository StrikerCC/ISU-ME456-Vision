clc; clear all; close all;
%% load input image and library
addpath("source\");
addpath(".\lib");
img = rgb2gray(imread('twoCircles.png'));   % load the image into matrix
figure
imshow(uint8(img));
%% LoG edge detection  
filterSize = 7;
sigma = 0.2;
filter_LoG_3 = fspecial('log',filterSize,sigma);
%% apply LoG filter to the image 
img_filtered = filter_self(img,filter_LoG_3);
%% establish threshold
threshold_neighborDiffer = 3200;
threshold_pixel = 0.2;
[rows_img, cols_img,~] = size(img);   % image size
img_thresholded = zeros(rows_img, cols_img);
for i = 2:rows_img-1
%     intens_max = maxk(img_filtered(i,:),10);
%     intens_min = mink(img_filtered(i,:),10);
%     threshold_neighborDiffer = abs(intens_max(3)-intens_min(3));
%     if(threshold_neighborDiffer==0)
%         threshold_neighborDiffer = 3100;
%     end
   for j = 2: cols_img-1
       pixel_center = img_filtered(i,j);
       pixel_left = img_filtered(i-1,j);
       pixel_right = img_filtered(i+1,j);
       pixel_up = img_filtered(i,j+1);
       pixel_low = img_filtered(i,j-1);
       if (abs(pixel_center)>threshold_pixel)
           if(pixel_left*pixel_right < 0 && abs(pixel_left - pixel_right)>threshold_neighborDiffer)
               img_thresholded(i,j) = 255;
           elseif (pixel_up*pixel_low < 0 && abs(pixel_up - pixel_low)>threshold_neighborDiffer)
               img_thresholded(i,j) = 255;
           end
       end
   end
%    fprintf('%5.3f  %5.3f %5.3f \n',max(img_filtered(i,:)), min(img_filtered(i,:)), threshold_neighborDiffer);
end
%% show the result of threshold image 
figure
imshow(uint8(img_thresholded));