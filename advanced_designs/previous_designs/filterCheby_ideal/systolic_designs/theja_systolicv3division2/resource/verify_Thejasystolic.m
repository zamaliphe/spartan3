%2009-05-28 : theja. this was the earstwhile cuypers.m file.
% do not edit this.
%requires T.m

% april 23
% 
% cuypers.m replicates the chebyshev interpolation process.
% the architecture is not specific to cuypers.
% this is an important file and can be added to the appendix of the thesis.



%close all;
clear all;
clc;
figure;
%number of new locations where we need the interpolated values
nsampl = 100;

%get the vector
%fct='1 ./(1+25 .*x.^2)';
fct='sin(4*x) + 0.5*sin(8*x)';  %function to be approximated
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


xnewlocations = a+(0:nsampl-1)*((b-a)/(nsampl-1));
x=xnewlocations; yexact=eval(fct);

% Instead of getting the T matrix which is fixed for a specific length
% and the powers of xnewlocations(i) we will evaluate the [T(n,x)]n=0,...,N for each
% xnewlocation(i)


for i=1:length(xnewlocations)
    for j=0:deg
        Tevaluated(j+1) = T(j,xnewlocations(i));
    end
    yapproximate(i) = (ydata'*C')*Tevaluated';
end


for k=1:(length(xnodes)-1), for i=1:(length(xnodes)-k)
    ydata(i)=(ydata(i+1)-ydata(i))./(xnodes(i+k)-xnodes(i));
    end, end, cof=ydata;
yinterp=(cof(1)*ones(length(xnewlocations),1))';
for i=2:length(xnodes); yinterp=cof(i)+(xnewlocations-xnodes(i)).*yinterp; end


hold on;
plot(xnewlocations,yapproximate,'r'); % plot chebyshev expansion values
plot(xnewlocations,yexact,'b'); % plot exact function values
plot(xnewlocations,yinterp,'--g'); % plot lagrange inter values

%yerror=yexact-yapproximate;
%plot(xnewlocations,yerror,['--','g']);  % plot error in current interpolation
%display(['mse = ', num2str(mean(yerror.^2)*100), '%' ]);