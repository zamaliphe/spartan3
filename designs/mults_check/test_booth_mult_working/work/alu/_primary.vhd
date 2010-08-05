library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        MBITS           : integer := 12
    );
    port(
        \out\           : out    vl_logic_vector;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic
    );
end alu;
