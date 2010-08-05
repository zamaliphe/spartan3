I1 = imread('p11.jpg');
J1 = rgb2gray(I1);
I2 = imread('p11.jpg');
J2 = rgb2gray(I2);

[ pcf1 ]= poc(J1,J2);
figure,surf(fftshift(pcf1)),title('POC of same images');

I3 = imread('p12.jpg');

[ pcf2 ]= poc(J1,I3);
figure,surf(fftshift(pcf2)),title('POC of dissimilar images');