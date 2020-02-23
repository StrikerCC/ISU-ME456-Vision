clc; clear all; close all;
%% load input image
img = imread('IMG_2504 me.jpg');   % load the image into matrix
figure
imshow(uint8(img));

[rows_img, cols_img,~] = size(img);   % image size
img_blank = ones(rows_img, cols_img, 3)*255;
%% RGB
img_RGB = img_blank;
for i = 2:rows_img-1
    for j = 2: cols_img-1
        R = img(i,j,1);
        G = img(i,j,2);
        B = img(i,j,3);
        if (R>95 && G>40 && B>20 && R>G && R>B && abs(R-G)>15)
            img_RGB(i,j,1) = 0;
            img_RGB(i,j,2) = 0;
            img_RGB(i,j,3) = 0;
        end
    end
end
figure
imshow(uint8(img_RGB));
%% Normalized rgb
img_NormalizedRGB = img_blank;
map_R = img(:,:,1);
map_G = img(:,:,2);
map_B = img(:,:,3);
for i = 2:rows_img-1
    for j = 2: cols_img-1
        R = map_R(i,j);
        G = map_G(i,j);
        B = map_B(i,j);
        r = double(R)/(double(R)+double(G)+double(B))*255;
        g = double(G)/(double(R)+double(G)+double(B))*255;
        b = double(B)/(double(R)+double(G)+double(B))*255;
        if (r>95 && g>40 && b>20 && r>g && r>b && abs(r-g)>15)
            img_NormalizedRGB(i,j,1) = 0;
            img_NormalizedRGB(i,j,2) = 0;
            img_NormalizedRGB(i,j,3) = 0;
        end
    end
end
figure
imshow(uint8(img_NormalizedRGB));
%% build-in function
img_hsv = rgb2hsv(img);
figure
imshow(uint8(img_hsv*255));
