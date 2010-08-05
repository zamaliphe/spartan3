clc;
clear;

total_rams = 2;
ram_row_max = 2;
N = total_rams*ram_row_max;

%Filling up the original Matrix
for i0=1:N
    for j0=1:N
        mat1(i0,j0) = (i0-1)*N+j0;
    end
end
display(mat1);    
mat_ori = mat1;

%Transposing it distributedly
for k=1:total_rams
    for iX=1:ram_row_max
        for jX=(k-1)*2+iX:N
            tempX = mat1((k-1)*2+iX,jX);
            mat1((k-1)*2+iX,jX) = mat1(jX,(k-1)*2+iX);
            mat1(jX,(k-1)*2+iX) = tempX;
            jX=jX+1;
        end
    end
end
display(mat1);