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

% figure;
% hold on;
% plot(xnewlocations,yapproximate,'r'); % plot chebyshev expansion values
% plot(xnewlocations,yexact,'b'); % plot exact function values
% hold off;


Cinteg = floor(C*(2^15));%should be actually: 1 maps to 2^15-1 and -1 maps to -2^15




TevaluatedScaled = floor(Tevaluated*(2^15-1));
[length1 length2] = size(TevaluatedScaled);

%getting the 2's complement representation of TevaluatedScaled
Tmat_set_for_hex = zeros(length1,length2);
for i=1:length1
    for j=1:length2
        if(TevaluatedScaled(i,j)<0)
            Tmat_set_for_hex(i,j) = 2^16 + TevaluatedScaled(i,j);
        else
            Tmat_set_for_hex(i,j) = TevaluatedScaled(i,j);
        end
    end
    output = dec2hex(Tmat_set_for_hex(i,:),4);
end