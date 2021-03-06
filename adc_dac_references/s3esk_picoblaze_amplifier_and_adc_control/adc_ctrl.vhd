--
-- Definition of a dual port ROM for KCPSM2 or KCPSM3 program defined by adc_ctrl.psm
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
entity adc_ctrl is
    Port (      address : in std_logic_vector(9 downto 0);
            instruction : out std_logic_vector(17 downto 0);
             proc_reset : out std_logic;
                    clk : in std_logic);
    end adc_ctrl;
--
architecture low_level_definition of adc_ctrl is
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
attribute INIT_00 of ram_1024_x_18 : label is  "E0060000020C01B301B301B301B301B3016102110523014E0211051001FB011F";
attribute INIT_01 of ram_1024_x_18 : label is  "E0068001600650164FFF548D2E0454862E014E00C0010FFF4092E005E0040001";
attribute INIT_02 of ram_1024_x_18 : label is  "0520A700A600050600E4012700116301620001996000019960010211052CC080";
attribute INIT_03 of ram_1024_x_18 : label is  "640463016200007401D1052DA7008601E7FFE6FF403B052B54362780017F0211";
attribute INIT_04 of ram_1024_x_18 : label is  "505A440501FC0018505A440301F80030505A440201EC0077505A440101D800EF";
attribute INIT_05 of ram_1024_x_18 : label is  "A7068672A700A600050600E401FF009C505A440101FF0038505A440601FE000C";
attribute INIT_06 of ram_1024_x_18 : label is  "547242FF5472431F407201D1053E546C4200546C43E063016200017802110517";
attribute INIT_07 of ram_1024_x_18 : label is  "01D18530650801D18530650901D1052E01D18530650A01024014007401D1053C";
attribute INIT_08 of ram_1024_x_18 : label is  "C0016004C000409200075492400880016004C000A00001D1052001D185306507";
attribute INIT_09 of ram_1024_x_18 : label is  "01D1053D01D10547021105100122D20002060206020602066205E00400015492";
attribute INIT_0A of ram_1024_x_18 : label is  "01D1053254B5400240DF01D1052001D1052001D1053154AC4001600401D1052D";
attribute INIT_0B of ram_1024_x_18 : label is  "54C7400440DF01D1052001D1052001D1053554BE400340DF01D1052001D10520";
attribute INIT_0C of ram_1024_x_18 : label is  "40DF01D1052001D1053001D1053254D0400540DF01D1052001D1053001D10531";
attribute INIT_0D of ram_1024_x_18 : label is  "01AE01D1053001D1053001D1053140DF01D1052001D1053001D1053554D94006";
attribute INIT_0E of ram_1024_x_18 : label is  "0008010E0A0F198008FF50EC238008000400050006000700401454DF20054000";
attribute INIT_0F of ram_1024_x_18 : label is  "F680F530D4205D01200154EECA010900080003000206B790B680B53094205CF5";
attribute INIT_10 of ram_1024_x_18 : label is  "03A002000700060015701460A0005504C0018801F480010A08070005A000F790";
attribute INIT_11 of ram_1024_x_18 : label is  "00AEA0005511C1010208030E07000606B5309420411906075916F530D420010D";
attribute INIT_12 of ram_1024_x_18 : label is  "5526C101C008E001020023404301C008E001C2040108C008E008011FA000C008";
attribute INIT_13 of ram_1024_x_18 : label is  "060023804301C008E001C008E0010122C008E010C008E010011FA000C008E008";
attribute INIT_14 of ram_1024_x_18 : label is  "01D10550A0000608070A0608070A0808090A0808090A5539C101090008000700";
attribute INIT_15 of ram_1024_x_18 : label is  "01D1056501D1057A01D1056101D1056C01D1054201D1056F01D1056301D10569";
attribute INIT_16 of ram_1024_x_18 : label is  "057401D1056E01D1056F01D1054301D1052001D1054301D1054401D10541A000";
attribute INIT_17 of ram_1024_x_18 : label is  "0541A00001D1053D01D1054101D10556A00001D1056C01D1056F01D1057201D1";
attribute INIT_18 of ram_1024_x_18 : label is  "101012000194000E000E000E000E1100A00001D1053D01D1054401D1052F01D1";
attribute INIT_19 of ram_1024_x_18 : label is  "A00001D1156001D1152016100188A000803A80075997C00AA00011000194A00F";
attribute INIT_1A of ram_1024_x_18 : label is  "01A90314A00055AAC20101A40219A00055A5C10101A00128A00055A1C001000B";
attribute INIT_1B of ram_1024_x_18 : label is  "C440A4F8A000C440E40101A0C440E401A00055B4C40101AE0414A00055AFC301";
attribute INIT_1C of ram_1024_x_18 : label is  "C44004F001A401BE0406040604060407145001A001BEC408A4F01450A00001B8";
attribute INIT_1D of ram_1024_x_18 : label is  "04F001A401B8C4400406040604070407145001A001B8C440C40CA4F01450A000";
attribute INIT_1E of ram_1024_x_18 : label is  "E401400201A0C440E40101A0C440E401450201A0C440E401C440040EA000C440";
attribute INIT_1F of ram_1024_x_18 : label is  "01BE01AE01BE043001AEA00001A4C4400404D500000E000E000E000EA5F0C440";
attribute INIT_20 of ram_1024_x_18 : label is  "01A901A901C2050101C2050C01C2050601C2052801A401BE042001A401BE01A9";
attribute INIT_21 of ram_1024_x_18 : label is  "E703E602E901E8000133A00001C2C5C0A50FA00001C2C580A50F52172510A000";
attribute INIT_22 of ram_1024_x_18 : label is  "0000000000000000000000000000000000000000000000000000000080010F00";
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
attribute INIT_3F of ram_1024_x_18 : label is  "421B000000000000000000000000000000000000000000000000000000000000";
attribute INITP_00 of ram_1024_x_18 : label is "D34CD3FCDDF3743C55B0D0D0D0D0D0D003C50CDF16C0333293774CE88FFFF3CF";
attribute INITP_01 of ram_1024_x_18 : label is "5776A957A03400F4F333CCCDF3337CCCDF3337CCCDF3334CCCCCAA234F353B34";
attribute INITP_02 of ram_1024_x_18 : label is "2CCCB33333333332CCCCCCCCCAAAAB6A922088E8D892223A2DAA5ED4000B5B09";
attribute INITP_03 of ram_1024_x_18 : label is "FCEE0AA20E38388A3EAA3E028FAA3C0B8A38B72DCB72DCB4B30E5D8C0EA8B333";
attribute INITP_04 of ram_1024_x_18 : label is "00000000000000000000000000000000000000000000000CAAEC2C36FCCCCF3F";
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
  generic map (INIT_00 => X"E0060000020C01B301B301B301B301B3016102110523014E0211051001FB011F",
               INIT_01 => X"E0068001600650164FFF548D2E0454862E014E00C0010FFF4092E005E0040001",
               INIT_02 => X"0520A700A600050600E4012700116301620001996000019960010211052CC080",
               INIT_03 => X"640463016200007401D1052DA7008601E7FFE6FF403B052B54362780017F0211",
               INIT_04 => X"505A440501FC0018505A440301F80030505A440201EC0077505A440101D800EF",
               INIT_05 => X"A7068672A700A600050600E401FF009C505A440101FF0038505A440601FE000C",
               INIT_06 => X"547242FF5472431F407201D1053E546C4200546C43E063016200017802110517",
               INIT_07 => X"01D18530650801D18530650901D1052E01D18530650A01024014007401D1053C",
               INIT_08 => X"C0016004C000409200075492400880016004C000A00001D1052001D185306507",
               INIT_09 => X"01D1053D01D10547021105100122D20002060206020602066205E00400015492",
               INIT_0A => X"01D1053254B5400240DF01D1052001D1052001D1053154AC4001600401D1052D",
               INIT_0B => X"54C7400440DF01D1052001D1052001D1053554BE400340DF01D1052001D10520",
               INIT_0C => X"40DF01D1052001D1053001D1053254D0400540DF01D1052001D1053001D10531",
               INIT_0D => X"01AE01D1053001D1053001D1053140DF01D1052001D1053001D1053554D94006",
               INIT_0E => X"0008010E0A0F198008FF50EC238008000400050006000700401454DF20054000",
               INIT_0F => X"F680F530D4205D01200154EECA010900080003000206B790B680B53094205CF5",
               INIT_10 => X"03A002000700060015701460A0005504C0018801F480010A08070005A000F790",
               INIT_11 => X"00AEA0005511C1010208030E07000606B5309420411906075916F530D420010D",
               INIT_12 => X"5526C101C008E001020023404301C008E001C2040108C008E008011FA000C008",
               INIT_13 => X"060023804301C008E001C008E0010122C008E010C008E010011FA000C008E008",
               INIT_14 => X"01D10550A0000608070A0608070A0808090A0808090A5539C101090008000700",
               INIT_15 => X"01D1056501D1057A01D1056101D1056C01D1054201D1056F01D1056301D10569",
               INIT_16 => X"057401D1056E01D1056F01D1054301D1052001D1054301D1054401D10541A000",
               INIT_17 => X"0541A00001D1053D01D1054101D10556A00001D1056C01D1056F01D1057201D1",
               INIT_18 => X"101012000194000E000E000E000E1100A00001D1053D01D1054401D1052F01D1",
               INIT_19 => X"A00001D1156001D1152016100188A000803A80075997C00AA00011000194A00F",
               INIT_1A => X"01A90314A00055AAC20101A40219A00055A5C10101A00128A00055A1C001000B",
               INIT_1B => X"C440A4F8A000C440E40101A0C440E401A00055B4C40101AE0414A00055AFC301",
               INIT_1C => X"C44004F001A401BE0406040604060407145001A001BEC408A4F01450A00001B8",
               INIT_1D => X"04F001A401B8C4400406040604070407145001A001B8C440C40CA4F01450A000",
               INIT_1E => X"E401400201A0C440E40101A0C440E401450201A0C440E401C440040EA000C440",
               INIT_1F => X"01BE01AE01BE043001AEA00001A4C4400404D500000E000E000E000EA5F0C440",
               INIT_20 => X"01A901A901C2050101C2050C01C2050601C2052801A401BE042001A401BE01A9",
               INIT_21 => X"E703E602E901E8000133A00001C2C5C0A50FA00001C2C580A50F52172510A000",
               INIT_22 => X"0000000000000000000000000000000000000000000000000000000080010F00",
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
               INIT_3F => X"421B000000000000000000000000000000000000000000000000000000000000",    
               INITP_00 => X"D34CD3FCDDF3743C55B0D0D0D0D0D0D003C50CDF16C0333293774CE88FFFF3CF",
               INITP_01 => X"5776A957A03400F4F333CCCDF3337CCCDF3337CCCDF3334CCCCCAA234F353B34",
               INITP_02 => X"2CCCB33333333332CCCCCCCCCAAAAB6A922088E8D892223A2DAA5ED4000B5B09",
               INITP_03 => X"FCEE0AA20E38388A3EAA3E028FAA3C0B8A38B72DCB72DCB4B30E5D8C0EA8B333",
               INITP_04 => X"00000000000000000000000000000000000000000000000CAAEC2C36FCCCCF3F",
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
-- END OF FILE adc_ctrl.vhd
--
------------------------------------------------------------------------------------
