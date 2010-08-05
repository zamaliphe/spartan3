library verilog;
use verilog.vl_types.all;
entity multALU is
    generic(
        MBITS           : integer := 16
    );
    port(
        \out\           : out    vl_logic_vector;
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic
    );
end multALU;
