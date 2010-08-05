-- Copyright (c) 2007 Frank Buss (fb@frank-buss.de)
-- See license.txt for license

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use work.ALL;

entity spartan3e_test is
    port(
        CLK_50MHZ       : in std_logic;
        led             : out std_logic_vector(7 downto 0);
        SPI_SCK         : out std_logic;
        SPI_MOSI        : out std_logic;
        DAC_CLR         : out std_logic;
        DAC_CS          : out std_logic;
        btn_north       : in std_logic;
        btn_south       : in std_logic;
        btn_west        : in std_logic;
        btn_east        : in std_logic;
        SW              : in std_logic_vector(3 downto 0);
        J2              : in std_logic_vector(3 downto 0);
        J4              : out std_logic_vector(3 downto 0);
        RS232_DCE_TXD   : out std_logic;
        RS232_DCE_RXD   : in std_logic
    );
end entity spartan3e_test;

architecture rtl of spartan3e_test is

	type dacStateType is (
		start,
		sendBit,
		clockHigh,
		csHigh
	);
	signal dacState   : dacStateType := start;
	signal dacCounter : integer range 0 to 23;
	signal dacData    : unsigned(23 downto 0);
    
    signal angle            : unsigned(31 downto 0);
    signal newSinValueStrobe: std_logic;
	signal sin              : signed(23 downto 0) := (others => '0');
	signal cos              : signed(23 downto 0) := (others => '0');
    
    signal randomValue      : unsigned(23 downto 0) := (others => '0');

    constant GENERATOR_VERSION : unsigned(39 downto 0) := x"47454e3031";
    
    constant CONTROL        : integer := 0;
    constant ACCU           : integer := 1;
    constant ACCU_INCREMENT : integer := 2;
    constant SQUARE_WAVE_THRESHOLD : integer := 3;
    constant SIN_REGISTER   : integer := 4;
    constant COS_REGISTER   : integer := 5;
    constant RANDOM_REGISTER : integer := 6;
    constant INPUT_REGISTER : integer := 7;
    constant OUTPUT_REGISTER : integer := 8;
    constant VERSION_REGISTER : integer := 15;
    
    constant DAC_SINE       : unsigned(3 downto 0) := x"1";
    constant DAC_SQUARE_WAVE : unsigned(3 downto 0) := x"2";
    constant DAC_NOISE      : unsigned(3 downto 0) := x"3";
    constant DAC_SAWTOOTH   : unsigned(3 downto 0) := x"4";
    
    subtype registerType is unsigned(39 downto 0);
    type registerArray is array (0 to 15) of registerType;
    signal registers        : registerArray := (others => ((others => '0')));
    
    signal readRequest      : std_logic := '0';
    signal writeRequest     : std_logic := '0';
    signal registerAddress  : unsigned(7 downto 0);
    signal newRegisterValue : unsigned(39 downto 0) := (others => '0');
    signal currentRegisterValue : unsigned(39 downto 0) := (others => '0');

    signal inputLatch : unsigned(7 downto 0) := x"00";
    
begin
    
    instanceCORDIC: entity CORDIC
    port map (
        clock       => CLK_50MHZ,
        reset       => btn_south,
		angle       => angle,
        newValueStrobe => newSinValueStrobe,
		sin         => sin,
		cos         => cos,
        sinCosReady => open
    );
    
    instanceRandomGenerator: entity RandomGenerator
    port map (
        clock           => CLK_50MHZ,
        reset           => btn_south,
		value           => randomValue,
        bitValue        => open
    );
    
    instanceRegisterTransmitter: entity RegisterTransmitter
    generic map(
        systemSpeed          => 50e6,
        baudrate             => 115200)
    port map(
        reset                => btn_south,
        clock                => CLK_50MHZ,
        rx                   => RS232_DCE_RXD,
        tx                   => RS232_DCE_TXD,
        readRequest          => readRequest,
        writeRequest         => writeRequest,
        registerAddress      => registerAddress,
        newRegisterValue     => newRegisterValue,
        currentRegisterValue => currentRegisterValue
    );
    
    process(CLK_50MHZ, btn_south)
        variable dacDataToSend : unsigned(11 downto 0);
    begin
        if rising_edge(CLK_50MHZ) then
            if btn_south = '1' then
                dacState <= start;
                registers <= (others => ((others => '0')));
            else
                -- transfer data to DAC every us
                newSinValueStrobe <= '0';
                case dacState is
                    when start =>
                        case registers(CONTROL)(3 downto 0) is
                            when DAC_SINE =>
                                if sin < 0 then
                                    dacDataToSend := (unsigned(sin(23 downto 12))) - x"800";
                                else
                                    dacDataToSend := unsigned(sin(23 downto 12)) + x"800";
                                end if;
                            when DAC_SQUARE_WAVE =>
                                if registers(ACCU) > registers(SQUARE_WAVE_THRESHOLD) then
                                    dacDataToSend := x"fff";
                                else
                                    dacDataToSend := x"000";
                                end if;
                            when DAC_NOISE =>
                                dacDataToSend := randomValue(23 downto 12);
                            when DAC_SAWTOOTH =>
                                dacDataToSend := registers(ACCU)(39 downto 28);
                            when others => dacDataToSend := x"000";
                        end case;
                        
                        -- update accu
                        registers(ACCU) <= registers(ACCU) + registers(ACCU_INCREMENT);

                        -- caculate next sine value
                        registers(SIN_REGISTER) <= x"0000" & unsigned(sin);
                        registers(COS_REGISTER) <= x"0000" & unsigned(cos);
                        angle <= registers(ACCU)(39 downto 8);
                        newSinValueStrobe <= '1';
                        
                        -- update random register
                        registers(RANDOM_REGISTER) <= x"0000" & randomValue;
                        
                        -- initialize DAC SPI
                        dacData <= "0010" & "1111" & dacDataToSend & "0000";
                        DAC_CS <= '0';
                        SPI_SCK <= '0';
                        dacCounter <= 23;
                        dacState <= sendBit;
                    when sendBit =>
                        SPI_SCK <= '0';
                        SPI_MOSI <= dacData(23);
                        dacData <= dacData(22 downto 0) & "0";
                        dacState <= clockHigh;
                    when clockHigh =>
                        SPI_SCK <= '1';
                        if dacCounter = 0 then
                            dacState <= csHigh;
                        else
                            dacCounter <= dacCounter - 1;
                            dacState <= sendBit;
                        end if;
                    when csHigh =>
                        DAC_CS <= '1';
                        dacState <= start;
                end case;

                -- answer register read request
                if readRequest = '1' then
                    case to_integer(registerAddress(3 downto 0)) is
                        when VERSION_REGISTER =>
                            currentRegisterValue <= GENERATOR_VERSION;
                        when others =>
                            currentRegisterValue <= registers(to_integer(registerAddress(3 downto 0)));
                    end case;
                end if;

                -- execute register write request
                if writeRequest = '1' then
                    registers(to_integer(registerAddress(3 downto 0))) <= newRegisterValue;
                end if;
                
                -- latch switches and other inputs
                inputLatch <= unsigned(sw & j2);
                
                -- copy input latches to register
                registers(INPUT_REGISTER) <= x"00000000" & inputLatch;

            end if;
        end if;
    end process;

    led <= std_logic_vector(registers(OUTPUT_REGISTER)(7 downto 0));
    j4 <= std_logic_vector(registers(OUTPUT_REGISTER)(15 downto 12));
    DAC_CLR <= '1';

end architecture rtl;
