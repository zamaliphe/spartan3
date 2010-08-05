a = ip_data_readable(:,1);
for n=1:256
    r(n) = a(2*n-1,1);
    i(n) = a(2*n,1);
    x2(n) = r(n) + j*i(n);
    %if (r(n) >= 128)
    %    r(n) = (256 - r(n) + 1 )*-1;
    %end
    %if (i(n) >= 128)
    %    i(n) = (256 - i(n) + 1 )*-1;
    %end
    %abs(n) = sqrt(r(n)^2 + i(n)^2);
end

plot(r(1:40));
figure;
plot(i(1:40));