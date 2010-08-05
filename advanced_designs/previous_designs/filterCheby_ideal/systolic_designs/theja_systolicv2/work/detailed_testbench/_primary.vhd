library verilog;
use verilog.vl_types.all;
entity detailed_testbench is
    generic(
        N               : integer := 8;
        DELAY           : integer := 30
    );
end detailed_testbench;
