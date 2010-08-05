library verilog;
use verilog.vl_types.all;
entity AGUabSequencer is
    port(
        upper           : out    vl_logic_vector(4 downto 0);
        lower           : out    vl_logic_vector(4 downto 0);
        c_abSeq_start   : in     vl_logic;
        pulse           : in     vl_logic;
        reset           : in     vl_logic
    );
end AGUabSequencer;
