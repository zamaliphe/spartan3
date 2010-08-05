library verilog;
use verilog.vl_types.all;
entity IO is
    port(
        ext_bidir_port  : inout  vl_logic_vector(15 downto 0);
        data_2b_input   : out    vl_logic_vector(15 downto 0);
        data_2b_output  : in     vl_logic_vector(15 downto 0);
        c_tri_data_2b_output: in     vl_logic;
        c_tri_data_2b_input: in     vl_logic;
        c_chip_select   : in     vl_logic;
        c_ext_write     : in     vl_logic;
        io_clock        : in     vl_logic;
        reset           : in     vl_logic
    );
end IO;
