library verilog;
use verilog.vl_types.all;
entity AGU is
    port(
        readAddress     : out    vl_logic_vector(6 downto 0);
        controlPulse    : in     vl_logic;
        c_agu_start     : in     vl_logic;
        reset           : in     vl_logic;
        outputEnable    : in     vl_logic;
        writeAddress    : out    vl_logic_vector(6 downto 0);
        c_mode          : in     vl_logic_vector(1 downto 0);
        xOpCount        : out    vl_logic_vector(4 downto 0);
        x_we_ram        : out    vl_logic;
        controlIFFT     : in     vl_logic
    );
end AGU;
