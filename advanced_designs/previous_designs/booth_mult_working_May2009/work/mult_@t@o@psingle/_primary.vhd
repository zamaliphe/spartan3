library verilog;
use verilog.vl_types.all;
entity mult_TOPsingle is
    generic(
        MBITS           : integer := 16;
        NBITS           : integer := 16;
        DELAY           : integer := 5
    );
end mult_TOPsingle;
