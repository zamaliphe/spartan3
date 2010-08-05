for theta1=1:64
    array2(theta1*2-1) = real(array1(theta1));
    array2(theta1*2) = imag(array1(theta1));
end
dlmwrite('33rd_row_rect_aftr_2nd_stage.txt',array2,'delimiter','\n','precision','%6.0f');