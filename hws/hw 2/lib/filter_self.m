function img_filtered = filter_self(img,filterMatrix)
%filter: use filter window to filter the image matrix
[rows_img, cols_img,~] = size(img);   % image size 
img_filtered = double( ones(rows_img, cols_img) ); %img; %ones(rows_img, cols_img);   % initialize the image 
[size_filter, ~] = size(filterMatrix);    % filter size 
ctr = (size_filter + 1)/2;  % pixel coordiantes of window center
for i = ctr:rows_img-ctr+1  % move to the next baseline each pixel per step
    for j = ctr:cols_img-ctr+1  % move the filter window along baseline each pixel per setp
        img_Window = double(img(i-(ctr-1):i+ctr-1,j-(ctr-1):j+ctr-1));
        img_filtered(i,j) = sum(sum(img_Window.*filterMatrix));
    end
end
end

