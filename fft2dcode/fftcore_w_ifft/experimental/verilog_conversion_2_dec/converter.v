module converter;

integer fout;
reg [15:0] read_element;
reg [9:0] count;
integer read_element32;//CHECK THIS
reg     [15:0]        bram_total_data [0:511]   ;

 initial begin
  $readmemb("fft_0.mif", bram_total_data); // memory_list is memory file
end


always #2 read_element32 = {(read_element[15]==1)?16'b1111_1111_1111_1111:0,read_element};

initial
begin
	read_element	<= 0;
	read_element32 	<= 0;
	count 		<= 0;
	
	fout = $fopen("reconstructed_bram_data.list");
	$fmonitor(fout,"%d \t %d",read_element32, count);
	
	for(count=0;count<512;count = count +1)//for each element
	begin
		read_element <= bram_total_data[count[8:0]];
		#2 ;
	end
	$fclose(fout);
	#2 $finish;
end


endmodule		
