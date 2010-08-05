
assign start_mult 	=   (donext_delayed)?1:0;
assign chosen_coeff = 	(wordIndex==(startIndex+0)%8)?C_row[0]:(wordIndex==(startIndex+1)%8)?C_row[1]:
						(wordIndex==(startIndex+2)%8)?C_row[2]:(wordIndex==(startIndex+3)%8)?C_row[3]:
						(wordIndex==(startIndex+4)%8)?C_row[4]:(wordIndex==(startIndex+5)%8)?C_row[5]:
						(wordIndex==(startIndex+6)%8)?C_row[6]:C_row[7];
//
assign intermediate[2]= (wordIndex== (startIndex+0)%8)?0:previousOutputword;

//Instantiations
multALU adder(outputword, intermediate[1], intermediate[2], 1'b0);
mult multiplier(intermediate[1],inputword,chosen_coeff,clk30x,multBusyFlag,start_mult);

//Logic
always @(posedge clk30x)
begin
	if (reset) 
	begin
		wordIndex 			<= -1;
		previousOutputword 	<=  0;
		donext_delayed		<=	0;
	end
	else
	begin
	   if(donext)	//donext starts thecomputation with the appropriate coefficient and is spaces atleast 16-20 cycles apart for a 16 bit operation (on base clk clk30x)
		begin
			donext_delayed 		<= 1;
			wordIndex 			<= wordIndex + 1'b1	;
			previousOutputword 	<= outputword		;
		end
		else if (donext_delayed)
		begin
			donext_delayed		<= 0;
		end
	end
end

endmodule
