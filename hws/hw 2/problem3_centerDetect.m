clc; clear all; close all;
%% load input image and library
addpath("source\");
addpath(".\lib");
img = double(rgb2gray(imread('twoCircles.png')));   % load the image into matrix
%% apply gassu filter
sigma = 1;
img_filtered = imgaussfilt(img,sigma);
figure
imshow(uint8(img_filtered));
%% find edge 
threshold = []; %[0.5 0.6];
sigma = 10;
img_canny = 255 * edge(img,'Canny',threshold,sigma);
figure
imshow(uint8(img_canny));
hold on
%% center detection
r = [40 60];
[accum, centers, r_est] = CircularHough_Grd(img_filtered,r);
scatter(centers(:,1),centers(:,2));
%% compute the distance
distance_vector = centers(2,:) - centers(1,:);
distance_scale = norm(distance_vector,2);
%% show the results
hold on
scatter(centers(:,1),centers(:,2));
plot([centers(1,1),centers(1,1) + distance_vector(1)],[centers(1,2),centers(1,2)+distance_vector(2)]);
% plot(centers(:,1),centers(:,2));
%% show the accum
figure
[x,y,~] = size(accum);
meshgrid(y);

surf(x,y,accum(x,y));