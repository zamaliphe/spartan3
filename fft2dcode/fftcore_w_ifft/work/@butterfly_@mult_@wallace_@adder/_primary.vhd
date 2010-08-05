library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult_Wallace_Adder is
    port(
        sum             : out    vl_logic_vector(29 downto 0);
        c_out           : out    vl_logic;
        a1              : in     vl_logic_vector(29 downto 0);
        b1              : in     vl_logic_vector(29 downto 0)
    );
end Butterfly_Mult_Wallace_Adder;
