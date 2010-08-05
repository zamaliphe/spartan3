clear all;
close all;

x=[1 2 3 4];
N=length(x);
d = dct(x);

x2=[4 3 2 1 1 2 3 4];
f=fft(x2);

n = 0:2*N-1;

shift=exp(-j*2*pi*(N-0.5)*n/(2*N));

f2 = real(f./shift);

d2 = f2(1:N)/sqrt(2*N);

d2(1)=d2(1)/sqrt(2);

disp(d);
disp(d2);

%I just take my original signal, mirror it and then take the fft.
%Now the thing to note is that the Fourier transform of an even symmetry signal is real
% but we can't make true even symmetry signals on a computer, 
%so we have to compensate for the phase shift caused by the time-shift of 3.5 samples,
%hence the division by the FFT of the variable 'shift'.
%Then I scale the coefficients appropriately (to make them orthonormal), and voila