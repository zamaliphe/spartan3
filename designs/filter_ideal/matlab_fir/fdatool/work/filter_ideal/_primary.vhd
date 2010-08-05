library verilog;
use verilog.vl_types.all;
entity filter_ideal is
    generic(
        coeff1          : integer := 62282;
        coeff2          : integer := 6253;
        coeff3          : integer := 11798;
        coeff4          : integer := 18696;
        coeff5          : integer := 24224;
        coeff6          : integer := 26324;
        coeff7          : integer := 24224;
        coeff8          : integer := 18696;
        coeff9          : integer := 11798;
        coeff10         : integer := 6253;
        coeff11         : integer := 62282
    );
    port(
        clk             : in     vl_logic;
        clk_enable      : in     vl_logic;
        reset           : in     vl_logic;
        filter_in       : in     vl_logic_vector(15 downto 0);
        filter_out      : out    vl_logic_vector(15 downto 0)
    );
end filter_ideal;
