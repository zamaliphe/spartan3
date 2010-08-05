[g1 g2]=textread('op_fingerprint','%d %d');
for k1=1:64
    j=1;
    for k2=1:2:127
        gmat(k1,j)=g1((k1-1)*128+k2) + i*g1((k1-1)*128+k2+1);
        j = j + 1;
    end
end
gmatabs=abs(gmat);
figure,surf(gmatabs);