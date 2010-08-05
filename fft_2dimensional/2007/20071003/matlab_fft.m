clc;
k = 0.4;
n = [0:255];
r = 128*cos(2*pi*n*k);
i = 128*sin(2*pi*n*k);
x = r + j*i;
x2 = abs(fft(x,256));
plot(x2/256);
