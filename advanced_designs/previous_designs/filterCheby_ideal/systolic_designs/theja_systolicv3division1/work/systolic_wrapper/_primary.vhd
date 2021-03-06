library verilog;
use verilog.vl_types.all;
entity systolic_wrapper is
    generic(
        WORDLENGTH      : integer := 16
    );
    port(
        inputword       : in     vl_logic_vector;
        outputword      : out    vl_logic_vector;
        clk30x          : in     vl_logic;
        reset           : in     vl_logic
    );
end systolic_wrapper;
