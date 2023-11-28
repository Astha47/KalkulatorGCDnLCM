library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity gcdfsm is
	port(
	clk  : in std_logic;
	start: in std_logic;
	mode : in std_logic;
	jumlah : in std_logic_vector(1 downto 0) ;
	INPUT_NUM1 , INPUT_NUM2 , INPUT_NUM3 , INPUT_NUM4: in unsigned(7 downto 0);
    done   : out std_logic;
    output : out unsigned(7 downto 0)
	);
end gcdfsm;

architecture behavioral of gcdfsm is
	component gcd is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           INPUT_NUM1 : in unsigned(7 downto 0);
           INPUT_NUM2 : in unsigned(7 downto 0);
           done : out std_logic;
           gcd : out unsigned(7 downto 0));
	end component;
	
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
	signal truegcd1, truegcd2 , truegcd3 : unsigned(7 downto 0);
	signal done1, done2 , done3 : std_logic;
	---
	--- Signal for FSM
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
    GCD1: gcd port map(clk , start_a , INPUT_NUM1 , INPUT_NUM2, done_a , truegcd1);
    GCD2: gcd port map(clk , start_b , INPUT_NUM3 , truegcd1, done_b , truegcd2);
	GCD3: gcd port map(clk , start_c , INPUT_NUM4 , truegcd2, done_c , truegcd3);
	FSM : fsm_controller port map(clk , mode, start , jumlah , done_a , done_b , done_c , 
	start_a , start_b , start_c , out_a , out_b , out_c , done);
    process(clk)
    begin
        if rising_edge(clk) then
            if (jumlah = "01")  then
                output <= truegcd1;
                
            elsif (jumlah = "10") then
                 
                output <= truegcd2;
       
            elsif (jumlah = "11") then
                output <= truegcd3;
                
            end if;
        end if;
    end process;
end behavioral;