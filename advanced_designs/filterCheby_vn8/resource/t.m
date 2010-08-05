function out = T(n,x)

if(n<0)
    out = 0;
elseif(n == 0)
    out = 1;
elseif(n == 1)
    out = x;
else
    out = 2*x*T(n-1,x)-T(n-2,x);
end