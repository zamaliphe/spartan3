library verilog;
use verilog.vl_types.all;
entity FFT2D_Controller is
    generic(
        STATE_MODE_WIDTH: integer := 2;
        CONTROLLER_STATE_IDLE: integer := 0;
        CONTROLLER_STATE_FFT: integer := 1;
        CONTROLLER_STATE_TRANSPOSE: integer := 2;
        CONTROLLER_STATE_FFT_2: integer := 3
    );
    port(
        extc_base_clock : in     vl_logic;
        extc_asyn_reset : in     vl_logic;
        exts_busy       : out    vl_logic;
        f_unified_command: out    vl_logic_vector(5 downto 0);
        present_ram_row : out    vl_logic_vector(0 downto 0);
        transposer_reset: out    vl_logic;
        do_transpose    : out    vl_logic;
        do_bitreversing : out    vl_logic;
        done_transpose  : in     vl_logic
    );
end FFT2D_Controller;
