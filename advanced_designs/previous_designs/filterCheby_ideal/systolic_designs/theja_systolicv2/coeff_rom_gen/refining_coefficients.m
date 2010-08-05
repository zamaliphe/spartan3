%should run cuypers.m before running this. uses the workspace variable C (matrix).

Cinteg = floor(C*(2^15));%should be actually: 1 maps to 2^15-1 and -1 maps to -2^15
[length1 length2] = size(Cinteg);

%getting the 2's complement representation of these
C_set_for_hex = zeros(length1,length2);
for i=1:length1
    for j=1:length2
        if(Cinteg(i,j)<0)
            C_set_for_hex(i,j) = 2^16 + Cinteg(i,j);
        else
            C_set_for_hex(i,j) = Cinteg(i,j);
        end
    end
    output = dec2hex(C_set_for_hex(i,:),4);

    for j=1:length2
        display(['assign C_row[' int2str(j-1) '] = 16h' output(j,:) ';']);%how to insert single quote
    end
    pause;
    clc;
end