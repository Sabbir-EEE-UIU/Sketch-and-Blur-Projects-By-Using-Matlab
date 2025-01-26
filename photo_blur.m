clc; clear all;
image = imread('Sabbir.jpg');
imshow(image);
h = imfreehand(); 
mask = createMask(h);
save('subjectMask.mat', 'mask');
imshow(mask);


image = imread('Sabbir.jpg');
load('subjectMask.mat', 'mask');
imageDouble = im2double(image);
H = fspecial('gaussian', [30 30], 50);
blurredImage = imfilter(imageDouble, H, 'replicate');
blurredBackground = blurredImage;
for i = 1:3 
    blurredBackground(:,:,i) = blurredImage(:,:,i) .* ~mask + imageDouble(:,:,i) .* mask;
end
imshow(blurredBackground);
