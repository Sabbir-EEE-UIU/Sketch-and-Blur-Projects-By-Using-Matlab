clc; clear all;

a = imread('Sabbir.jpg');
binary_img = im2bw(a);
subplot(221); imshow(a); title('Sabbir.jpg');
subplot(222); imshow(binary_img); title('Sketch Image');
