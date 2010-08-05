clear all;
close all;
clc;


%figure;
%number of new locations where we need the interpolated values
nsampl = 100;

%get the vector
%fct='1 ./(1+25 .*x.^2)';
fct='(sin(4*x) + 0.5*sin(8*x))/1.51';  %function to be approximated
a = -1;
b = 1;
deg = 7; % Number of points N = deg+1
xnodes=(a+b)/2+((b-a)/2)*(-cos(pi/(deg+1)*((0:deg)'+.5)));
x=xnodes; ydata=eval(fct);
ydata_originale = ydata;

%get the matrix C
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

c_i = C*ydata;
% display(c_i);

% Getting the input and coeffs scaled up. For verification purposes.
L = 16; %bitlength. Not t be confused for time window length in the chebyshev framework.
n0 = floor(ydata_originale*2^(L-1));
for i=1:length(n0)
    if(n0(i)==2^(L-1))
        n0(i) = n0(i)-1; %slight distortion being induced
    end
end


%getting the 2's complement representation of the input to be fed.
n0_set_for_bin = zeros(length(n0),1);
for i=1:length(n0)
    if(n0(i)<0)
        n0_set_for_bin(i) = 2^L + n0(i);
    else
        n0_set_for_bin(i) = n0(i);
    end
end
output = dec2hex(n0_set_for_bin,L/(2^2));   % this was dec2bin before. IMPORTANT. Theja 28th May 2009
dlmwrite('array_ip_data.list.matlab',output,'delimiter','');
%dlmwrite('array_ip_data_readable.list',n0,'delimiter','\n');