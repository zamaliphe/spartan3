I = imread('fingerprint.bmp');
J = rgb2gray(I);
fmtop = fmt(J);

%figure,surf(abs(fmtop));
% I1 = imread('fingerprint_scaled_rotated_shifted.bmp');
% J1 = rgb2gray(I1);
% fmtop1 = fmt(J1);
% figure,surf(abs(fmtop1));
% 
% errorprofile = abs(abs(fmtop) - abs(fmtop1));
% figure,surf(errorprofile);



% plotter_fingerprint_veri;
% gmat = gmat';
% step2_verilog = log_polar(abs(gmat));
% step2_verilog = round(step2_verilog);% (255/max(max(step2_verilog)))*
% text_file_input_generator_fmt3;

fmtop = fmtop/1024;
figure,surf(abs(fmtop));
plotter_fmt3_veri;
figure, surf(abs(gmatabs - abs(fmtop)));