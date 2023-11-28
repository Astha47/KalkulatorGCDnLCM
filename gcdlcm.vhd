library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity gcdlcm is
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
end gcdlcm;

architecture gcdlcm_arc of gcdlcm is

component lcmfsm is
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
end component;

component gcdfsm is
	port(
	clk  : in std_logic;
	start: in std_logic;
	mode : in std_logic;
	jumlah : in std_logic_vector(1 downto 0) ;
	INPUT_NUM1 , INPUT_NUM2 , INPUT_NUM3 , INPUT_NUM4: in unsigned(7 downto 0);
    done   : out std_logic;
    output : out unsigned(7 downto 0)
	);
end component;

signal done_1 : std_logic ;
signal done_2 : std_logic ; 
begin
COUNTLCM : lcmfsm port map (clk , start ,mode(1),jumlah , INPUT_NUM1 , INPUT_NUM2 , INPUT_NUM3 , INPUT_NUM4 , done_1 ,OUTPUT_LCM);
COUNTGCD : gcdfsm port map (clk , start , mode(0) ,jumlah , INPUT_NUM1 , INPUT_NUM2 , INPUT_NUM3 , INPUT_NUM4 , done_2 ,OUTPUT_GCD );
done <= done_1 and done_2;
end gcdlcm_arc;