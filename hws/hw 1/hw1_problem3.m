%% Problem 3: demonstrate the edge shift of a 3x3, 11x11 and 31x31 median filter
clear all
close all
clc

addpath('fig\');    % add figure floder into path
img = imread('SquareCircle.png');   % load the image into matrix
[rows, cols] = size(img);   % get the size of image
windowSize_median = [3,11,31]; % input the filter size
img_filtered = zeros(rows, cols);   % initlize the filtered image
img_filtered_mix = [];  % store three filtered images in a single matrix
%% 
for run = 1:length(windowSize_median)
    ctr = (windowSize_median(run) + 1)/2;  % pixel coordiantes of window center
    for i = ctr:rows-ctr+1
        for j = ctr:cols-ctr+1
            imgWindow = double(img(i-(ctr-1):i+ctr-1,j-(ctr-1):j+ctr-1));
            img_filtered(i,j) = median(imgWindow(:));
        end
    end
    img_filtered_mix = [img_filtered_mix;img_filtered]; % put three matrix in colume  
end
% plot three filtered images
figure
for run = 1:length(windowSize_median)
    subplot(length(windowSize_median),1,run)
    if run == 1
        rangeStart = 1;
    else
        rangeStart = cols*(run-1);
    end
    imshow(uint8(img_filtered_mix(rangeStart:cols*run,:)));
    title(['Median filter with window size of ', num2str(windowSize_median(run)),' by ',num2str(windowSize_median(run))]);
end
% plot the intensity along baseline cross the circles 
img_filtered_mean_3by3 = img_filtered_mix(1:cols,:);    % decompose the mix image matrix
img_filtered_mean_11by11 = img_filtered_mix(cols:2*cols,:);
img_filtered_mean_31by31 = img_filtered_mix(2*cols:3*cols,:);
baselineX = 1:rows;

figure
subplot(length(windowSize_median),1,1)  % plot intensity with respect to x 
plot(baselineX,img(cols/4,:),'b:',baselineX,img_filtered_mean_3by3(cols/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across circles using 3by3 median filter');

subplot(length(windowSize_median),1,2)  % plot intensity with respect to x 
plot(baselineX,img(cols/4,:),'b:',baselineX,img_filtered_mean_11by11(cols/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across circles using 11by11 median filter');

subplot(length(windowSize_median),1,3);
plot(baselineX,img(cols/4,:),'b:',baselineX,img_filtered_mean_31by31(cols/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across circles using 31by31 median filter');

% plot the intensity along baseline cross the squares 
figure
subplot(length(windowSize_median),1,1)  % plot intensity with respect to x 
plot(baselineX,img(cols*3/4,:),'b:',baselineX,img_filtered_mean_3by3(cols*3/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across squares using 3by3 median filter');

subplot(length(windowSize_median),1,2)  % plot intensity with respect to x 
plot(baselineX,img(cols*3/4,:),'b:',baselineX,img_filtered_mean_11by11(cols*3/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across squares using 11by11 median filter');

subplot(length(windowSize_median),1,3);
plot(baselineX,img(cols*3/4,:),'b:',baselineX,img_filtered_mean_31by31(cols*3/4,:),'r-');
legend('Before','After');
xlabel('x (pixel)');
ylabel('Intensity');
title('Intensity across squares using 31by31 median filter');
hold on
