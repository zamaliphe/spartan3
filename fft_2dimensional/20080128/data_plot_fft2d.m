% y=textread('ip_data_readable.list','%d');
% 
% j=1;
% for k=1:2:(length(y)-1)
%     xre(j) = y(k);
%     xim(j) = y(k+1);
%     xabs(j) = sqrt(xre(j)^2 + xim(j)^2);
%     xcomp(j) = xre(j) + i*xim(j);    
%     j = j + 1;
% end
% plot(abs(fft(xcomp)));

% [h1 h2]=textread('doublefft','%d %d');
% 
% for k1=1:64
%     j=1;
%     for k2=1:2:127
%         hmat(k1,j)=h1((k1-1)*128+k2) + i*h1((k1-1)*128+k2+1);
%         j = j + 1;
%     end
% end

% z=[];
% for x=-32:32
%     for y=-32:32
%         %if(x==0)||(y==0))
%         z(x+33,y+33)=sin((pi/100)*(x.^2+y.^2));
%     end
% end
% mesh(z);

[h1 h2]=textread('op_rect2d','%d %d');

for k1=1:64
    j=1;
    for k2=1:2:127
        hmat(k1,j)=h1((k1-1)*128+k2) + i*h1((k1-1)*128+k2+1);
        j = j + 1;
    end
end
shiftedhmat=fftshift(abs(hmat));
surf(shiftedhmat);