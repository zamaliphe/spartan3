library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult_CLA16 is
    port(
        carryin         : in     vl_logic;
        operand1        : in     vl_logic_vector(15 downto 0);
        operand2        : in     vl_logic_vector(15 downto 0);
        result          : out    vl_logic_vector(15 downto 0);
        carry_out       : out    vl_logic
    );
end Butterfly_Mult_CLA16;
