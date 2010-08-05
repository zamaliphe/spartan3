%generating 2d rectangular signal for 128*128 fft operation
close all;
clear;

a = zeros(64,64); % real part of complex input
for index1=1:64
    for index2 =1:64
        if(index1>28 & index1<36)
            if(index2>28 & index2<36)
                a(index1,index2) = 32767 + i*0;
            end
        end
    end
end
a_new = fft2(a);
 
a_new = a_new./max(max(abs(a_new)));
a_new = floor(a_new*32767);
%figure,surf(a),title('Input');
a_real = real(a_new);
a_imag = imag(a_new);

 figure,surf(abs(a_new));
% dlmwrite('ifft_data.list.real',a_real,'delimiter','\n');
% dlmwrite('ifft_data.list.imag',a_imag,'delimiter','\n');

figure,surf(abs(ifft2(a_new)));