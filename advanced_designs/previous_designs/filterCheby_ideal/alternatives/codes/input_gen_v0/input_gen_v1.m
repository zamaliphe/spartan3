clear all;
close all;
clc;

%n0 = textread('ip_data_readable.list','%d'); // was initially used for
%verification
N = 4096;
L = 16;
k = 0.8;
x= [0:N-1];
n0 = floor(1*cos(k*pi*x)*2^(L-1));
for i=1:length(n0)
    if(n0(i)==2^(L-1))
        n0(i) = n0(i)-1; %slight distortion being induced
    end
end


%getting the 2's complement representation of these
n0_set_for_bin = zeros(length(n0),1);
for i=1:length(n0)
    if(n0(i)<0)
        n0_set_for_bin(i) = 2^L + n0(i);
    else
        n0_set_for_bin(i) = n0(i);
    end
end
output = dec2bin(n0_set_for_bin,L);
dlmwrite('ip_data.list.matlab',output,'delimiter','');
dlmwrite('ip_data_readable.list',n0,'delimiter','\n');