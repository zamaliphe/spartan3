LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
LIBRARY work; 
use work.txt_util.all;

ENTITY singlebram IS
	generic ( bramnumber : integer;
		  init_path  : string := "");
	port (
	addra: IN std_logic_VECTOR(8 downto 0);
	addrb: IN std_logic_VECTOR(8 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(15 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(15 downto 0);
	wea: IN std_logic;
	web: IN std_logic);
END singlebram;

ARCHITECTURE singlebram_a OF singlebram IS
-- synthesis translate_off

constant c_mem_init_file : string := init_path & "fft_" & str(bramnumber) & ".mif";

component wrapped_singlebram
	port (
	addra: IN std_logic_VECTOR(8 downto 0);
	addrb: IN std_logic_VECTOR(8 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(15 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(15 downto 0);
	wea: IN std_logic;
	web: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_singlebram use entity XilinxCoreLib.blkmemdp_v6_3(behavioral)
		generic map(
			c_reg_inputsb => 0,
			c_reg_inputsa => 0,
			c_has_ndb => 0,
			c_has_nda => 0,
			c_ytop_addr => "1024",
			c_has_rfdb => 0,
			c_has_rfda => 0,
			c_ywea_is_high => 1,
			c_yena_is_high => 1,
			c_yclka_is_rising => 1,
			c_yhierarchy => "hierarchy1",
			c_ysinita_is_high => 1,
			c_ybottom_addr => "0",
			c_width_b => 16,
			c_width_a => 16,
			c_sinita_value => "0",
			c_sinitb_value => "0",
			c_limit_data_pitch => 18,
			c_write_modeb => 0,
			c_write_modea => 0,
			c_has_rdyb => 0,
			c_yuse_single_primitive => 0,
			c_has_rdya => 0,
			c_addra_width => 9,
			c_addrb_width => 9,
			c_has_limit_data_pitch => 0,
			c_default_data => "0",
			c_pipe_stages_b => 0,
			c_yweb_is_high => 1,
			c_yenb_is_high => 1,
			c_pipe_stages_a => 0,
			c_yclkb_is_rising => 1,
			c_yydisable_warnings => 1,
			c_enable_rlocs => 0,
			c_ysinitb_is_high => 1,
			c_has_web => 1,
			c_has_default_data => 0,
			c_has_sinitb => 0,
			c_has_wea => 1,
			c_has_sinita => 0,
			c_has_dinb => 1,
			c_has_dina => 1,
			c_ymake_bmm => 0,
			c_sim_collision_check => "NONE",
			c_has_enb => 0,
			c_has_ena => 0,
			--c_mem_init_file => "bram00.mif",
			c_mem_init_file => c_mem_init_file,
			c_depth_b => 512,
			c_depth_a => 512,
			c_has_doutb => 1,
			c_has_douta => 1,
			c_yprimitive_type => "32kx1");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_singlebram
		port map (
			addra => addra,
			addrb => addrb,
			clka => clka,
			clkb => clkb,
			dina => dina,
			dinb => dinb,
			douta => douta,
			doutb => doutb,
			wea => wea,
			web => web);
-- synthesis translate_on

END singlebram_a;

