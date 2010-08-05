close all;
%clear all;
clc;
numberofpoints = 128;
n0 = textread('ip_data_readable.list','%d');

[n1 m2]=textread('results_first.list','%d %d');
h=figure;
plot(n0(1:numberofpoints),'r');
hold on;


plot(n1(1:numberofpoints),'b');
%hold off;
%title('input and output signals to the BPF(Fpass=100to200hz,Fs = 1kHz)');
%xlabel('sample number'),ylabel('magnitude scaled to 16 bit resolution');
%h = legend('input','output',2);

% h2=figure;
% plot(abs(fft(n1)),'b');
% hold on;
% plot(abs(fft(n0)),'r');
% hold off;
% title('FFT of the input and output signals to the BPF(Fpass=100to200hz,Fs = 1kHz)');
% xlabel('sample number'),ylabel('magnitude scaled to 16 bit resolution');
% h = legend('output fft','input fft',2);


coeff = coeff1;
% %filter here
% coeff = [
% 5016, 
% 0,
% -5732,
% -6173,
% -1579,
% 1722,
% 0,
% -2105,
% 2368,
% 11465,
% 13375,
% 0,
% -20062,
% -26750,
% -9472,
% 18944,
% 32767,
% 18944,
% -9472,
% -26750,
% -20062,
% 0,
% 13375,
% 11465,
% 2368,
% -2105,
% 0,
% 1722,
% -1579,
% -6173,
% -5732,
% 0,
% 5016];


% use only if the other one is commented..
n1ref = conv(coeff,n0);
plot(n1ref(1:numberofpoints),'g');


% % use only if the other one is commented..
% coeff_good = floor(coeff*0.2);
% n1ref = conv(coeff_good/max(coeff),n0);
% plot(n1ref(1:numberofpoints),'b');
% hold off;
% title('input and output signals to the BPF(Fpass=100to200hz,Fs = 1kHz)');
% xlabel('sample number'),ylabel('magnitude scaled to 16 bit resolution');
% h = legend('input','output',2);

% h2=figure;
% plot(abs(fft(n1ref)),'b');
% hold on;
% plot(abs(fft(n0)),'r');
% hold off;
% title('FFT of the input and output signals to the BPF(Fpass=100to200hz,Fs = 1kHz)');
% xlabel('sample number'),ylabel('magnitude scaled to 16 bit resolution');
% h = legend('output fft','input fft',2);