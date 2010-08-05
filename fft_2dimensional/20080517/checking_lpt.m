%I = imread('pic1.bmp');
%-----------------------------------
I = imread('fingerprint.bmp');
I = rgb2gray(I);
%-----------------------------------
J = abs(fft2(I));
lpt = log_polar(J);
figure, imshow(I),figure,imshow(J), figure, imshow(lpt);