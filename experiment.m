clc; clear all;

% Read the image
image = imread('uiu.jpg');
imshow(image);

% Convert to grayscale for simpler processing
grayImage = rgb2gray(image);

% Use thresholding to create a binary mask (adjust the threshold value as needed)
threshold = 0.5; % Example threshold value (normalized, 0 to 1)
binaryMask = imbinarize(im2double(grayImage), threshold);

% Post-process the mask to refine it (remove noise, fill holes)
binaryMask = imfill(binaryMask, 'holes');
binaryMask = bwareaopen(binaryMask, 50); % Remove small objects

% Save the mask
save('subjectMask.mat', 'binaryMask');

% Display the mask
imshow(binaryMask);

% Create a blurred background with the mask
imageDouble = im2double(image);
H = fspecial('gaussian', [30 30], 50);
blurredImage = imfilter(imageDouble, H, 'replicate');
blurredBackground = blurredImage;

% Apply the mask to preserve the subject and blur the background
for i = 1:3 
    blurredBackground(:,:,i) = blurredImage(:,:,i) .* ~binaryMask + imageDouble(:,:,i) .* binaryMask;
end

% Display the final image
imshow(blurredBackground);
