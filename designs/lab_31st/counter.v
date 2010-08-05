module counter(reset,clk,count);

input reset;
input clk;
output [7:0] count;

wire reset;
wire clk;
reg [7:0] count;

reg [25:0] internal_count;

always @ (posedge clk)
begin
	if (reset == 1'b1)
	begin
		count <= 0;
		internal_count <= 0;
	end
	else
	begin
		if(internal_count < 50000000)
		begin
			internal_count <= internal_count + 1'b1;
		end
		else
		begin
			internal_count <= 0;
			count <= count + 1'b1;
		end
	end
end

endmodule