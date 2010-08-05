clc;
clear;

[c1 c2]=textread('mega_output_dumped','%d %d');

for i1=1:64
    for j1=1:64
        mat1(i1,j1) = c1(64*(i1-1)+2*j1-1) + i*c1(64*(i1-1)+2*j1);
    end
end

[c3 c4]=textread('output_dumped_transposed','%d %d');

for i1=1:64
    for j1=1:64
        mat2(i1,j1) = c3(64*(i1-1)+2*j1-1) + i*c3(64*(i1-1)+2*j1);
    end
end
