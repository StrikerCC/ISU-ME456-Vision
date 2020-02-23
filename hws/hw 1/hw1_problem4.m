%% Problem 4: Filter noisey Lena image using a combination of any filters
clc
clear all
close all

addpath('fig\');    % add figure floder into path
img = imread('LenaNoise.png');   % load the image into matrix
imshow(img);

[rows, cols] = size(img);   % get the size of image
windowSize_median = [3 5 7]; % input the median filter size
windowSize_gauss = [3 5 7]; % input the gauss filter size

img_filtered = zeros(rows, cols);   % initlize the filtered image
img_filtered_mix = [];  % store three filtered images in a single matrix

%% use median filter to get rid of speckles
for runMedian = 1:length(windowSize_median)
    ctr = (windowSize_median(runMedian) + 1)/2;  % pixel coordiantes of window center
    for i = ctr:rows-ctr+1
        for j = ctr:cols-ctr+1
            imgWindow = double(img(i-(ctr-1):i+ctr-1,j-(ctr-1):j+ctr-1));
            img_filtered(i,j) = median(imgWindow(:));
        end
    end
    img_filtered_mix = [img_filtered_mix;img_filtered]; % put three matrix in colume  
end
%% plot three filtered images
baselineX = 1:rows; % baseline length
figure
for run = 1:length(windowSize_median)
    if run == 1
        rangeStart = 1;
    else
        rangeStart = cols*(run-1);
    end
    rangeEnd = rangeStart + cols;
%{
    subplot(1,length(windowSize_median),run) %*2-1)    % plot filtered images
    imshow(uint8(img_filtered_mix(rangeStart:rangeEnd,:)));
    title(['Median ', num2str(windowSize_median(run)),' by ',num2str(windowSize_median(run))]);
%}

    subplot(length(windowSize_median),1,run)    % plot intensity changes
    plot(baselineX,img(cols/2,:),'b:',baselineX,img_filtered_mix(rangeStart+cols/2,:),'r-');
    legend('Before','After');
    xlabel('x (pixel)');
    ylabel('Intensity');
    title(['Intensity across circles using ',num2str(windowSize_median(run)),'by',num2str(windowSize_median(run)),' median filter']);
end
%% use enhancement filter
by5RangeStart = cols;
by5RangeEnd = cols*2;
A0 = img_filtered_mix(by5RangeStart:by5RangeEnd,:);   % use the 5by5 median filter result image
filterSize = [3 5 7];
img_enhanced_mix = [];
for runEnhance = 1:length(filterSize)
    Sigma = filterSize(runEnhance)/3;
    B0 = imgaussfilt(A0,Sigma);
    alpha = 0.3;
    C = A0 * (1+alpha)-alpha * B0;
    img_enhanced_mix = [img_enhanced_mix;C]; % put three matrix in colume
end
%% show the images and intensity plot by enhancement filter
figure
for run = 1:length(filterSize)
    if run == 1
        rangeStart = 1;
    else
        rangeStart = cols*(run-1);
    end
    rangeEnd = rangeStart + cols;
%{
    subplot(1,length(filterSize),run) %*2-1)    % plot filtered images
    imshow(uint8(img_enhanced_mix(rangeStart:rangeEnd,:)));
    title(['Gauss ', num2str(filterSize(run)),' by ',num2str(filterSize(run))]);
%}
    subplot(length(windowSize_median),1,run)    % plot intensity changes
    plot(baselineX,img(cols/2,:),'b:',baselineX,img_enhanced_mix(rangeStart+cols/2,:),'r-');
    legend('Before','After');
    xlabel('x (pixel)');
    ylabel('Intensity');
    title(['Intensity across circles using ',num2str(windowSize_median(run)),'by',num2str(windowSize_median(run)),' gauss filter and enhance']);
%}
end
