function b = squareroot1(a)
cycle = 1;
square = uint32(1);
delta = uint32(3);  
while(square <= a)
	square = square + delta;    
	delta = delta + 2;  
    cycle = cycle + 1;
end
display(cycle);
b = uint32(int32(delta)/2) - 1; 
