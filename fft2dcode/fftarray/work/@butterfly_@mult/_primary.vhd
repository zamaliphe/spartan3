library verilog;
use verilog.vl_types.all;
entity Butterfly_Mult is
    port(
        xMultiplicand   : in     vl_logic_vector(15 downto 0);
        xMultiplier     : in     vl_logic_vector(15 downto 0);
        xProduct        : out    vl_logic_vector(31 downto 0)
    );
end Butterfly_Mult;
