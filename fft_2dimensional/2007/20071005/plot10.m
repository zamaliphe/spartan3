
clc;
XMIN = 0;
XMAX = 256 ;
YMIN = 0;
YMAX = 128;
k = 1;
n = [0:255];
r = 128*cos(pi*n*k);    % Tallies with the c code input_generator.c.
i = 128*sin(pi*n*k);
x1 = r + j*i;
X1 = abs(fft(x1,256));
subplot(3,1,1)
plot(X1/256,'g'),axis([XMIN XMAX YMIN YMAX]),title('FFT Using MATLAB'),xlabel('frequency'),ylabel('magnitude (max = 128)'),  text(200,60,'x(n) = exp(pi*n*1.0)');

x2r = numeric10(:,2);
x2i = numeric10(:,3);
X2 = sqrt(x2r.^2 + x2i.^2);
subplot(3,1,2)
plot(X2,'c'),axis([XMIN XMAX YMIN YMAX]),title('FFT Using C'), xlabel('frequency'),ylabel('magnitude (max = 128)');

a = k10(:,1);
for n=1:256
    x3r(n) = a(2*n-1,1);
    x3i(n) = a(2*n,1);
    X3(n) = sqrt(x3r(n)^2 + x3i(n)^2);
end
subplot(3,1,3)
plot(X3,'r'),axis([XMIN XMAX YMIN YMAX]),title('FFT Using the FFT Verilog Module'), xlabel('frequency'),ylabel('magnitude (max = 128)');