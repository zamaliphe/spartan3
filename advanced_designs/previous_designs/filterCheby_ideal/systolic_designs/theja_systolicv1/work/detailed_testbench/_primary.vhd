library verilog;
use verilog.vl_types.all;
entity detailed_testbench is
    generic(
        N               : integer := 4096;
        DELAY           : integer := 30
    );
end detailed_testbench;
