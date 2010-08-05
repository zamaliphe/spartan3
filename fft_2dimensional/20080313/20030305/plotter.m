% This script reads the rectangular 2d step input signal.
% Plots the input.
% Plots the matlab 2dfft w/o fftshift
% plots the 16-bit hardware output w/o fftshift
% plots the error between them

clc;
clear;

h1=textread('ip_data_readable.list.rect','%d');
for k1=1:64
    j=1;
    for k2=1:2:127
        hmat(k1,j)=h1((k1-1)*128+k2) + i*h1((k1-1)*128+k2+1);
        j = j + 1;
    end
end
figure;
% subplot(2,1,1);
surf(hmat);


hmatfft=fft2(hmat);
hmatfftabs=abs(hmatfft./(64*64));
figure;
% subplot(2,1,1);
surf(hmatfftabs);

[g1 g2]=textread('op2d_rect','%d %d');
for k1=1:64
    j=1;
    for k2=1:2:127
        gmat(k1,j)=g1((k1-1)*128+k2) + i*g1((k1-1)*128+k2+1);
        j = j + 1;
    end
end
gmatabs=abs(gmat);
% subplot(2,1,2);
figure;
surf(gmatabs);


% Showing the error plot
errorsurf=abs(hmatfftabs-gmatabs);
figure;
surf(errorsurf);