%generating 2d rectangular signal for 128*128 fft operation
close all;
clear;

a = zeros(128,128); % real part of complex input
for index1=1:128
    for index2 =1:128
        if(index1>60 & index1<68)
            if(index2>60 & index2<68)
                a(index1,index2) = 32767 + i*0;
            end
        end
    end
end
 
%figure,surf(a),title('Input');
figure,surf(abs(fft2(a))),title('ideal 128*128 point floating point output');

% breaking down to perform this computation using 4 cores.
% We need to separate elements of each row into odd and even points.
% We also need to do bit-reversing, not shown here, as its not required.

b1 = zeros(64,64); %(top left)
b2 = zeros(64,64); %(top right)
b3 = zeros(64,64); %(bottom left)
b4 = zeros(64,64); %(bottom right)

for index1=1:64
        for index2=1:64
            b1(index1,index2) = a(index1,2*index2-1); %gets the odd points
            b2(index1,index2) = a(index1,2*index2); % gets the even points
            b3(index1,index2) = a(index1+64,2*index2-1); %gets the odd points
            b4(index1,index2) = a(index1+64,2*index2); % gets the even points
        end
end

% stage one of hardware, no need for new mem as inplace substitution takes place there.
b1_new = fft(b1.').'; %stage 1 of fftcore being carried out.
b2_new = fft(b2.').';
b3_new = fft(b3.').';
b4_new = fft(b4.').';


a_new = zeros(128,128);

for index1=1:64
    for k=1:64
        extratwiddle = cos(2*pi*(k-1)/128) - i*sin(2*pi*(k-1)/128);
        a_new(index1,k) = b1_new(index1,k) + extratwiddle*b2_new(index1,k);
        a_new(index1,k+64) = b1_new(index1,k) - extratwiddle*b2_new(index1,k);
        a_new(index1+64,k) = b3_new(index1,k) + extratwiddle*b4_new(index1,k);
        a_new(index1+64,k+64) = b3_new(index1,k) - extratwiddle*b4_new(index1,k);
    end
end

%figure,surf(abs(a_new));
%figure,surf(abs(a_new)-abs(fft(a')')),title('error plot');


%Transpose of the 4 data clusters attached with the 4 cores.


b1_new = a_new(1:64,1:64).';
b2_new = a_new(1:64,65:128).';
b3_new = a_new(65:128,1:64).';
b4_new = a_new(65:128,65:128).';

%SOFTWARE: The transposed custers of core 2 (b2) and core 3 (b3) need to be
%interchanged!!!
b1 = b1_new;
b2 = b3_new;
b3 = b2_new;
b4 = b4_new;

% y = [b1,b2;b3,b4];
% figure,surf(abs(y));


%Repeat of the steps as above with an important preprocessing part.
%Preprocessing
% We need to separate elements of each row into odd and even points.
% We also need to do bit-reversing, not shown here, as its not required.

for index1=1:64
    temp1 = zeros(1,128);
    temp2 = zeros(1,128);
    for index2=1:32
        temp1(index2)       = b1(index1,index2*2-1);
        temp1(index2+32)    = b2(index1,index2*2-1);
        temp1(index2+64)    = b1(index1,index2*2);
        temp1(index2+32+64) = b2(index1,index2*2);
        temp2(index2)       = b3(index1,index2*2-1);
        temp2(index2+32)    = b4(index1,index2*2-1);
        temp2(index2+64)    = b3(index1,index2*2);
        temp2(index2+32+64) = b4(index1,index2*2);
    end
    b1(index1,:) = temp1(1:64);
    b2(index1,:) = temp1(65:128);
    b3(index1,:) = temp2(1:64);
    b4(index1,:) = temp2(65:128);
end

% y = [b1,b2;b3,b4];
% figure,surf(abs(y));


% stage three of hardware, no need for new mem as inplace substitution takes place there.
b1_new = fft(b1.').'; %stage 3 of fftcore being carried out.
b2_new = fft(b2.').';
b3_new = fft(b3.').';
b4_new = fft(b4.').';


a_new = zeros(128,128);

for index1=1:64
    for k=1:64
        extratwiddle = cos(2*pi*(k-1)/128) - i*sin(2*pi*(k-1)/128);
        a_new(index1,k) = b1_new(index1,k) + extratwiddle*b2_new(index1,k);
        a_new(index1,k+64) = b1_new(index1,k) - extratwiddle*b2_new(index1,k);
        a_new(index1+64,k) = b3_new(index1,k) + extratwiddle*b4_new(index1,k);
        a_new(index1+64,k+64) = b3_new(index1,k) - extratwiddle*b4_new(index1,k);
    end
end

figure,surf(abs(a_new)),title('computation using 4 cores ans some SW steps.');
figure,surf(abs(a_new)-abs(fft2(a))),title('error plot');