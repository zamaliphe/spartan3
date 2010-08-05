clear all;
close all;
clc;

%n0 = textread('ip_data_readable.list','%d'); // was initially used for
%verification

k = 0.25;
x= [0:4095];
n0 = floor(1*cos(k*pi*x)*32768);
for i=1:length(n0)
    if(n0(i)==32768)
        n0(i) = n0(i)-1; %slight distortion being induced
    end
end


%getting the 2's complement representation of these
n0_set_for_bin = zeros(length(n0),1);
for i=1:length(n0)
    if(n0(i)<0)
        n0_set_for_bin(i) = 65536 + n0(i);
    else
        n0_set_for_bin(i) = n0(i);
    end
end
output = dec2bin(n0_set_for_bin,16);
dlmwrite('ip_data.list.matlab',output,'delimiter','');