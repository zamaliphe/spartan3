%The function T is required to be in the same directory!!!

close all;
clear all;
clc;

%number of new locations where we need the interpolated values
%nsampl = 100;
nsampl = 8;

%get the vector
fct='(sin(4*x) + 0.5*sin(8*x))/1.5';  %function to be approximated
a = -1;
b = 1;
deg = 7; % Number of points N = deg+1
xnodes=(a+b)/2+((b-a)/2)*(-cos(pi/(deg+1)*((0:deg)'+.5)));
x=xnodes; ydata=eval(fct);
ydata_originale = ydata;


for j=0:deg % deg+1 values
    for k=0:deg % deg+1 values
        if(j==0)
            coeff = (1/(deg+1));
        else
            coeff = ((-1)^j)*(2/(deg + 1));
        end
        C(j+1,k+1) = coeff*cos(j*pi*(2*k+1)/(2*(deg+1)));
    end
end


xnewlocations = a+(b-a)/2/(nsampl) +(0:nsampl-1)*((b-a)/(nsampl));
x=xnewlocations; yexact=eval(fct);

% Instead of getting the T matrix which is fixed for a specific length
% and the powers of xnewlocations(i) we will evaluate the [T(n,x)]n=0,...,N for each
% xnewlocation(i)

temp = ydata'*C';

for i=1:length(xnewlocations)
    for j=0:deg
        Tevaluated(i,j+1) = T(j,xnewlocations(i));
    end
    yapproximate(i) = temp*Tevaluated(i,:)';
end

ci = floor(temp*(2^15)*(2^15)/(2^16));
ci_set_for_2scomp = zeros(nsampl,1);
%getting the 2's complement representation of ci
for i=1:nsampl
        if(ci(i)<0)
            ci_set_for_2scomp(i) = 2^16 + ci(i);
        else
            ci_set_for_2scomp(i) = ci(i);
        end
    end
output = dec2hex(ci_set_for_2scomp,4);
