LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.all;

LIBRARY work; 
use work.txt_util.all;

entity fftbramstb is
end fftbramstb;

architecture testbench of fftbramstb is

--single bram instantiation
COMPONENT fftbrams
	port (
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
END COMPONENT;

signal clk :  std_logic :='0';
signal FFT_dataa :  std_logic_vector(511 downto 0);
signal FFT_datab :  std_logic_vector(511 downto 0);
signal FFT_addra :  std_logic_vector(287 downto 0);
signal FFT_addrb :  std_logic_vector(287 downto 0);
signal FFT_wea :  std_logic_vector(31 downto 0);
signal FFT_web :  std_logic_vector(31 downto 0);
signal FFT_rea :  std_logic_vector(31 downto 0);
signal FFT_reb :  std_logic_vector(31 downto 0);

constant t : time := 10 ns; --half period
	
begin

clk <= not clk after t;

inst_fftbrams: fftbrams
	PORT MAP(
		clk => clk,
		MB_is_acting => '0',
		MB_addr => X"000",
		MB_din => X"00000000",
		MB_dout => open,
		MB_we => '0',
		FFT_dataa => FFT_dataa,
		FFT_datab => FFT_datab,
		FFT_addra => FFT_addra,
		FFT_addrb => FFT_addrb,
		FFT_wea => FFT_wea,
		FFT_web => FFT_web,
		FFT_rea => FFT_rea,
		FFT_reb => FFT_reb
	);


tb_process: process
variable i,j : integer;
begin
	FFT_dataa <= (others=>'Z');
	FFT_datab <= (others=>'Z');
	FFT_addra <= (others=>'0');
	FFT_addrb <= (others=>'0');
	FFT_wea <= (others=>'0');
	FFT_web <= (others=>'0');
	FFT_rea <= (others=>'1');
	FFT_reb <= (others=>'1');
	
	wait for 6*t;
	--test tri-state
	FFT_rea <= (others=>'0');
	FFT_reb <= (others=>'0');

	wait for 6*t;

	FFT_rea <= (others=>'1');
	FFT_reb <= (others=>'1');

	wait for 2*t;

	-- read initialization test

	
	for i in 0 to 511 loop
		for j in 0 to 31 loop
			FFT_addra(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
			FFT_addrb(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
		end loop;
		wait for 2*t;
	end loop;

	-- write 10101010... in all positions

	FFT_rea <= (others=>'0');
	FFT_reb <= (others=>'0');
	FFT_wea <= (others=>'1');
	FFT_web <= (others=>'0');

	for i in 0 to 511 loop
		for j in 0 to 31 loop
			FFT_addra(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
			FFT_addrb(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
		end loop;
		for j in 0 to 31 loop
			FFT_dataa(j*16+15 downto j*16) <= X"AAAA";
			FFT_datab(j*16+15 downto j*16) <= X"5555";
		end loop;
		wait for 2*t;
	end loop;

	FFT_dataa <= (others=>'Z');
	FFT_datab <= (others=>'Z');
	FFT_rea <= (others=>'0');
	FFT_reb <= (others=>'0');
	FFT_wea <= (others=>'0');
	FFT_web <= (others=>'0');

	wait for 6*t;

	-- read the values written before
	FFT_rea <= (others=>'1');
	FFT_reb <= (others=>'1');
	FFT_wea <= (others=>'0');
	FFT_web <= (others=>'0');

	for i in 0 to 511 loop
		for j in 0 to 31 loop
			FFT_addra(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
			FFT_addrb(j*9+8 downto j*9) <= conv_std_logic_vector(i, 9);
		end loop;
		wait for 2*t;
	end loop;

	report "End of test" severity Failure; --the test will stop here

	wait;
end process;

end testbench;