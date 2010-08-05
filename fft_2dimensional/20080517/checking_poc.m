I = imread('fingerprint.bmp');
J = rgb2gray(I);
%figure, imshow(I), figure, imshow(J);
[ pcf pcf2 ]= poc(J,J);
figure,surf(fftshift(pcf));
figure,surf(fftshift(pcf2));

%figure,surf(abs(fft2(J))./32);