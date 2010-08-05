%filter here
coeff = [
5016, 
0,
-5732,
-6173,
-1579,
1722,
0,
-2105,
2368,
11465,
13375,
0,
-20062,
-26750,
-9472,
18944,
32767,
18944,
-9472,
-26750,
-20062,
0,
13375,
11465,
2368,
-2105,
0,
1722,
-1579,
-6173,
-5732,
0,
5016];

%scale back by 0.2
coeff_good = floor(coeff*0.2);
%getting the 2's complement representation of these
coeff_set_for_hex = zeros(length(coeff_good),1);
for i=1:length(coeff_good)
    if(coeff_good(i)<0)
        coeff_set_for_hex(i) = 65536 + coeff_good(i);
    else
        coeff_set_for_hex(i) = coeff_good(i);
    end
end
output = dec2hex(coeff_set_for_hex,4);

for i=1:length(output)
    display(['assign coeff[' int2str(i-1) '] = 16h' output(i,:) ';']);%how to insert single quote
end