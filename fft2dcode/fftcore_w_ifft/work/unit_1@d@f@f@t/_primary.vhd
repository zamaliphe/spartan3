library verilog;
use verilog.vl_types.all;
entity unit_1DFFT is
    port(
        i_fft_base_clock: in     vl_logic;
        command         : in     vl_logic_vector(5 downto 0);
        ram0_add        : out    vl_logic_vector(7 downto 0);
        ram0_bus        : inout  vl_logic_vector(15 downto 0);
        ram_cs_0        : out    vl_logic;
        ram_we_0        : out    vl_logic;
        ram_oe_0        : out    vl_logic;
        ram1_add        : out    vl_logic_vector(7 downto 0);
        ram1_bus        : inout  vl_logic_vector(15 downto 0);
        ram_cs_1        : out    vl_logic;
        ram_we_1        : out    vl_logic;
        ram_oe_1        : out    vl_logic;
        controlIFFT     : in     vl_logic
    );
end unit_1DFFT;
