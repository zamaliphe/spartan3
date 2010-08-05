library verilog;
use verilog.vl_types.all;
entity rom_T_x7 is
    port(
        i_rom_address   : in     vl_logic_vector(2 downto 0);
        o_rom_data      : out    vl_logic_vector(15 downto 0);
        c_rom_read_en   : in     vl_logic;
        c_rom_ce        : in     vl_logic;
        c_rom_tri_output: in     vl_logic
    );
end rom_T_x7;
