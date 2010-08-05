library verilog;
use verilog.vl_types.all;
entity multiplier is
    port(
        xMultiplicand   : in     vl_logic_vector(15 downto 0);
        xMultiplier     : in     vl_logic_vector(15 downto 0);
        xProduct        : out    vl_logic_vector(15 downto 0)
    );
end multiplier;
