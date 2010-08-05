module simple_counter
    (                  led,
                    switch,
                       clk);

output [7:0] led;		// Output 8 bits
input switch;			//Input 1 bit
input clk;				//Input 1 bit


reg [7:0] led;			//Output declared as a register
reg [25:0] int_count;	// Internal Register

always @(posedge clk)	//Sensitivity List
begin
	if(switch==1)		//Switch is acting as a reset active HIGH
	begin
		int_count 	<= 0;
		led 		<= 0;
	end
	else
	begin
		//divide 50MHz by 50,000,0000 to form 1Hz pulses
		if (int_count==49999999) //1hz
		begin
			int_count 	<= 0;
			led 		<= led + 1'b1;
		end
		else
		begin
			int_count <= int_count + 1'b1;
		end
	end
end 
endmodule