clc;
clear;
figure;






h1=textread('ip_data_readable.list.rect','%d');
for k1=1:64
    j=1;
    for k2=1:2:127
        hmat(k1,j)=h1((k1-1)*128+k2) + i*h1((k1-1)*128+k2+1);
        j = j + 1;
    end
    %hmatintfft(:,k1) = fft(hmat(k1,:));
    hmatintfft(k1,:) = hmat(k1,:);
end




%function which does bit-reversing

for k1=1:64
    for k2=1:64
        a(k1,k2*2-1) = real(hmatintfft(k1,k2));
        a(k1,k2*2) = imag(hmatintfft(k1,k2));
    end
end

tempbr = 0;
tempm = 64;
k1=1;
for k1=1:64
        j=1;
        for k2=1:2:127
            if(j>k2)
%                 display([num2str(k2/2) 'being replaced by' num2str(j/2)]);
                tempbr = a(k1,j);
                a(k1,j) =  a(k1,k2);
                a(k1,k2) = tempbr;
                tempbr = a(k1,j+1);
                a(k1,j+1) = a(k1,k2+1);
                a(k1,k2+1) = tempbr;
            end
            tempm = 64;
            while (tempm>=2 && j>tempm)
                j=j-tempm;
                tempm=tempm/2;
            end
            j=j+tempm;
        end
end

for k1=1:64
    for k2=1:64
        ac(k1,k2) = a(k1,2*k2-1)+i*a(k1,2*k2);        
    end
end
ac = ac./64;
surf(abs(ac));

%bitreversing is over




% subplot(2,1,1);surf(abs(hmatintfft./64));
% hmatfft=abs(fft2(hmat));
% subplot(2,1,1);surf(hmatfft./64);
% subplot(2,1,2);surf(fftshift(hmatfft)./64);

% h1=textread('ip_data_readable.list.rect','%d');
% for k1=1:64
%     j=1;
%     for k2=1:2:127
%         hmat(k1,j)=h1((k1-1)*128+k2) + i*h1((k1-1)*128+k2+1);
%         j = j + 1;
%     end
%     hmatintfft(:,k1) = fft(hmat(k1,:));
% end
% subplot(2,1,1);surf(abs(hmatintfft./64));
% % hmatfft=abs(fft2(hmat));
% % subplot(2,1,1);surf(hmatfft./64);
% % subplot(2,1,2);surf(fftshift(hmatfft)./64);

% [g1 g2]=textread('op2d_rects2','%d %d');
% for k1=1:64
%     j=1;
%     for k2=1:2:127
%         gmat(k1,j)=g1((k1-1)*128+k2) + i*g1((k1-1)*128+k2+1);
%         j = j + 1;
%     end
% end
% gmatabs=abs(gmat);
% % subplot(2,1,2);
% figure;
% surf(gmatabs);

% temp1 = fft(gmatabs(1,:));
% temp64 = fft(gmatabs(64,:));
% % plot(abs(temp1./64));
% dlmwrite('temp1_ouput.txt',temp1./64,'delimiter','\n','precision','%.0f');
% dlmwrite('temp64_ouput.txt',temp64./64,'delimiter','\n','precision','%.0f');

% [g1 g2]=textread('op2d_rect','%d %d');
% for k1=1:64
%     j=1;
%     for k2=1:2:127
%         gmat(k1,j)=g1((k1-1)*128+k2) + i*g1((k1-1)*128+k2+1);
%         j = j + 1;
%     end
% end
% gmatabs=abs(gmat);
% % subplot(2,1,2);
% surf(gmatabs);