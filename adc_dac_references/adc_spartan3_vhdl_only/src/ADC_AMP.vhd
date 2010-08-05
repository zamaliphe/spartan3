----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:17:56 02/27/2008 
-- Design Name: 
-- Module Name:    ADC_AMP - Behavioral 
-- Project Name:   Interface to ADC on Spartan3E Board
-- Target Devices: 
-- Tool versions:  ISE 10.1
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADC_AMP is
Port ( 	  clk50 : in  STD_LOGIC; -- global clock
	        
			  -- user signal
			  ce_amp : in STD_LOGIC; -- 
           start_conv : in  STD_LOGIC;
			  ready : out STD_LOGIC := '0';
           
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
end ADC_AMP;

architecture Behavioral of ADC_AMP is


	type state_type is (IDLE, START,START2,HI,HI_DUMMY,LO,LO_DUMMY,FINE,IDLE_AD, START_AD,HI_AD,LO_AD,FINE_AD);
   signal next_state, state : state_type;	 
	signal counter : integer range 0 to 35 :=0;	
	signal sample : std_logic;
begin



process(start_conv,ce_amp,state,counter)
variable bit_count : integer range 0 to 15;
begin
		case state is
			when IDLE =>
				if ce_amp ='1' then
					next_state <= START;															
				else
					next_state <= IDLE;
				end if;
				
			when START =>
				next_state <= START2;	
				bit_count :=0;
			when START2 =>
				next_state <= HI;					
			when HI =>								
				if counter = 2 then
					next_state <= HI_DUMMY;
				else
					next_state <= HI;
				end if;			

			when HI_DUMMY =>
				bit_count := bit_count + 1;
				next_state <= LO;
			when LO =>
				if counter = 2 then
					next_state <= LO_DUMMY;
				else
					next_state <= LO;
				end if;		
			when LO_DUMMY =>
				if bit_count = 8 then
					next_state <= FINE;				
				else
					next_state <= HI;		
				end if;
			when FINE =>
				next_state <= IDLE_AD;--inizio a campionare
		
			when IDLE_AD =>
				if start_conv ='1' then
					next_state <= START_AD;															
				else
					next_state <= IDLE_AD;
				end if;				
			when START_AD =>
				next_state <= HI_AD;					
			when HI_AD =>		
				next_state <= LO_AD;
			when LO_AD =>
				if counter = 34 then
					next_state <= FINE_AD;
				else
					next_state <= HI_AD;
				end if;
			when FINE_AD =>
				next_state <= IDLE_AD;
			when others =>				
				next_state <= IDLE_AD;	  
		end case;

end process;

process(clk50)
begin
	if clk50'event and clk50 ='1' then
		state <= next_state;
	end if;
end process;

process (clk50)
variable index1 : integer range 0 to 15;
variable index2 : integer range 0 to 15;
begin 

if clk50'event and clk50 ='1' then

	case state is 
		when IDLE =>
			ready <= '0'; -- busy, setup AMP
			SCK <= '0';
			AMP_CS <= '1';
			MOSI <='0';
			counter <=0;
		when START =>
			AMP_CS <= '0';
			index1 := 7; -- 8 bit value
		when START2 =>
			MOSI <= gain(index1);		-- ci passo una sola volta dopodichè la assegno in LO_DUMMY	
			
		when HI =>
			
			SCK <= '1';						
			counter <= counter +1;
		when HI_DUMMY =>			
			counter <=0;
		when LO =>
			SCK <= '0';
			counter <= counter +1;
		when LO_DUMMY =>	
			MOSI <= gain(index1);
			index1 := index1-1;
			counter <=0;						
		when FINE =>
			AMP_CS <='1';
			SCK <= '0';
			MOSI <= '0';			

		when IDLE_AD =>
			ready <= '1'; -- setup AMP complete, waiting start_conv enable
			SCK <= '0';
			CONV <= '0';
			sample <='0';
		when START_AD =>
			
			ready <= '0'; -- busy to convert
			SCK <= '0';
			CONV <= '1';
			counter <= 0;
			sample <='0';
			index1 := 13; -- 14 bit value
			index2 := 13; -- 14 bit value
		when HI_AD =>
			SCK <= '1';
			CONV <= '0';			
			counter <= counter +1;
			sample <='0';
		when LO_AD =>
			SCK <= '0';
			CONV <= '0';	
			
			if(counter >2 and counter < 17) then				
					-- rappresentazione in complemento a 2
					if index1 = 13 then
						ADC1(index1)  <= not SPI_MISO;
					else
						ADC1(index1)  <= SPI_MISO;
					end if;					
					index1 := index1 -1;
					sample <='1';
			elsif(counter > 18 and counter < 33) then
					-- rappresentazione in complemento a 2
					if index2 = 13 then
						ADC2(index2)  <= not SPI_MISO;
					else
						ADC2(index2)  <= SPI_MISO;
					end if;
					index2 := index2 -1;
					sample <='1';			
			else
					sample <='0';
			end if;
		when FINE_AD =>
			counter <= 0;
			sample <='0';
			SCK <= '0';
			CONV <= '0';			

		when others =>
			ready <= '0';
			SCK <= '0';
			CONV <= '0';	
			AMP_CS <= '1';
			MOSI <='0';

	end case;
end if;

end process;



end Behavioral;

