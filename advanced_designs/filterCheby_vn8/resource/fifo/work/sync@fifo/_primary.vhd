library verilog;
use verilog.vl_types.all;
entity syncFifo is
    generic(
        RAM_DEPTH       : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        wr_cs           : in     vl_logic;
        rd_cs           : in     vl_logic;
        data_in         : in     vl_logic_vector(15 downto 0);
        rd_en           : in     vl_logic;
        wr_en           : in     vl_logic;
        data_out        : out    vl_logic_vector(15 downto 0);
        empty           : out    vl_logic;
        full            : out    vl_logic
    );
end syncFifo;
