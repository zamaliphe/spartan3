I1 = imread('p11.jpg');
J1 = rgb2gray(I1);
I2 = imread('p11.jpg');
J2 = rgb2gray(I2);

[ pcf ]= poc(J1,J2);
figure,surf(fftshift(pcf));