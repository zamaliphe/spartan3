clc;
k = 0.4;
n = [0:255];
r = 128*cos(pi*n*k);
i = 128*sin(pi*n*k);
x = r + j*i;
x2 = abs(fft(x,256));
subplot(2,1,1)
plot(x2/256);