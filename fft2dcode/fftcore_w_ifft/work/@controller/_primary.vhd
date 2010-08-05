library verilog;
use verilog.vl_types.all;
entity Controller is
    generic(
        IDLE            : integer := 0;
        READ_INPUTS     : integer := 1;
        BUTTERFLY_OPS   : integer := 2;
        WRITE_RESULTS   : integer := 3
    );
    port(
        sequence        : in     vl_logic_vector(3 downto 0);
        mode_termination: out    vl_logic_vector(2 downto 0);
        agu_clock       : out    vl_logic;
        agu_start       : out    vl_logic;
        agu_reset       : out    vl_logic;
        agu_oe          : out    vl_logic;
        agu_mode        : out    vl_logic_vector(1 downto 0);
        x_we_ram        : in     vl_logic;
        butter_clock    : out    vl_logic;
        butter_start    : out    vl_logic;
        butter_reset    : out    vl_logic;
        butter_o_tri    : out    vl_logic;
        ram_clk         : out    vl_logic;
        ram_cs_0        : out    vl_logic;
        ram_we_0        : out    vl_logic;
        ram_oe_0        : out    vl_logic;
        ram_cs_1        : out    vl_logic;
        ram_we_1        : out    vl_logic;
        ram_oe_1        : out    vl_logic;
        rom_re          : out    vl_logic;
        rom_cs          : out    vl_logic;
        rom_tri         : out    vl_logic;
        io_tri_outgoing_line: out    vl_logic;
        io_tri_incoming_line: out    vl_logic;
        io_cs           : out    vl_logic;
        io_ext_write    : out    vl_logic;
        io_clock        : out    vl_logic;
        io_reset        : out    vl_logic;
        exts_busy       : out    vl_logic;
        exts_TIP        : out    vl_logic;
        counter         : out    vl_logic_vector(7 downto 0);
        extc_fft_cs     : in     vl_logic;
        extc_data_2_fftchip: in     vl_logic;
        extc_asyn_reset : in     vl_logic;
        extc_base_clock : in     vl_logic
    );
end Controller;
