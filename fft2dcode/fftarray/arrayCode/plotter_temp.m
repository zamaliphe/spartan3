clc;
clear;

h1=textread('temp','%d');
for k1=1:32
    j=1;
    for k2=1:2:63
        hmat1(k1,j)=h1((k1-1)*64+k2) + i*h1((k1-1)*64+k2+1);
        j = j + 1;
    end
end
for k1=1:32
    j=1;
    for k2=1:2:63
        hmat2(k1,j)=h1(32*64+(k1-1)*64+k2) + i*h1(32*64+(k1-1)*64+k2+1);
        j = j + 1;
    end
end
for k1=1:32
    j=1;
    for k2=1:2:63
        hmat3(k1,j)=h1(64*64 + (k1-1)*64+k2) + i*h1(64*64 + (k1-1)*64+k2+1);
        j = j + 1;
    end
end
for k1=1:32
    j=1;
    for k2=1:2:63
        hmat4(k1,j)=h1(3*64*32+(k1-1)*64+k2) + i*h1(3*64*32+(k1-1)*64+k2+1);
        j = j + 1;
    end
end
hmat = [hmat1,hmat2;hmat3,hmat4];
figure, surf(abs(hmat));