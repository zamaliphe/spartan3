module simple_counter
    (         	 simple_io,
                       led,
                    switch,
                 btn_north,
                  btn_east,
                 btn_south,
                  btn_west,
                       clk);

output [12:9] simple_io;
output [7:0] led;
input [3:0] switch;
input btn_north;
input btn_east;
input btn_south;
input btn_west;
input clk;


wire [12:9] simple_io;
reg [7:0] led;
reg [25:0] int_count;//        : integer range 0 to 49999999 :=0; THEJA, this should be adjusted for faster speed.

always @(posedge clk)
begin
	if(switch[0]==1)
	begin
		int_count <= 0;
		led <= 0;
	end
	else
	begin
		//divide 50MHz by 50,000,0000 to form 1Hz pulses
		//if (int_count==49999999)
		if (int_count==49999999) //1hz
		begin
			int_count <= 0;
			led <= led + 1'b1;
		end
		else
		begin
			int_count <= int_count + 1'b1;
		end
	end
end 
endmodule