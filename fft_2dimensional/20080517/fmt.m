function [ fmtop fmtop2] = fmt(I)
%FMT Summary of this function goes here
%   Detailed explanation goes here

step1 = abs(fft2(I));
step2 = log_polar(step1);
step3 = fft2(step2);
fmtop = step3;