clc; clear all; close all;
%% load input image and library
addpath("source\");
addpath(".\lib");
img = double(rgb2gray(imread('Noisy_checkboard.png')));   % load the image into matrix
%% apply filter
sigma = 1;
img_filtered = imgaussfilt(img,sigma);
figure
imshow(uint8(img_filtered));
hold on
%% apply harris corner detection 
name = ["MinQuality","FilterSize","ROI"];
%% MinQuality
figure
imshow(uint8(img_filtered));
hold on
value = 0.005;
coord_corner = detectHarrisFeatures(img_filtered,name(1),value);
x = coord_corner.Location(:,1);
y = coord_corner.Location(:,2);
scatter(x,y);
title(name(1));
%% FilterSize
figure
imshow(uint8(img_filtered));
hold on
value = 23;
coord_corner = detectHarrisFeatures(img_filtered,name(2),value);
x = coord_corner.Location(:,1);
y = coord_corner.Location(:,2);
scatter(x,y);
title(name(2));