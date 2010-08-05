library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult_HalfAdder is
    port(
        sum             : out    vl_logic;
        carry           : out    vl_logic;
        a3              : in     vl_logic;
        b3              : in     vl_logic
    );
end Butterfly_Mult_HalfAdder;
