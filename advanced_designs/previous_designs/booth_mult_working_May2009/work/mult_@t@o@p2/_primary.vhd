library verilog;
use verilog.vl_types.all;
entity mult_TOP2 is
    generic(
        M_bits          : integer := 12;
        N_bits          : integer := 8;
        Del             : integer := 10
    );
end mult_TOP2;
