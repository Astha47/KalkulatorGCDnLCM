-- library
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- entity
entity KalkulatorGCDnLCM is
	port(
		CLK 			: in std_logic;
		RST			    : in std_logic;
        -- Debugging PORT
        READY           : out std_logic;
        PROCESSING      : out std_logic;
        DONEPROCESS     : out std_logic;
        CONVERTING      : out std_logic;
        
        -- serial part
		rs232_rx 		: in std_logic;
		rs232_tx 		: out std_logic
	
	);
End entity;

Architecture GCDnLCM of KalkulatorGCDnLCM is

    component IO is
        port(
            clk 				: in std_logic;
            rst_n 			    : in std_logic;
            BILANGAN1			: OUT unsigned (7 downto 0);
            BILANGAN2			: OUT unsigned (7 downto 0);
            BILANGAN3			: OUT unsigned (7 downto 0);
            BILANGAN4			: OUT unsigned (7 downto 0);
            MODE				: OUT std_logic_vector(1 downto 0);
            START_PROCESS	    : OUT std_logic; 
            DONE_PROCESS	    : IN std_logic; 
            RESULT_GCD 			: IN unsigned(7 downto 0);
            RESULT_LCM 			: IN unsigned(31 downto 0);
            JUMLAH				: OUT std_logic_vector(1 downto 0);
    
            -- RECEIVER CONNECTION DEBUGGING PORT
            READY	    		: OUT std_logic; 
		    PROCESSING	    	: OUT std_logic;
            CONVERTING	    	: OUT std_logic;

            COUNTERP            : out INTEGER;
            WAITINGP            : out INTEGER;
            RECEIVE_DEBUG		: OUT std_logic;
            RECEIVE_ERROR		: OUT std_logic;
            HASIL_BACAAN 		: OUT std_logic_vector (7 downto 0);
            RECEIVE_FEEDBACK	: OUT std_logic;
            
            -- serial part
            rs232_rx 		    : in std_logic;
            rs232_tx 		    : out std_logic
        );
    End component;

    component gcdlcm is
        port(
            -- Input
            jumlah : in std_logic_vector(1 downto 0);
            INPUT_NUM1: in unsigned(7 downto 0);
            INPUT_NUM2: in unsigned(7 downto 0);
            INPUT_NUM3: in unsigned(7 downto 0);
            INPUT_NUM4: in unsigned(7 downto 0);
            clk       : in std_logic ; 
            mode      : in std_logic_vector(1 downto 0);
            start     : in std_logic; 
            
            -- Output
            
            done           : out std_logic;
            OUTPUT_GCD : out unsigned(7 downto 0);
            OUTPUT_LCM : out unsigned(31 downto 0)
        );
    end component;

    SIGNAL BILANGAN1 : unsigned (7 downto 0);
    SIGNAL BILANGAN2 : unsigned (7 downto 0);
    SIGNAL BILANGAN3 : unsigned (7 downto 0);
    SIGNAL BILANGAN4 : unsigned (7 downto 0);
    SIGNAL MODE : std_logic_vector(1 downto 0);
    SIGNAL START_PROCESS : std_logic;
    SIGNAL DONE_PROCESS : std_logic;
    SIGNAL RESULT_GCD : unsigned (7 downto 0);
    SIGNAL RESULT_LCM : unsigned (31 downto 0);
    SIGNAL JUMLAH : std_logic_vector(1 downto 0);

    begin

        IO_COMPONENT: IO 
        port map (
            clk 				=> CLK,
            rst_n 			    => RST,
            BILANGAN1			=> BILANGAN1,
            BILANGAN2			=> BILANGAN2,
            BILANGAN3			=> BILANGAN3,
            BILANGAN4			=> BILANGAN4,
            MODE				=> MODE,
            START_PROCESS	    => START_PROCESS,
            DONE_PROCESS	    => DONE_PROCESS,
            RESULT_GCD 			=> RESULT_GCD,
            RESULT_LCM 			=> RESULT_LCM,
            JUMLAH				=> JUMLAH,

            READY	    		=> READY,
		    PROCESSING	    	=> PROCESSING,
            CONVERTING          => CONVERTING,
            
            -- serial part
            rs232_rx 		    => rs232_rx,
            rs232_tx 		    => rs232_tx 
        );
    
        PROCESS_COMPONENT : gcdlcm 
        port map (
            -- Input
            jumlah      => JUMLAH,
            INPUT_NUM1  => BILANGAN1,
            INPUT_NUM2  => BILANGAN2,
            INPUT_NUM3  => BILANGAN3,
            INPUT_NUM4  => BILANGAN4,
            clk         => CLK,
            mode        => MODE,
            start       => START_PROCESS,
            
            -- Output
            
            done        => DONE_PROCESS,
            OUTPUT_GCD  => RESULT_GCD,
            OUTPUT_LCM  => RESULT_LCM
        );

    DONEPROCESS <= NOT DONE_PROCESS;


end architecture;