library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_level is
    Port ( clk50_in : in  STD_LOGIC;
--user
           btn : in  STD_LOGIC; -- one of button
           led : out  STD_LOGIC_VECTOR (7 downto 0):= x"00";  -- spartan3 led
	        
    
-- elettrical line to/from AD&AMP
	     CONV : out std_logic; --adc
	     SPI_MISO : in std_logic; --adc
   	  AMP_CS : out  STD_LOGIC;			  
	     MOSI : out  STD_LOGIC;	-- amp
        SCK : out  STD_LOGIC			  
	);
end top_level;


architecture Behavioral of top_level is


component ADC_AMP 
Port ( 	  clk50 : in  STD_LOGIC; -- global clock
	        
			  -- user signal
			  ce_amp : in STD_LOGIC; -- 
           start_conv : in  STD_LOGIC;
			  ready : out STD_LOGIC := '0'; -- next conversion
           
			  -- ADC in/out signal
           SPI_MISO : in std_logic; --adc
			  CONV : out  STD_LOGIC :='0';	-- to adc : start conversion		  
			  ADC1 : out std_logic_vector(13 downto 0) := (others => '0');
			  ADC2 : out std_logic_vector(13 downto 0) := (others => '0');
           
			  -- AMP in/out signal
			  gain : in std_logic_vector(7 downto 0);
			  AMP_CS : out  STD_LOGIC;			  
			  MOSI : out  STD_LOGIC;	-- to amp : data to programmable amplifier
           SCK : out  STD_LOGIC); -- clock to AD & AMP
end component ;

 
  signal adc_ready : std_logic;		
  
  signal start_conversion : std_logic := '0';
  signal ADC_channel1 :  std_logic_vector(13 downto 0) := (others => '0');
 
  
begin
         

MyAD : ADC_AMP 
Port map ( 	  clk50 => clk50_in,
			  ce_amp => '1', -- always enable
           start_conv => start_conversion,
			  ready => adc_ready,
           SPI_MISO => SPI_MISO, 
			  CONV => CONV,--adc		 
			  ADC1 => ADC_channel1,
			  ADC2 => open,
			  gain => x"11",
			  AMP_CS =>AMP_CS,
			  MOSI => MOSI,
           SCK => SCK
			  );


process	 (clk50_in,adc_ready) -- this porcess is guided by the aDC  so we have the much of rate (it dependes on protocol)
begin

	if adc_ready'event and adc_ready = '1' then -- wait until ready become '1' the sample
		start_conversion <= '1';
		else
		start_conversion <= '0';
	end if;
end process;

led <= ADC_channel1(7 downto 0); -- you will see only the last 8 bit of the sample
			
end Behavioral;


