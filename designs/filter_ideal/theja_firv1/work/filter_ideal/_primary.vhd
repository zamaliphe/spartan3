library verilog;
use verilog.vl_types.all;
entity filter_ideal is
    port(
        xin             : in     vl_logic_vector(15 downto 0);
        yout            : out    vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end filter_ideal;
