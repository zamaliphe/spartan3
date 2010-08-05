clear all;
clc;

rect=zeros(51);
rect(25:35,25:35)=ones(11);
%surf(rect);

rect_fft=fft2(rect);
%figure;
surf(fftshift(abs(rect_fft)));
% rectshifted=fftshift(rect);
% surf(rectshifted);
% rectfft=fftshift(rectshifted);
% surf(rectfft);