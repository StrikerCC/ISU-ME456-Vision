%% Problem 2: mean, median and gaussian filter with sizes 3x3, 11x11 and 31x31
clc
clear all
close all

addpath('fig\');    % add figure floder into path
img = imread('Part.png');   % load the image into matrix
[rows, cols] = size(img);
img_filtered = zeros(rows, cols);
windowSize_median = [3,11,31];

%% Mean filter
for run = 1:length(windowSize_median)
    h = ones(windowSize_median(run),windowSize_median(run))/windowSize_median(run)/windowSize_median(run); % filter value
    ctr = (windowSize_median(run) + 1)/2;  % pixel coordiantes of window center
    for i = ctr:rows-ctr+1  % move to the next baseline each pixel per step
        for j = ctr:cols-ctr+1  % move the filter window along baseline each pixel per setp
            imgWindow = double(img(i-(ctr-1):i+ctr-1,j-(ctr-1):j+ctr-1));
            img_filtered(i,j) = sum(sum(imgWindow.*h));
        end
    end
    figure,imshow(uint8(img_filtered)); 
    title(['Mean filter with window size of ', num2str(windowSize_median(run)),' by ',num2str(windowSize_median(run))]);
end

%% Median filter 
for run = 1:length(windowSize_median)
    ctr = (windowSize_median(run) + 1)/2;  % pixel coordiantes of window center
    for i = ctr:rows-ctr+1
        for j = ctr:cols-ctr+1
            imgWindow = double(img(i-(ctr-1):i+ctr-1,j-(ctr-1):j+ctr-1));
            img_filtered(i,j) = median(imgWindow(:));
        end
    end
    figure,imshow(uint8(img_filtered));
    title(['Median filter with window size of ', num2str(windowSize_median(run)),' by ',num2str(windowSize_median(run))]);
end
%% gaussian filter
for run = 1:length(windowSize_median)
    sigma = windowSize_median(run);
    img_filtered_gauss = imgaussfilt(img,sigma);
    figure,imshow(uint8(img_filtered_gauss));
    title(['Gauss filter with window size of ', num2str(windowSize_median(run)),' by ',num2str(windowSize_median(run))]);
end
