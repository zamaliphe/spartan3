library verilog;
use verilog.vl_types.all;
entity Butterfly is
    port(
        xInput          : in     vl_logic_vector(15 downto 0);
        xClock          : in     vl_logic;
        xStart          : in     vl_logic;
        xReset          : in     vl_logic;
        xtriOutput      : out    vl_logic_vector(15 downto 0);
        c_output_tri    : in     vl_logic
    );
end Butterfly;
