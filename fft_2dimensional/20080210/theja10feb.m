clc;
clear;
[h1 h2]=textread('op_8bit_04','%d %d');
for k2=1:64
    hmat(k2) = h1(k2*2-1) + i*h1(k2*2);
end
plot(abs(hmat),'g');
hold on;
[g1 g2]=textread('op_16b_04_uneq','%d %d');
for k2=1:64
    gmat(k2) = g1(k2*2-1)/256 + i*g1(k2*2)/256;
end
plot(abs(gmat),'b');