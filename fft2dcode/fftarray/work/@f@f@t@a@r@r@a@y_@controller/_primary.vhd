library verilog;
use verilog.vl_types.all;
entity FFTARRAY_Controller is
    generic(
        STATE_MODE_WIDTH: integer := 2;
        CONTROLLER_STATE_IDLE: integer := 0;
        CONTROLLER_STATE_FFT: integer := 1
    );
    port(
        extc_base_clock : in     vl_logic;
        extc_asyn_reset : in     vl_logic;
        exts_busy       : out    vl_logic;
        f_unified_command: out    vl_logic_vector(5 downto 0)
    );
end FFTARRAY_Controller;
