clc;
clear;
close all;

[n1 m2]=textread('results_array.list','%d %d');
for k1=1:32
    for k2=1:2:63
        nmat(k1,(k2+1)/2)=n1((k1-1)*64+k2) + i*n1((k1-1)*64+k2+1);
    end
end
nmatabs=abs(nmat);
figure;
surf(nmatabs);


a = zeros(32,32); % real part of complex input

t = [1:1:32];
inp = cos(pi*(3/16)*t);ls

%figure, plot(inp);
%figure,plot(abs(fft(inp)));
outp = fft(inp);
outp = floor(outp.*(32767/max(max(abs(outp)))));

for index1=1:32
                a(index1,:) = outp;
end
figure, surf(abs(a));
% a_real = real(a);
% a_imag = imag(a);
% figure,surf(abs(ifft(a')'));
% 
% dlmwrite('ifft_data.list.real',a_real,'delimiter','\n');
% dlmwrite('ifft_data.list.imag',a_imag,'delimiter','\n');

