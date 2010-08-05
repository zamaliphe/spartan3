library verilog;
use verilog.vl_types.all;
entity FFT2D is
    port(
        FFT_reset       : in     vl_logic;
        FFT_baseclock   : in     vl_logic;
        FFT_busyflag    : out    vl_logic;
        FFT_chooseIFFT  : in     vl_logic;
        FFT_dataa       : inout  vl_logic_vector(511 downto 0);
        FFT_datab       : inout  vl_logic_vector(511 downto 0);
        FFT_addra       : out    vl_logic_vector(287 downto 0);
        FFT_addrb       : out    vl_logic_vector(287 downto 0);
        FFT_wea         : out    vl_logic_vector(31 downto 0);
        FFT_web         : out    vl_logic_vector(31 downto 0);
        FFT_rea         : out    vl_logic_vector(31 downto 0);
        FFT_reb         : out    vl_logic_vector(31 downto 0)
    );
end FFT2D;
