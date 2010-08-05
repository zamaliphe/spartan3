
%v1: on june 1, 2009. subtracting 1 from the final deltas.
%v0: on may 29, 2009. using times.txt to get the deltas. Interpreting the
%deltas is important

clc;

numberofpoints = 16;

[times interruptType]=textread('times.txt','%f %f');

%title('input and output signals to the BPF(Fpass=100to200hz,Fs = 1kHz)');
%xlabel('sample number'),ylabel('magnitude scaled to 16 bit resolution');
%h = legend('input','output',2);

deltaTintermed = cat(1,times(2:length(times)),2+times(1))-times;

deltaT = cat(1,deltaTintermed(end),deltaTintermed(1:length(deltaTintermed)-1));

scale = 50*10^6/(2*10^3);    %desired average sampling... say want 1Khz avg 
                            %sampling factor 2 is because there are 
                            %equidistant no-sampling interrrupts also.
deltaTscaled = round(deltaT'*(scale/mean(deltaT))) -1;  %edited on 1st June, 2009.
output = dec2hex(deltaTscaled,8);
for i=1:length(deltaTscaled)
    display(['assign timing[' int2str(i-1) '] = 32h' output(i,:) ';']);
end