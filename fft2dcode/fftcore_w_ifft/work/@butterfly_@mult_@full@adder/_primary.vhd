library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult_FullAdder is
    port(
        sum             : out    vl_logic;
        carry           : out    vl_logic;
        a2              : in     vl_logic;
        b2              : in     vl_logic;
        c               : in     vl_logic
    );
end Butterfly_Mult_FullAdder;
