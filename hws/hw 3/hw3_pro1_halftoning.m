clc; clear all; close all;
%% load input image
img = rgb2gray(imread('David_by_Michelangelo_Fir_JBU013.jpg'));   % load the image into matrix
figure
imshow(img);

[rows_img, cols_img,~] = size(img);   % image size
img_dither = ones(rows_img, cols_img, 3)*255;
%% error-diffusion dithering
[cols, rows] = size(img);
bij = zeros(cols,rows);
eij = zeros(cols,rows);

h = 1/42 *[0 0 0 8 4;
    2 4 8 4 2;
    1 2 4 2 1];
[col_h, row_h] = size(h);
center_col = 1;
center_row = (row_h+1)/2;

[cols, rows] = size(eij);
% errADD = zeros(cols, rows);

for i = center_col+col_h-1:cols-center_col
    for j = center_row:rows-center_row
        
        errAdd_ele = zeros(col_h, row_h);
        for k = 1:col_h
            for l = 1:row_h
                a = i-(k-center_col);
                b = j-(l-center_row);
                errAdd_ele(k,1) = h(k,l)*eij(a,b);
            end
        end
        errAdd = sum(sum(errAdd_ele));
        
        if(img(i,j) + errAdd > 127.5)
            bij(i,j) = 255;
            eij(i,j) = img(i,j) + errAdd -255;
        else
            bij(i,j) = 0;
            eij(i,j) = img(i,j) + errAdd;
        end
    end
end

figure
imshow(uint8(eij));
title('eij');

figure
imshow(uint8(bij));
title('bij');