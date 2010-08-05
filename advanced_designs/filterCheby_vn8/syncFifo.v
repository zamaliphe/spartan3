//theja 1st june 2009 have made this a 16 location rather than an 8 location fifo..
//Asynchronous dp RAM is instantiated by this module

module syncFifo (
clk      , // Clock input
rst      , // Active high reset
wr_cs    , // Write chip select
rd_cs    , // Read chip select
data_in  , // Data input
rd_en    , // Read enable
wr_en    , // Write Enable
data_out , // Data Output
empty    , // FIFO empty
full       // FIFO full
);    
 
// FIFO constants
parameter RAM_DEPTH = (1 << 4);
// Port Declarations
input clk ;
input rst ;
input wr_cs ;
input rd_cs ;
input rd_en ;
input wr_en ;
inout [16-1:0] data_in ;
output full ;
output empty ;
output [16-1:0] data_out ;

//-----------Internal variables-------------------
reg [4-1:0] wr_pointer;
reg [4-1:0] rd_pointer;
reg [4 :0] status_cnt;
reg [16-1:0] data_out ;
wire [16-1:0] data_ram ;

//-----------Variable assignments---------------
assign full = (status_cnt == (RAM_DEPTH-1));
assign empty = (status_cnt == 0);

//-----------Code Start---------------------------
always @ (posedge clk or posedge rst)
begin : WRITE_POINTER
  if (rst) begin
    wr_pointer <= 0;
  end else if (wr_cs && wr_en ) begin
    wr_pointer <= wr_pointer + 1;
  end
end

always @ (posedge clk or posedge rst)
begin : READ_POINTER
  if (rst) begin
    rd_pointer <= 0;
  end else if (rd_cs && rd_en ) begin
    rd_pointer <= rd_pointer + 1;
  end
end

always  @ (posedge clk or posedge rst)
begin : READ_DATA
  if (rst) begin
    data_out <= 0;
  end else if (rd_cs && rd_en ) begin
    data_out <= data_ram;
  end
end

always @ (posedge clk or posedge rst)
begin : STATUS_COUNTER
  if (rst) begin
    status_cnt <= 0;
  // Read but no write.
  end else if ((rd_cs && rd_en) && !(wr_cs && wr_en) 
                && (status_cnt != 0)) begin
    status_cnt <= status_cnt - 1;
  // Write but no read.
  end else if ((wr_cs && wr_en) && !(rd_cs && rd_en) 
               && (status_cnt != RAM_DEPTH)) begin
    status_cnt <= status_cnt + 1;
  end
end 
   
syncFifo_ram aram01(
wr_pointer , // address_0 input 
data_in    , // data_0 bi-directional
wr_cs      , // chip select
wr_en      , // write enable
1'b0       , // output enable
rd_pointer , // address_q input
data_ram   , // data_1 bi-directional
rd_cs      , // chip select
1'b0       , // Read enable
rd_en        // output enable
);     

endmodule
