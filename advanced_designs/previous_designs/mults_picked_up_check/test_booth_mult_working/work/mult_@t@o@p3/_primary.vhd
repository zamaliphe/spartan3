library verilog;
use verilog.vl_types.all;
entity mult_TOP3 is
    generic(
        MBITS           : integer := 12;
        NBITS           : integer := 8;
        DELAY           : integer := 5
    );
end mult_TOP3;
