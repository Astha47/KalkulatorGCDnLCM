library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LCM_ASCII_CONVERTER is
    Port (
        RST     : in  STD_LOGIC;
        START   : in  STD_LOGIC;
        INPUT32 : in  UNSIGNED (31 downto 0);
        CLK     : in  STD_LOGIC;
        DONE    : out STD_LOGIC;

        -- DEBUGGING PORT
        DEBUG   : OUT unsigned (7 downto 0);

        OUTPUT1LCM  : out UNSIGNED (7 downto 0);
        OUTPUT2LCM  : out UNSIGNED (7 downto 0);
        OUTPUT3LCM  : out UNSIGNED (7 downto 0);
        OUTPUT4LCM  : out UNSIGNED (7 downto 0);
        OUTPUT5LCM  : out UNSIGNED (7 downto 0);
        OUTPUT6LCM  : out UNSIGNED (7 downto 0);
        OUTPUT7LCM  : out UNSIGNED (7 downto 0);
        OUTPUT8LCM  : out UNSIGNED (7 downto 0);
        OUTPUT9LCM  : out UNSIGNED (7 downto 0);
        OUTPUT10LCM : out UNSIGNED (7 downto 0)
    );
end LCM_ASCII_CONVERTER;

architecture ArsitekturLCMtoASCII of LCM_ASCII_CONVERTER is
    
    component BCDfrom32bit
        port (
            RST     : in  STD_LOGIC;
            START   : in  STD_LOGIC;
            INPUT32 : in  UNSIGNED (31 downto 0);
            CLK     : in  STD_LOGIC;
            DONE    : out STD_LOGIC;
            OUPUT1  : out UNSIGNED (3 downto 0);
            OUPUT2  : out UNSIGNED (3 downto 0);
            OUPUT3  : out UNSIGNED (3 downto 0);
            OUPUT4  : out UNSIGNED (3 downto 0);
            OUPUT5  : out UNSIGNED (3 downto 0);
            OUPUT6  : out UNSIGNED (3 downto 0);
            OUPUT7  : out UNSIGNED (3 downto 0);
            OUPUT8  : out UNSIGNED (3 downto 0);
            OUPUT9  : out UNSIGNED (3 downto 0);
            OUPUT10 : out UNSIGNED (3 downto 0)
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
    signal BCD4  : UNSIGNED (3 downto 0);
    signal BCD5  : UNSIGNED (3 downto 0);
    signal BCD6  : UNSIGNED (3 downto 0);
    signal BCD7  : UNSIGNED (3 downto 0);
    signal BCD8  : UNSIGNED (3 downto 0);
    signal BCD9  : UNSIGNED (3 downto 0);
    signal BCD10 : UNSIGNED (3 downto 0);

    SIGNAL DEBUGTEMP : UNSIGNED (7 downto 0) := "00000000";
    
begin
    
    DoubleDabble : BCDfrom32bit
        port map (
            RST     => RST,
            START   => START,
            INPUT32 => INPUT32,
            CLK     => CLK,
            DONE    => DONE,
            OUPUT1  => BCD1,
            OUPUT2  => BCD2,
            OUPUT3  => BCD3,
            OUPUT4  => BCD4,
            OUPUT5  => BCD5,
            OUPUT6  => BCD6,
            OUPUT7  => BCD7,
            OUPUT8  => BCD8,
            OUPUT9  => BCD9,
            OUPUT10 => BCD10
        );
        
    LCM1 : BCDtoASCII
        port map (
            BCD_in   => BCD1,
            ASCII_out=> OUTPUT1LCM
        );
        
    LCM2 : BCDtoASCII
        port map (
            BCD_in   => BCD2,
            ASCII_out=> OUTPUT2LCM
        );
        
    LCM3 : BCDtoASCII
        port map (
            BCD_in   => BCD3,
            ASCII_out=> OUTPUT3LCM
        );
        
    LCM4 : BCDtoASCII
        port map (
            BCD_in   => BCD4,
            ASCII_out=> OUTPUT4LCM
        );
        
    LCM5 : BCDtoASCII
        port map (
            BCD_in   => BCD5,
            ASCII_out=> OUTPUT5LCM
        );
        
    LCM6 : BCDtoASCII
        port map (
            BCD_in   => BCD6,
            ASCII_out=> OUTPUT6LCM
        );
        
    LCM7 : BCDtoASCII
        port map (
            BCD_in   => BCD7,
            ASCII_out=> OUTPUT7LCM
        );
        
    LCM8 : BCDtoASCII
        port map (
            BCD_in   => BCD8,
            ASCII_out=> OUTPUT8LCM
        );
        
    LCM9 : BCDtoASCII
        port map (
            BCD_in   => BCD9,
            ASCII_out=> OUTPUT9LCM
        );
        
    LCM10 : BCDtoASCII
        port map (
            BCD_in   => BCD10,
            ASCII_out=> OUTPUT10LCM
        );

    DEBUGTEMP (3 downto 0) <= BCD10;
    DEBUG <= DEBUGTEMP;
    
end ArsitekturLCMtoASCII;
