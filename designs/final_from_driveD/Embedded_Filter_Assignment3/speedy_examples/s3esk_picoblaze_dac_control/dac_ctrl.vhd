--
-- Definition of a dual port ROM for KCPSM2 or KCPSM3 program defined by dac_ctrl.psm
-- and assmbled using KCPSM2 or KCPSM3 assembler.
--
-- Standard IEEE libraries
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--  
library unisim;
use unisim.vcomponents.all;
--
--
entity dac_ctrl is
    Port (      address : in std_logic_vector(9 downto 0);
            instruction : out std_logic_vector(17 downto 0);
             proc_reset : out std_logic;
                    clk : in std_logic);
    end dac_ctrl;
--
architecture low_level_definition of dac_ctrl is
--
-- Declare signals internal to this module
--
signal jaddr     : std_logic_vector(10 downto 0);
signal jparity   : std_logic_vector(0 downto 0);
signal jdata     : std_logic_vector(7 downto 0);
signal doa       : std_logic_vector(7 downto 0);
signal dopa      : std_logic_vector(0 downto 0);
signal tdo1      : std_logic;
signal tdo2      : std_logic;
signal update    : std_logic;
signal shift     : std_logic;
signal reset     : std_logic;
signal tdi       : std_logic;
signal sel1      : std_logic;
signal drck1     : std_logic;
signal drck1_buf : std_logic;
signal sel2      : std_logic;
signal drck2     : std_logic;
signal capture   : std_logic;
signal tap5      : std_logic;
signal tap11     : std_logic;
signal tap17     : std_logic;
--
-- Attributes to define ROM contents during implementation synthesis. 
-- The information is repeated in the generic map for functional simulation
--
attribute INIT_00 : string; 
attribute INIT_01 : string; 
attribute INIT_02 : string; 
attribute INIT_03 : string; 
attribute INIT_04 : string; 
attribute INIT_05 : string; 
attribute INIT_06 : string; 
attribute INIT_07 : string; 
attribute INIT_08 : string; 
attribute INIT_09 : string; 
attribute INIT_0A : string; 
attribute INIT_0B : string; 
attribute INIT_0C : string; 
attribute INIT_0D : string; 
attribute INIT_0E : string; 
attribute INIT_0F : string; 
attribute INIT_10 : string; 
attribute INIT_11 : string; 
attribute INIT_12 : string; 
attribute INIT_13 : string; 
attribute INIT_14 : string; 
attribute INIT_15 : string; 
attribute INIT_16 : string; 
attribute INIT_17 : string; 
attribute INIT_18 : string; 
attribute INIT_19 : string; 
attribute INIT_1A : string; 
attribute INIT_1B : string; 
attribute INIT_1C : string; 
attribute INIT_1D : string; 
attribute INIT_1E : string; 
attribute INIT_1F : string; 
attribute INIT_20 : string; 
attribute INIT_21 : string; 
attribute INIT_22 : string; 
attribute INIT_23 : string; 
attribute INIT_24 : string; 
attribute INIT_25 : string; 
attribute INIT_26 : string; 
attribute INIT_27 : string; 
attribute INIT_28 : string; 
attribute INIT_29 : string; 
attribute INIT_2A : string; 
attribute INIT_2B : string; 
attribute INIT_2C : string; 
attribute INIT_2D : string; 
attribute INIT_2E : string; 
attribute INIT_2F : string; 
attribute INIT_30 : string; 
attribute INIT_31 : string; 
attribute INIT_32 : string; 
attribute INIT_33 : string; 
attribute INIT_34 : string; 
attribute INIT_35 : string; 
attribute INIT_36 : string; 
attribute INIT_37 : string; 
attribute INIT_38 : string; 
attribute INIT_39 : string; 
attribute INIT_3A : string; 
attribute INIT_3B : string; 
attribute INIT_3C : string; 
attribute INIT_3D : string; 
attribute INIT_3E : string; 
attribute INIT_3F : string; 
attribute INITP_00 : string;
attribute INITP_01 : string;
attribute INITP_02 : string;
attribute INITP_03 : string;
attribute INITP_04 : string;
attribute INITP_05 : string;
attribute INITP_06 : string;
attribute INITP_07 : string;
--
-- Attributes to define ROM contents during implementation synthesis.
--
attribute INIT_00 of ram_1024_x_18 : label is  "0FFFC00100A2E008E007E006E005E004E003E002E001E000000000BB00520077";
attribute INIT_01 of ram_1024_x_18 : label is  "4200620861036002E600E7010608070E0608070E0608070E0608070E50104FFF";
attribute INIT_02 of ram_1024_x_18 : label is  "5432400054324100E100C0CC4032E2080201543240F05432410FA10080CC542A";
attribute INIT_03 of ram_1024_x_18 : label is  "E2098201E105E00400CD010C403C00330103543A22026209E103E002E2080200";
attribute INIT_04 of ram_1024_x_18 : label is  "E121E020A100800161216020E806E90789080808090E0808090E0808090E005E";
attribute INIT_05 of ram_1024_x_18 : label is  "6E106F11A000E0140099E01500D2E012E0130000E0100000E0110024400FC180";
attribute INIT_06 of ram_1024_x_18 : label is  "5467C001B9F098E05C6E0A080B0E0808090A0010080009006A146B156C126D13";
attribute INIT_07 of ram_1024_x_18 : label is  "4301E001C008E001C2040108A000C00800AEA000E810E911EE12EF13F9D0D8C0";
attribute INIT_08 of ram_1024_x_18 : label is  "007AC230A20F12C01920007A0200C008E0200077A000547BC101C00802002380";
attribute INIT_09 of ram_1024_x_18 : label is  "E0201620007A12A01720007A12B00B000A060B000A060B000A060B000A061820";
attribute INIT_0A of ram_1024_x_18 : label is  "54ADC10100A80128A00054A9C001000BA000C008E080C008E0800077A000C008";
attribute INIT_0B of ram_1024_x_18 : label is  "A00054BCC40100B60414A00054B7C30100B10314A00054B2C20100AC0219A000";
attribute INIT_0C of ram_1024_x_18 : label is  "00866A066B070C0300866A046B050C0200866A026B030C0100866A006B010C00";
attribute INIT_0D of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000080010F00";
attribute INIT_0E of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_0F of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_10 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_11 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_12 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_13 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_14 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_15 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_16 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_17 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_18 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_19 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1A of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1B of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1C of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1D of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1E of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_1F of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_20 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_21 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_22 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_23 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_24 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_25 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_26 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_27 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_28 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_29 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2A of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2B of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2C of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2D of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2E of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_2F of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_30 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_31 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_32 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_33 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_34 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_35 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_36 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_37 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_38 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_39 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3A of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3B of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3C of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3D of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3E of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000000000000";
attribute INIT_3F of ram_1024_x_18 : label is  "40C0000000000000000000000000000000000000000000000000000000000000";
attribute INITP_00 of ram_1024_x_18 : label is "088A2AA5D5EA80000A22888EA50A6AAB9A0C34A8DD5E375740AAAAAD3EAAAA3F";
attribute INITP_01 of ram_1024_x_18 : label is "00000000000000000000000CC0C0C0C0B72DCB72DCB4A23A0C32AAA8C0323B69";
attribute INITP_02 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_03 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_04 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_05 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_06 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";
attribute INITP_07 of ram_1024_x_18 : label is "C000000000000000000000000000000000000000000000000000000000000000";
--
begin
--
  --Instantiate the Xilinx primitive for a block RAM
  ram_1024_x_18: RAMB16_S9_S18
  --synthesis translate_off
  --INIT values repeated to define contents for functional simulation
  generic map (INIT_00 => X"0FFFC00100A2E008E007E006E005E004E003E002E001E000000000BB00520077",
               INIT_01 => X"4200620861036002E600E7010608070E0608070E0608070E0608070E50104FFF",
               INIT_02 => X"5432400054324100E100C0CC4032E2080201543240F05432410FA10080CC542A",
               INIT_03 => X"E2098201E105E00400CD010C403C00330103543A22026209E103E002E2080200",
               INIT_04 => X"E121E020A100800161216020E806E90789080808090E0808090E0808090E005E",
               INIT_05 => X"6E106F11A000E0140099E01500D2E012E0130000E0100000E0110024400FC180",
               INIT_06 => X"5467C001B9F098E05C6E0A080B0E0808090A0010080009006A146B156C126D13",
               INIT_07 => X"4301E001C008E001C2040108A000C00800AEA000E810E911EE12EF13F9D0D8C0",
               INIT_08 => X"007AC230A20F12C01920007A0200C008E0200077A000547BC101C00802002380",
               INIT_09 => X"E0201620007A12A01720007A12B00B000A060B000A060B000A060B000A061820",
               INIT_0A => X"54ADC10100A80128A00054A9C001000BA000C008E080C008E0800077A000C008",
               INIT_0B => X"A00054BCC40100B60414A00054B7C30100B10314A00054B2C20100AC0219A000",
               INIT_0C => X"00866A066B070C0300866A046B050C0200866A026B030C0100866A006B010C00",
               INIT_0D => X"0000000000000000000000000000000000000000000000000000000080010F00",
               INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
               INIT_3F => X"40C0000000000000000000000000000000000000000000000000000000000000",    
               INITP_00 => X"088A2AA5D5EA80000A22888EA50A6AAB9A0C34A8DD5E375740AAAAAD3EAAAA3F",
               INITP_01 => X"00000000000000000000000CC0C0C0C0B72DCB72DCB4A23A0C32AAA8C0323B69",
               INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
               INITP_07 => X"C000000000000000000000000000000000000000000000000000000000000000")
  --synthesis translate_on
  port map(    DIB => "0000000000000000",
              DIPB => "00",
               ENB => '1',
               WEB => '0',
              SSRB => '0',
              CLKB => clk,
             ADDRB => address,
               DOB => instruction(15 downto 0),
              DOPB => instruction(17 downto 16),
               DIA => jdata,
              DIPA => jparity,
               ENA => sel1,
               WEA => '1',
              SSRA => '0',
              CLKA => update,
              ADDRA=> jaddr,
               DOA => doa(7 downto 0),
              DOPA => dopa); 
  v2_bscan: BSCAN_VIRTEX2 
  port map(   TDO1 => tdo1,
         TDO2 => tdo2,
            UPDATE => update,
             SHIFT => shift,
             RESET => reset,
               TDI => tdi,
              SEL1 => sel1,
             DRCK1 => drck1,
              SEL2 => sel2,
             DRCK2 => drck2,
      CAPTURE => capture);
  --buffer signal used as a clock
  upload_clock: BUFG
  port map( I => drck1,
            O => drck1_buf);
  -- Assign the reset to be active whenever the uploading subsystem is active
  proc_reset <= sel1;
  srlC1: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tdi,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(10),
            Q15 => jaddr(8));
  flop1: FD
  port map ( D => jaddr(10),
             Q => jaddr(9),
             C => drck1_buf);
  srlC2: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jaddr(8),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(7),
            Q15 => tap5);
  flop2: FD
  port map ( D => jaddr(7),
             Q => jaddr(6),
             C => drck1_buf);
  srlC3: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap5,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(5),
            Q15 => jaddr(3));
  flop3: FD
  port map ( D => jaddr(5),
             Q => jaddr(4),
             C => drck1_buf);
  srlC4: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jaddr(3),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(2),
            Q15 => tap11);
  flop4: FD
  port map ( D => jaddr(2),
             Q => jaddr(1),
             C => drck1_buf);
  srlC5: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap11,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jaddr(0),
            Q15 => jdata(7));
  flop5: FD
  port map ( D => jaddr(0),
             Q => jparity(0),
             C => drck1_buf);
  srlC6: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jdata(7),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(6),
            Q15 => tap17);
  flop6: FD
  port map ( D => jdata(6),
             Q => jdata(5),
             C => drck1_buf);
  srlC7: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => tap17,
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(4),
            Q15 => jdata(2));
  flop7: FD
  port map ( D => jdata(4),
             Q => jdata(3),
             C => drck1_buf);
  srlC8: SRLC16E
  --synthesis translate_off
  generic map (INIT => X"0000")
  --synthesis translate_on
  port map(   D => jdata(2),
             CE => '1',
            CLK => drck1_buf,
             A0 => '1',
             A1 => '0',
             A2 => '1',
             A3 => '1',
              Q => jdata(1),
            Q15 => tdo1);
  flop8: FD
  port map ( D => jdata(1),
             Q => jdata(0),
             C => drck1_buf);
end low_level_definition;
--
------------------------------------------------------------------------------------
--
-- END OF FILE dac_ctrl.vhd
--
------------------------------------------------------------------------------------
