function [ pcf pcf2 ] = poc(I1, I2)
%POC Summary of this function goes here
%   Detailed explanation goes here

% Take FFT of each image
F1 = fft2(I1);
F2 = fft2(I2);

plotter_fingerprint_veri;


% Create phase difference matrix
pdm = exp(i*(angle(F1)-angle(F2)));

pdm2 = exp(i*(angle(gmat*32)-angle(gmat*32)));

% Solve for phase correlation function
pcf = real(ifft2(pdm));
pcf2 = real(ifft2(pdm2));