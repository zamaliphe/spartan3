library verilog;
use verilog.vl_types.all;
entity systolic_PE2 is
    generic(
        WORDLENGTH      : integer := 16
    );
    port(
        inputword       : in     vl_logic_vector;
        outputword      : out    vl_logic_vector;
        clk30x          : in     vl_logic;
        timing          : in     vl_logic_vector(31 downto 0);
        reset           : in     vl_logic
    );
end systolic_PE2;
