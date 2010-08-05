library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult_Wallace is
    port(
        prod            : out    vl_logic_vector(31 downto 0);
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0)
    );
end Butterfly_Mult_Wallace;
