library verilog;
use verilog.vl_types.all;
entity AGUwSequencer is
    port(
        wBaseAdd        : out    vl_logic_vector(3 downto 0);
        c_wSeq_start    : in     vl_logic;
        pulse           : in     vl_logic;
        reset           : in     vl_logic
    );
end AGUwSequencer;
