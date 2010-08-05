data_width= 18;
max_data = 2^(data_width-1)-1;
min_data = -max_data;

%Filter coefficients
h=[-18979 12237 76169 131070 131070 76169 12237 -18979];

%Impulse response

   Inp = zeros(300,1);
   Inp(1)=max_data;
   %Impulse Response Plotting
   figure(1);
   output = conv(h, Inp);
   impulse_output = output;
   sz = size(output);
   max_x = max(sz);
   xline = linspace (0, max_x - 1, max_x);
   plot (xline, output,'r');
   title ('Time Display of Impulse Response');
   grid on;
   zoom on;
   outfile1 = fopen('imp_in.txt','w');
	fprintf(outfile1, '%d\n', Inp);
   fclose(outfile1);
   outfile1 = fopen('m_Inpulse_out.txt','w');
	fprintf(outfile1, '%d\n', output);
   fclose(outfile1);
   
   % Frequency Domain Plotting 
    to_plot = output;
    figure(2);
    freqdat = fft(to_plot);
    absdat = abs(freqdat);
    maxdat = max (absdat);
    logdat = 20*log10(absdat);
    sz = size(to_plot);
    numpts = max(sz);
    freq_res = 1/numpts;
    xline = linspace (0, ( (1/2)- freq_res ), round(numpts/2) );
   	plot (xline, logdat(1: round(numpts/2) ), 'b');
    title ('Frequency Display of Impulse Response');
    grid on;
    zoom on;
    xlabel ('Frequency');
    ylabel ('Magnitude - dB');
    
%Step Response
 
    step= zeros(300,1);
 	for	i=1:280
			step(i) = max_data;
	end;
	%step Response Plotting
    figure(3);
    output = conv(h,step);
    step_output = output;
    sz = size(output);
    max_x = max(sz);
    xline = linspace (0, max_x - 1, max_x);
  	plot (xline, output,'r');
    title ('Time Display of Step Response');
    grid on;
    zoom on;
    outfile2 = fopen('step_in.txt','w');
	fprintf(outfile2, '%d\n', step);
    fclose(outfile2);
      outfile2 = fopen('m_Step_out.txt','w');
	fprintf(outfile2, '%d\n', output);
    fclose(outfile2);
  
   % Frequency Domain Plotting 
    to_plot = output;
    figure(4);
    freqdat = fft(to_plot);
    absdat = abs(freqdat);
    maxdat = max (absdat);
    logdat = 20*log10(absdat);
    sz = size(to_plot);
    numpts = max(sz);
    freq_res = 1/numpts;
    xline = linspace (0, ( (1/2)- freq_res ), round(numpts/2) );
  	plot (xline, logdat(1: round(numpts/2) ), 'b');
    title ('Frequency Display of Step Response');
    grid on;
    zoom on;
    xlabel ('Frequency');
    ylabel ('Magnitude - dB');
    
%Ramdom Input

    random = round((rand(1, 100)-0.5)*(2^data_width-2)-1); 
    int_random = round(random);
    % Saturating Input Value
    a_in = find (int_random > max_data);
    b_in = find (int_random < min_data);
    if (~isempty(a_in)|~isempty(b_in))
         lenax = length (a_in);
         lenbx = length (b_in);
        for i = 1:lenax
             int_random(a_in(i)) = max_data;
        end
        for i = 1:lenbx
             int_random(b_in(i)) = min_data;
         end
    end
   %Random Response Plotting
    figure(5);
    output = conv(h,int_random');
    random_output = output;
    sz = size(output);
    max_x = max(sz);
    xline = linspace (0, max_x - 1, max_x);
  	plot (xline, output,'r');
    title ('Time Display of random Response');
    grid on;
    zoom on;
    outfile3 = fopen('rand_in.txt','w');
	fprintf(outfile3, '%d\n', int_random);
	fclose(outfile3);
    outfile3 = fopen('m_Random_out.txt','w');
	fprintf(outfile3, '%d\n', output);
	fclose(outfile3);

  
    % Frequency Domain Plotting 
    to_plot = output;
    figure(6);
    freqdat = fft(to_plot);
    absdat = abs(freqdat);
    maxdat = max(absdat);
    logdat = 20*log10(absdat);
    sz = size(to_plot);
    numpts = max(sz);
    freq_res = 1/numpts;
    xline = linspace (0, ( (1/2)- freq_res ), round(numpts/2) );
   	plot (xline, logdat(1: round(numpts/2) ), 'b');
    title ('Frequency Display of Random Response');
    grid on;
    zoom on;
    xlabel ('Frequency');
    ylabel ('Magnitude - dB');
    
    