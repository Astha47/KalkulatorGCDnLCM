library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GCD_ASCII_CONVERTER is
    Port (
        RST     : in  STD_LOGIC;
        START   : in  STD_LOGIC;
        INPUT8 : in  UNSIGNED (7 downto 0);
        CLK     : in  STD_LOGIC;
        DONE    : out STD_LOGIC;
        OUTPUT1GCD  : out UNSIGNED (7 downto 0);
        OUTPUT2GCD  : out UNSIGNED (7 downto 0);
        OUTPUT3GCD  : out UNSIGNED (7 downto 0)
        
    );
end GCD_ASCII_CONVERTER;

architecture ArsitekturGCDtoASCII of GCD_ASCII_CONVERTER is
    
    component BCDfrom8bit
        port (
            RST     : in  STD_LOGIC;
            START   : in  STD_LOGIC;
            INPUT8 : in  UNSIGNED (7 downto 0);
            CLK     : in  STD_LOGIC;
            DONE    : out STD_LOGIC;
            OUPUT1  : out UNSIGNED (3 downto 0);
            OUPUT2  : out UNSIGNED (3 downto 0);
            OUPUT3  : out UNSIGNED (3 downto 0)
        );
    end component;
    
    component BCDtoASCII
        port (
            BCD_in   : in  UNSIGNED (3 downto 0);
            ASCII_out: out UNSIGNED (7 downto 0)
        );
    end component;
    
    signal BCD1  : UNSIGNED (3 downto 0);
    signal BCD2  : UNSIGNED (3 downto 0);
    signal BCD3  : UNSIGNED (3 downto 0);
    
begin
    
    DoubleDabble : BCDfrom8bit
        port map (
            RST     => RST,
            START   => START,
            INPUT8 => INPUT8,
            CLK     => CLK,
            DONE    => DONE,
            OUPUT1  => BCD1,
            OUPUT2  => BCD2,
            OUPUT3  => BCD3
        );
        
    GCD1 : BCDtoASCII
        port map (
            BCD_in   => BCD1,
            ASCII_out=> OUTPUT1GCD
        );
        
    GCD2 : BCDtoASCII
        port map (
            BCD_in   => BCD2,
            ASCII_out=> OUTPUT2GCD
        );
        
    GCD3 : BCDtoASCII
        port map (
            BCD_in   => BCD3,
            ASCII_out=> OUTPUT3GCD
        );
           
end ArsitekturGCDtoASCII;
