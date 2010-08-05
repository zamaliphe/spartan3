--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:21:27 07/02/2008
-- Design Name:   
-- Module Name:   E:/Xilinx Work/adc/tb_adc1.vhd
-- Project Name:  adc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADC_AMP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY tb_adc1 IS
END tb_adc1;
 
ARCHITECTURE behavior OF tb_adc1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADC_AMP
    PORT(
         clk50 : IN  std_logic;
         ce_amp : IN  std_logic;
			ready : out STD_LOGIC := '0';
			
         start_conv : IN  std_logic;
         SPI_MISO : IN  std_logic;
         CONV : OUT  std_logic;
         ADC1 : OUT  std_logic_vector(13 downto 0);
         ADC2 : OUT  std_logic_vector(13 downto 0);
         gain : IN  std_logic_vector(7 downto 0);
         AMP_CS : OUT  std_logic;
         MOSI : OUT  std_logic;
         SCK : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk50 : std_logic := '0';
   signal ce_amp : std_logic := '0';
	signal ready : STD_LOGIC := '0';
	
   signal start_conv : std_logic := '0';
   signal SPI_MISO : std_logic := '0';
   signal gain : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal CONV : std_logic;
   signal ADC1 : std_logic_vector(13 downto 0);
   signal ADC2 : std_logic_vector(13 downto 0);
   signal AMP_CS : std_logic;
   signal MOSI : std_logic;
   signal SCK : std_logic;

   -- Clock period definitions
   constant clk50_period : time := 20 ns; -- 50 Mhz Clock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADC_AMP PORT MAP (
          clk50 => clk50,
          ce_amp => ce_amp,
          start_conv => start_conv,
			 ready => ready,
          SPI_MISO => SPI_MISO,
          CONV => CONV,
          ADC1 => ADC1,
          ADC2 => ADC2,
          gain => gain,
          AMP_CS => AMP_CS,
          MOSI => MOSI,
          SCK => SCK
        );

   -- Clock process definitions (50 Mhz)
   clk50_process :process
   begin
		clk50 <= '0';
		wait for clk50_period/2;
		clk50 <= '1';
		wait for clk50_period/2;
   end process;
 
 
 amp_signal: process
   begin		
		ce_amp <='0'; -- user CE
		
		wait for 40 ns; -- dummy delay (example fpga power up)
				
		gain <= x"11" after 5 ns; -- I set a gain of -1 for each ADC channel (I insert some delay due to path and ect..)	
      		
		wait for 40 ns; -- wait so gain is stable!! 
		ce_amp <='1';
		
		wait; -- wait AMP now is configured so I don't need to load value (for this test)
      
   end process;
	
	
   -- User Stimulus process
   stim_proc: process
   begin		
		
		wait for 100 ns; -- dummy delay (example fpga power up)
      start_conv <= '0';
      wait until rising_edge(ready); -- wait the AD to  became avaible to conversion
		
		-- simulation of external "START CONVERSION"
		start_conv <= '1';
		wait for 20 ns;
		start_conv <= '0';
	      
   end process;
	
	-- Sample signal generator
	process(CONV,SCK)
		variable index1 : integer;
		
	begin
	
	if conv = '1' then
		index1 := 0;
		
	elsif SCK'event and SCK = '1' then 
		
		index1 := index1+1;
			if index1 > 2 and index1 <= 16 then
				SPI_MISO <= not SPI_MISO after 6 ns; -- simple pattern
			elsif index1 > 18 and index1 < 32 then
				SPI_MISO <= not SPI_MISO after 6 ns; -- simple pattern
			else
				SPI_MISO <= '0'; -- simple pattern
			end if;
				
	end if;
		
	end process;

END;
