clc;
% clear;

%I am generating a discrete real signal
%index = [1:1:128];
%x = sin(2*pi*0.4*index);

%I am generating a rect signal
x = zeros(1,128);
for index=1:128
    if(index>60 & index<68)
        x(index) = 32767;
    end
end


%A 128 point 1D FFT
% y = fft(x,128);
% yabs = abs(y);
% figure,plot(yabs),title('Computed using a full point core');


%The same 1D FFT obtained
%using 2 64 point ffts
%**IMPORTANT** Data needs to be segregated as even and odd beforehand
% We are not doing 'bit-reversal' here. But required in hardware.
for j=1:64
    xodd(j) = x(2*j-1);
    xeven(j) = x(2*j);
end

%perform 64 point FFTs
ypartodd = fft(xodd,64);
yparteven = fft(xeven,64);


%Final Step to be performed by microblaze
%extra twiddles (64 complex vals) will be stored in the extra-memory.
for k=1:64
    extratwiddle = cos(2*pi*(k-1)/128) - i*sin(2*pi*(k-1)/128);
    yfull(k) = ypartodd(k) + extratwiddle*yparteven(k);
    yfull(k+64) = ypartodd(k) - extratwiddle*yparteven(k);
end

figure, plot(abs(yfull)),title('Computed using lower point cores');
%figure, plot(abs(yfull)-yabs),title('Error plot')
