clc;
clear;
%read the image
y=imread('lena2.bmp','bmp');
%imshow(y);
z = log_polar(y);
imshow(z);
w = imlogpolar(y,size(y,1),size(y,2),'nearest'); % Uses a lot of complexity and matlab interpolation functions
figure;
imshow(y);
figure;
imshow(w);