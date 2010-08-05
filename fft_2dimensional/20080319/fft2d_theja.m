%y=imread('pic1.bmp');
rect = zeros(51);
rect(25:35,25:35)=ones(11);
surf(rect);
rect_fft = fft2(rect);
figure;
surf(abs(rect_fft));

%row column method
for i=1:51
    rect_fft_rc(i,:) = fft(rect(i,:));
end

rect_fft_rc = rect_fft_rc';

for i=1:51
        rect_fft_rc_final(i,:) = fft(rect_fft_rc(i,:));
end

rect_fft_rc_final = rect_fft_rc_final';
figure;
surf(abs(rect_fft));