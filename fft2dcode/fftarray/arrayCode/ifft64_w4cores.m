%generating 2d rectangular signal for 128*128 fft operation
%close all;
clear;
M = 32;
N = 2*M;
breal = textread('ifft_data.list.real','%d');
bimag = textread('ifft_data.list.real','%d');
a = zeros(N,N); % real part of complex input
for index1=1:N
    for index2 =1:N
             a(index1,index2) = breal((index1-1)*N+index2) + i*bimag((index1-1)*N+index2);
    end
end
 
figure,surf(abs(a)),title('Input');
% figure,surf(abs(fft2(a))),title(['ideal ' int2str(N) '*' int2str(N) 'point floating point output']);

% breaking down to perform this computation using 4 cores.
% We need to separate elements of each row into odd and even points.
% We also need to do bit-reversing, not shown here, as its not required.

b1 = zeros(M,M); %(top left)
b2 = zeros(M,M); %(top right)
b3 = zeros(M,M); %(bottom left)
b4 = zeros(M,M); %(bottom right)

for index1=1:M
        for index2=1:M
            b1(index1,index2) = a(index1,2*index2-1); %gets the odd points
            b2(index1,index2) = a(index1,2*index2); % gets the even points
            b3(index1,index2) = a(index1+M,2*index2-1); %gets the odd points
            b4(index1,index2) = a(index1+M,2*index2); % gets the even points
        end
end

% stage one of hardware, no need for new mem as inplace substitution takes place there.
b1_new = fft(b1.').'; %stage 1 of fftcore being carried out.
b2_new = fft(b2.').';
b3_new = fft(b3.').';
b4_new = fft(b4.').';


% tempMat = [b1_new,b2_new;b3_new,b4_new];
% figure,surf(abs(tempMat));

a_new = zeros(N,N);

for index1=1:M
    for k=1:M
        extratwiddle = cos(2*pi*(k-1)/N) + i*sin(2*pi*(k-1)/N);
        a_new(index1,k) = b1_new(index1,k) + extratwiddle*b2_new(index1,k);
        a_new(index1,k+M) = b1_new(index1,k) - extratwiddle*b2_new(index1,k);
        a_new(index1+M,k) = b3_new(index1,k) + extratwiddle*b4_new(index1,k);
        a_new(index1+M,k+M) = b3_new(index1,k) - extratwiddle*b4_new(index1,k);
    end
end

figure,surf(abs(a_new));
figure,surf(abs(a_new)-abs(fft(a')')),title('error plot');

% 
% %Transpose of the 4 data clusters attached with the 4 cores.


b1_new = a_new(1:M,1:M).';
b2_new = a_new(1:M,M+1:N).';
b3_new = a_new(M+1:N,1:M).';
b4_new = a_new(M+1:N,M+1:N).';

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

for index1=1:M
    temp1 = zeros(1,N);
    temp2 = zeros(1,N);
    for index2=1:M/2
        temp1(index2)       = b1(index1,index2*2-1);
        temp1(index2+M/2)    = b2(index1,index2*2-1);
        temp1(index2+M)    = b1(index1,index2*2);
        temp1(index2+M/2+M) = b2(index1,index2*2);
        temp2(index2)       = b3(index1,index2*2-1);
        temp2(index2+M/2)    = b4(index1,index2*2-1);
        temp2(index2+M)    = b3(index1,index2*2);
        temp2(index2+M/2+M) = b4(index1,index2*2);
    end
    b1(index1,:) = temp1(1:M);
    b2(index1,:) = temp1(M+1:N);
    b3(index1,:) = temp2(1:M);
    b4(index1,:) = temp2(M+1:N);
end

% y = [b1,b2;b3,b4];
% figure,surf(abs(y));


% stage three of hardware, no need for new mem as inplace substitution takes place there.
b1_new = fft(b1.').'; %stage 3 of fftcore being carried out.
b2_new = fft(b2.').';
b3_new = fft(b3.').';
b4_new = fft(b4.').';


a_new = zeros(N,N);

for index1=1:M
    for k=1:M
        extratwiddle = cos(2*pi*(k-1)/N) + i*sin(2*pi*(k-1)/N);
        a_new(index1,k) = b1_new(index1,k) + extratwiddle*b2_new(index1,k);
        a_new(index1,k+M) = b1_new(index1,k) - extratwiddle*b2_new(index1,k);
        a_new(index1+M,k) = b3_new(index1,k) + extratwiddle*b4_new(index1,k);
        a_new(index1+M,k+M) = b3_new(index1,k) - extratwiddle*b4_new(index1,k);
    end
end

figure,surf(abs(a_new)),title('computation using 4 cores and some SW steps.');
figure,surf(abs(a_new)-abs(fft2(a))),title('error plot');