N = 64;
a = zeros(N*N*2,1);
for i=1:N
    for j=1:N
        a(((i-1)*N+j)*2-1) = J(i,j);
        a(((i-1)*N+j)*2) = 0;
    end
end
a = a*128;
dlmwrite('ip_data_dec2bin.list',a,'delimiter','\n');
