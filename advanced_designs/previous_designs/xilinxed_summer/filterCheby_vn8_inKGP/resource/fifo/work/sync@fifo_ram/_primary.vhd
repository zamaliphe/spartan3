library verilog;
use verilog.vl_types.all;
entity syncFifo_ram is
    generic(
        RAM_DEPTH       : integer := 16
    );
    port(
        address_0       : in     vl_logic_vector(3 downto 0);
        data_0          : inout  vl_logic_vector(15 downto 0);
        cs_0            : in     vl_logic;
        we_0            : in     vl_logic;
        oe_0            : in     vl_logic;
        address_1       : in     vl_logic_vector(3 downto 0);
        data_1          : inout  vl_logic_vector(15 downto 0);
        cs_1            : in     vl_logic;
        we_1            : in     vl_logic;
        oe_1            : in     vl_logic
    );
end syncFifo_ram;
