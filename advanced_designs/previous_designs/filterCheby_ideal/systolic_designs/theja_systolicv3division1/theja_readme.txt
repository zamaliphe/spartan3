Log on 28th: v3
the systolic array seems to be working fine. There is a lot of hardcoding vis-a-vis 8 point interpolation though.
the filter portion is going to be implemented outside this, using roms.

D:\embedded_lab\test\filterCheby_ideal\theja_systolicv3\refining_coefficients.m
D:\embedded_lab\test\filterCheby_ideal\theja_systolicv3\systolic_wrapper_ip_gen.m
will be useful for verification purposes.



Log on 28th: v2
Only the development of a single processing element is checked.
looks like the timing is ok.
compare this with Y:\theja\projectwork\matlab\architectures\cuypers\systolic_single_PE_dev or cuypers1_v1

sw used: only modelsim.
the input and C_row1 files can be hand-modified to see if the MAC operation is occuring or not.




Log on 27th May 2009:

modelsim and matlab 2008a have been used to check for a filter implementation using sequential booth encoded multiplier.
theja@mit.edu
there seems to be an attenuation of the order of 2 or 4.... can't figure it out...
the modelsim execution time is simply toomuch though.... :|

Log on 26th May:
while moving away from matlab to verilog, have to take care of issues like positioning, since the domain is now no longer -1 to 1. so there will be a scaler for interpolation purpose...right now can't think how this will fit in.
