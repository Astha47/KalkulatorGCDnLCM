library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity lcmfsm is
    port(
        clk       : in std_logic;
        start     : in std_logic;
        mode      : in std_logic;
        jumlah    : in std_logic_vector(1 downto 0);
        INPUT_NUM1: in unsigned(7 downto 0);
        INPUT_NUM2: in unsigned(7 downto 0);
        INPUT_NUM3: in unsigned(7 downto 0);
        INPUT_NUM4: in unsigned(7 downto 0);
        done      : out std_logic;
        output    : out unsigned(31 downto 0)
    );
end lcmfsm;

architecture behavioral of lcmfsm is
 component LCM is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           INPUT_NUM1 : in unsigned(31 downto 0);
           INPUT_NUM2 : in unsigned(31 downto 0);
           done : out std_logic;
           lcm : out unsigned(31 downto 0));
 end component;
 
 component converter32 is
    Port ( input_8bit : in unsigned(7 downto 0);
           output_32bit : out unsigned (31 downto 0));
 end component ;

 component fsm_controller is
 port (
    CLK : in std_logic;
    MODE : in std_logic;
    START : in std_logic;
    JUMLAH : in std_logic_vector(1 downto 0);
    DONE_A : in std_logic;
    DONE_B : in std_logic;
    DONE_C : in std_logic;
    START_A : out std_logic;
    START_B : out std_logic;
    START_C : out std_logic;
    OUT_A : out std_logic;
    OUT_B : out std_logic;
    OUT_C : out std_logic;
    DONE : out std_logic
 );
 
 end component;
 ---
 signal truelcm1, truelcm2 , truelcm3 : unsigned(31 downto 0);
 signal done1, done2 , done3 : std_logic;
--- SIGNAL INPUT NEW
signal INPUT_NUM1_NEW : unsigned (31 downto 0);
signal INPUT_NUM2_NEW : unsigned (31 downto 0);
signal INPUT_NUM3_NEW : unsigned (31 downto 0);
signal INPUT_NUM4_NEW : unsigned (31 downto 0);

----
----
 --- FSM SIGNAL
 signal start_a : std_logic;
 signal start_b : std_logic;
 signal start_c : std_logic;
 signal done_a  : std_logic;
 signal done_b  : std_logic;
 signal done_c  : std_logic;
 signal out_a   : std_logic;
 signal out_b   : std_logic;
 signal out_c   : std_logic;
 
begin
--- Upscale 8 to 32---
	CONVERT1 : converter32 port map ( INPUT_NUM1, INPUT_NUM1_NEW);
	CONVERT2 : converter32 port map ( INPUT_NUM2, INPUT_NUM2_NEW);
	CONVERT3 : converter32 port map ( INPUT_NUM3, INPUT_NUM3_NEW);	
	CONVERT4 : converter32 port map ( INPUT_NUM4, INPUT_NUM4_NEW);	
	
    LCM1: LCM port map(clk , start_a , INPUT_NUM1_NEW , INPUT_NUM2_NEW, done_a , truelcm1);
    LCM2: LCM port map(clk , start_b , INPUT_NUM3_NEW , truelcm1, done_b , truelcm2);
	LCM3: LCM port map(clk , start_c , INPUT_NUM4_NEW , truelcm2, done_c , truelcm3);
	FSM : fsm_controller port map(clk , mode, start , jumlah , done_a , done_b , done_c , 
	start_a , start_b , start_c , out_a , out_b , out_c , done);
    process(clk)
    begin
        if rising_edge(clk) then
            if (jumlah = "01")  then
                output <= truelcm1;
                
            elsif (jumlah = "10") then
                 
                output <= truelcm2;
       
            elsif (jumlah = "11") then
                output <= truelcm3;
                
            end if;
        end if;
    end process;
end behavioral;
