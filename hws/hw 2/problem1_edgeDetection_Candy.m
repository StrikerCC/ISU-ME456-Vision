clc; clear all; close all;
%% load input image and library
addpath("source\");
addpath(".\lib");
img = double(rgb2gray(imread('twoCircles.png')));   % load the image into matrix
figure
imshow(uint8(img));
%% Canny edge detection
threshold = []; %[0.5 0.6];
sigma = 10;
img_canny = 255 * edge(img,'Canny',threshold,sigma);
%% show the result
figure
imshow(uint8(img_canny));