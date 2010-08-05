clear all;
close all;
clc;

n0=textread('citi_ip_data.list.matlab.decimal','%d');

%getting the 2's complement representation of the input to be fed.
n0_set_for_hex = zeros(length(n0),1);
for i=1:length(n0)
    if(n0(i)<0)
        n0_set_for_hex(i) = 2^16 + n0(i);
    else
        n0_set_for_hex(i) = n0(i);
    end
end
output = dec2hex(n0_set_for_hex,4);
dlmwrite('citi_ip_data.list.matlab',output,'delimiter','');