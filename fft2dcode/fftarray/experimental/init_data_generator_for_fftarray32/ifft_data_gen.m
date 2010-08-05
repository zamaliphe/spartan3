%generating 2d rectangular signal for 128*128 fft operation
close all;
clear;

a = zeros(32,32); % real part of complex input

t = [1:1:32];
inp = cos(pi*0.3*t);
%figure, plot(inp);
%figure,plot(abs(fft(inp)));
outp = inp;
outp = floor(outp.*(32767/max(max(abs(outp)))));

for index1=1:32
                a(index1,:) = outp;
end

a_real = real(a);
a_imag = imag(a);

dlmwrite('ifft_data.list.real',a_real,'delimiter','\n');
dlmwrite('ifft_data.list.imag',a_imag,'delimiter','\n');
