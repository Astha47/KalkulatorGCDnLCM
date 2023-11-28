library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_controller is
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
end entity fsm_controller;

architecture fsm_arc of fsm_controller is
	type states is ( A, B, C, D, E, F, G, H, I, J );
	signal nState, cState: states;
begin
	process( CLK, MODE )
	begin
	if( MODE = '0' ) then
		cState <= A;
	elsif( clk'event and clk = '1' ) then
		cState <= nState;
	end if;
	end process;
	
	process( cState, START, JUMLAH, DONE_A, DONE_B, DONE_C )
	begin
	case cState is
	
	when A =>
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '1';
		
		if( START = '1' ) then
			nState <= B;
		else
			nState <= A;
		end if;
		
	when B => 
		START_A <= '1';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( DONE_A = '0' ) then
			nState <= C;
		else
			nState <= B;
		end if;
	when C => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( (DONE_A = '1') and (JUMLAH = "01") ) then
			nState <= D;
		elsif ((DONE_A = '1') and ((JUMLAH = "10") or (JUMLAH = "11"))) then
			nState <= E;
		else
			nState <= C;
		end if;	
	when D => 
		START_A <= '1';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '1';
		
		if( START = '1' ) then
			nState <= B;
		else
			nState <= D;
		end if;
	when E => 
		START_A <= '0';
		START_B <= '1';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( DONE_B = '0' ) then
			nState <= F;
		else
			nState <= E;
		end if;
	when F => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( (DONE_B = '1') and (JUMLAH = "10") ) then
			nState <= G;
		elsif ((DONE_B = '1') and (JUMLAH = "11")) then
			nState <= H;
		else
			nState <= F;
		end if;	
	when G => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '1';
		OUT_C <= '0';
		DONE <= '1';
		
		if( START = '1' ) then
			nState <= B;
		else
			nState <= G;
		end if;
	when H => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '1';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( DONE_C = '0' ) then
			nState <= I;
		else
			nState <= H;
		end if;
	when I => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '0';
		DONE <= '0';
		
		if( DONE_C = '1' ) then
			nState <= J;
		else
			nState <= I;
		end if;
	when J => 
		START_A <= '0';
		START_B <= '0';
		START_C <= '0';
		OUT_A <= '0';
		OUT_B <= '0';
		OUT_C <= '1';
		DONE <= '1';
		
		if( START = '1' ) then
			nState <= B;
		else
			nState <= J;
		end if;
	when others => nState <= A;
	end case;
	end process;
end fsm_arc;