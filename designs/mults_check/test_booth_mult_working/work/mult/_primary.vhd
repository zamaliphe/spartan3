library verilog;
use verilog.vl_types.all;
entity mult is
    generic(
        MBITS           : integer := 12;
        NBITS           : integer := 8;
        COUNTBITS       : integer := 4
    );
    port(
        xProd           : out    vl_logic_vector;
        xMpd            : in     vl_logic_vector;
        mpr             : in     vl_logic_vector;
        wClk            : in     vl_logic;
        busy            : out    vl_logic;
        start           : in     vl_logic
    );
end mult;
