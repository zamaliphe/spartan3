clc;
clear;


% ori1 = textread('ip_data_readable.list.04.complex','%d');
% [h1 h2]=textread('8output_dumped.04.complex','%d %d');
% [g1 g2]=textread('16output_dumped.04.complex','%d %d');
% theja = 'exp(j*0.4*\pi*k)';
% 
% ori1 = textread('ip_data_readable.list.04.noncomplex','%d');
% [h1 h2]=textread('8output_dumped.04.noncomplex','%d %d');
% [g1 g2]=textread('16output_dumped.04.noncomplex','%d %d');
% theja = 'cos(0.4*\pi*k)'
% 
% ori1 = textread('ip_data_readable.list.0506.complex','%d');
% [h1 h2]=textread('8output_dumped.0506.complex','%d %d');
% [g1 g2]=textread('16output_dumped.0506.complex','%d %d');
% theja = '0.5*exp(j*0.5*\pi*k)+0.5*exp(j*0.6*\pi*k)';
% 
% ori1 = textread('ip_data_readable.list.0506.noncomplex','%d');
% [h1 h2]=textread('8output_dumped.0506.noncomplex','%d %d');
% [g1 g2]=textread('16output_dumped.0506.noncomplex','%d %d');
% theja = '0.5cos(0.5*\pi*k) + 0.5cos(0.6*\pi*k)';
% 
ori1 = textread('ip_data_readable.list.rect','%d');
[h1 h2]=textread('8output_dumped.rect','%d %d');
[g1 g2]=textread('16output_dumped.rect','%d %d');
theja = 'u(27) - u(32) u=unit step, '


for k2=1:64
    orimat(k2) = ori1(k2*2-1) + i*ori1(k2*2);
end
orifft = fft(orimat,64);
orifft1 = fftshift(orifft);
plot(abs(orifft1./(64*256)),'g');
hold on;


for k2=1:64
    hmat(k2) = h1(k2*2-1) + i*h1(k2*2);
end
hmat1 = fftshift(hmat);
plot(abs(hmat1),'r+');


for k2=1:64
    gmat(k2) = g1(k2*2-1)/256 + i*g1(k2*2)/256;
end
gmat1 = fftshift(gmat);
plot(abs(gmat1),'bo');
xlabel('f = 0 to 2\pi (with 1 to 64 sample points)','FontSize',16)
ylabel('Magnitude Spectrum (max. 128)','FontSize',16)
title('\it{Value of the FFT vs Frequency from Zero to Two Pi}','FontSize',16)
h = legend(['MATLAB: FFT of ' theja ' : k=0,1,...'],'08 BIT FFT HARDWARE (Verilog)','16 BIT FFT HARDWARE (Verilog)',1);