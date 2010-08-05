close all

%read pgm type image
read_image = imread('lena_0','pgm');

%select image portion
%original image
linear_size = 65;
select_positionx = 233;
select_positiony = 235;
f_image = read_image(select_positiony:(select_positiony+linear_size-1),select_positionx:(select_positionx+linear_size-1));

%yy shifted image
select_positionx = 233;
select_positiony = 100;  %uncorrelated image  
%select_positiony = 235;  %same image    
%select_positiony = 245; %shifted
g_image = read_image(select_positiony:(select_positiony+linear_size-1),select_positionx:(select_positionx+linear_size-1));

%plot images
%imshow(f_image);
%imshow(g_image);
%print images to file
%imwrite(f_image,'lena_fout.pgm');
%imwrite(g_image,'lena_gout.pgm');

%computing 2D FFT
%initialization
M = (65-1)/2;
F_fft = zeros(linear_size,linear_size);
G_fft = zeros(linear_size,linear_size);

%FFT calculus for the two images
for k1=-M:1:M
    for k2=-M:1:M
        for n1=-M:1:M
            for n2=-M:1:M
                F_fft(k1+M+1,k2+M+1)=F_fft(k1+M+1,k2+M+1)+(double(f_image(n1+M+1,n2+M+1))*exp(-j*2*pi*k1*n1/linear_size)*exp(-j*2*pi*k2*n2/linear_size));
                G_fft(k1+M+1,k2+M+1)=G_fft(k1+M+1,k2+M+1)+(double(g_image(n1+M+1,n2+M+1))*exp(-j*2*pi*k1*n1/linear_size)*exp(-j*2*pi*k2*n2/linear_size));
            end
        end
    end
end
%end of computing 2D FFT

%computing normalized cross spectrum
%initialization
Rfg = zeros(linear_size,linear_size);
for k1=-M:1:M
    for k2=-M:1:M
        Rfg(k1+M+1,k2+M+1)=F_fft(k1+M+1,k2+M+1)*conj(G_fft(k1+M+1,k2+M+1))/abs(F_fft(k1+M+1,k2+M+1)*conj(G_fft(k1+M+1,k2+M+1)));
    end
end
%end of computing normalized cross spectrum
         

%computing iFFT (POC)
%initialization
POC = zeros(linear_size,linear_size);

for n1=-M:1:M
    for n2=-M:1:M
        for k1=-M:1:M
            for k2=-M:1:M
                POC(n1+M+1,n2+M+1)=POC(n1+M+1,n2+M+1)+(Rfg(k1+M+1,k2+M+1)*exp(j*2*pi*k1*n1/linear_size)*exp(j*2*pi*k2*n2/linear_size));
            end
        end
        POC(n1+M+1,n2+M+1)=abs(POC(n1+M+1,n2+M+1))/(linear_size^2);
    end
end
%end of computing iFFT (POC)

figure
surf(-M:M,-M:M,POC);
        
