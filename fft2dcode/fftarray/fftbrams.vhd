library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.all;

library WORK;

entity fftbrams is
    Port (
	clk : in std_logic;
	MB_is_acting : in std_logic;
	MB_addr : in std_logic_vector(11 downto 0);
	MB_din :  in std_logic_vector(31 downto 0);
	MB_dout : out std_logic_vector(31 downto 0);
	MB_we : in std_logic;
	FFT_dataa : inout std_logic_vector(511 downto 0);
	FFT_datab : inout std_logic_vector(511 downto 0);
	FFT_addra : in std_logic_vector(287 downto 0);
	FFT_addrb : in std_logic_vector(287 downto 0);
	FFT_wea : in std_logic_vector(31 downto 0);
	FFT_web : in std_logic_vector(31 downto 0);
	FFT_rea : in std_logic_vector(31 downto 0);
	FFT_reb : in std_logic_vector(31 downto 0)
	);
end fftbrams;

architecture behavioral of fftbrams is

--single bram instantiation
COMPONENT singlebram
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
END COMPONENT;

signal addra : std_logic_vector(287 downto 0);
signal addrb : std_logic_vector(287 downto 0);
signal dina : std_logic_vector(511 downto 0);
signal dinb : std_logic_vector(511 downto 0);
signal douta : std_logic_vector(511 downto 0);
signal doutb : std_logic_vector(511 downto 0);
signal wea : std_logic_vector(31 downto 0);
signal web : std_logic_vector(31 downto 0);
	
begin

--gerating the necessary BRAMs
singlebram_gen : for i in 0 to 31 generate
	inst_singlebram: singlebram
		GENERIC MAP (bramnumber => i,
			     init_path => "./init_data/"
		)
		PORT MAP(
			addra => addra(i*9+8 downto i*9),
			addrb => addrb(i*9+8 downto i*9),
			clka => clk,
			clkb => clk,
			dina => dina(i*16+15 downto i*16),
			dinb => dinb(i*16+15 downto i*16),
			douta => douta(i*16+15 downto i*16),
			doutb => doutb(i*16+15 downto i*16),
			wea => wea(i),
			web => web(i)
		);
end generate;

--multiplexing the control/data for MicroBlaze or FFT core access
multiplexing_gen : for i in 0 to 31 generate
addra(i*9+8 downto i*9) <= FFT_addra(i*9+8 downto i*9) when MB_is_acting = '0' else -- MB only access the data (port A -> real)
	 			'1' & MB_addr(6 downto 0) & '0';

addrb(i*9+8 downto i*9) <= FFT_addrb(i*9+8 downto i*9) when MB_is_acting = '0' else -- MB only access the data (port B -> real)
		 		'1' & MB_addr(6 downto 0) & '1';

dina(i*16+15 downto i*16) <= FFT_dataa(i*16+15 downto i*16) when MB_is_acting = '0' else -- MB provides the real part
	 			MB_din(15 downto 0);

dinb(i*16+15 downto i*16) <= FFT_datab(i*16+15 downto i*16) when MB_is_acting = '0' else -- MB provides the img real
	 			MB_din(31 downto 16);

wea(i) <= FFT_wea(i) when MB_is_acting = '0' else
		'1' when MB_we = '1' and MB_addr(11 downto 7) = conv_std_logic_vector(i, 5) else
		'0';
web(i) <= FFT_web(i) when MB_is_acting = '0' else
		'1' when MB_we = '1' and MB_addr(11 downto 7) = conv_std_logic_vector(i, 5) else
		'0';
FFT_dataa(i*16+15 downto i*16) <= douta(i*16+15 downto i*16) when FFT_rea(i) = '1' else
				"ZZZZZZZZZZZZZZZZ";

FFT_datab(i*16+15 downto i*16) <= doutb(i*16+15 downto i*16) when FFT_reb(i) = '1' else
				"ZZZZZZZZZZZZZZZZ";
end generate;

--select the correct device for MicroBlaze to read
process(doutb,douta,MB_addr(11 downto 7))
begin
	for i in 0 to 31 loop
		if conv_std_logic_vector(i, 5) = MB_addr(11 downto 7) then
			MB_dout <= doutb(i*16+15 downto i*16) & douta(i*16+15 downto i*16);
		end if;
	end loop;
end process;


end behavioral;
