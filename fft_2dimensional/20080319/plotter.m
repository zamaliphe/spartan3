N = 64;
for i=1:N
    re1(i) = test_op1(2*i-1,1);
    im1(i) = test_op1(2*i,1);
    y1(i) = sqrt(re1(i)^2 + im1(i)^2);
    re2(i) = test_op2(2*i-1,1);
    im2(i) = test_op2(2*i,1);
    y2(i) = sqrt(re2(i)^2 + im2(i)^2);
end
subplot(2,1,1)
plot(y1);
subplot(2,1,2)
plot(y2);
