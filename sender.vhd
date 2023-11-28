library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity sender is
	port(
	-- input
	GCD_1 : in std_logic_vector(7 downto 0);
	GCD_2 : in std_logic_vector(7 downto 0);
	GCD_3 : in std_logic_vector(7 downto 0);
	LCM_1 : in std_logic_vector(7 downto 0);
	LCM_2 : in std_logic_vector(7 downto 0);
	LCM_3 : in std_logic_vector(7 downto 0);
	LCM_4 : in std_logic_vector(7 downto 0);
	LCM_5 : in std_logic_vector(7 downto 0);
	LCM_6 : in std_logic_vector(7 downto 0);
	LCM_7 : in std_logic_vector(7 downto 0);
	LCM_8 : in std_logic_vector(7 downto 0);
	LCM_9 : in std_logic_vector(7 downto 0);
	LCM_10 : in std_logic_vector(7 downto 0);
	start_send : in std_logic;
	clk : in std_logic;
	tx_en : in std_logic;
    -- output
    s_out: out std_logic_vector(3 downto 0);
    send : out std_logic;
    data_send : out std_logic_vector(7 downto 0)
	);
End entity;

architecture sender_arc of sender is
	type states is (s0, s1 , s2 , s3 , s4 , s5 , s6 , s7 ,
	s8 , s9 , s10 , s11 , s12, s13 , s14 , s15 , s16 , s17 ,
	s18 , s19 , s20 , s21 , s22 , s23 , s24 , s25 , s26 , s27 , s28);
	signal currentstate , nextstate : states;
	signal busy : std_logic;
	signal send_data : std_logic_vector(7 downto 0);
	signal s : std_logic_vector(3 downto 0);
begin
	-- process to update state
	process
	begin
	wait until(clk'event) and (clk = '1');
		if tx_en = '0' then
			currentstate<=nextstate;
			
		else
			currentstate<=currentstate;
		end if;
	end process;
	
	
	-- FSM PROCESS
	process
	begin
	wait until (clk'event) and (clk = '1');
					if s="0001" then
				send_data<=GCD_1;
			elsif s="0010" then
				send_data<=GCD_2;
			elsif s="0011" then
			send_data<=GCD_3;
			elsif s="0100" then
			send_data<="00100000" ; 
			elsif s="0101" then
			send_data<=LCM_1;
			elsif s="0110" then
			send_data<=LCM_2;
			elsif s="0111" then
			send_data<=LCM_3;
			elsif s="1000" then
			send_data<=LCM_4;
			elsif s="1001" then
			send_data<=LCM_5;
			elsif s="1010" then
			send_data<=LCM_6;
			elsif s="1011" then
			send_data<=LCM_7;
			elsif s="1100" then
			send_data<=LCM_8;
			elsif s="1101" then
			send_data<=LCM_9;
			elsif s="1110" then
			send_data<=LCM_10;			
			end if;
	
	case currentstate is 
		when s0=>
			send<='0';
			if start_send ='1' then
				nextstate<=s1;
			else
				nextstate<=s0;
			end if;
		when s1=>
			s<="0001";		
			send<='1';
			if GCD_1="00110000" then
				nextstate<=s3;
			else
				nextstate<=s2;
			end if;
		when s2=>
			s<="0001";	
			send<='0';
			nextstate<=s3;
			
		when s3=>
			s<="0010";
			
			send<='1';
			if GCD_1="00110000" and GCD_2="00110000" then
				nextstate<=s5;
			else
				nextstate<=s4;
			end if;
		when s4=>
			s<="0010";
			send<='0';
			nextstate<=s5;
			
		when s5=>  -- setting last gcd number
			s<="0011";
			
			send<='1';
			nextstate<=s6;
		when s6=>  -- sending last gcd number
		s<="0011";
			send<='0';
			nextstate<=s7;
			
		when s7=>  -- setting spasi
			s<="0100";
		   
			send<='1';
			nextstate<=s8;
		when s8=>  -- send spasi
		   s<="0100";
		
			send<='0';
			nextstate<=s9;
			
		when s9=>
			s<="0101";

			send<='1';
			if LCM_1="00110000"  then
				nextstate<=s11;
			else
				nextstate<=s10;
			end if;
		when s10=>
			s<="0101";
			send<='0';
			nextstate<=s11;
			
		when s11=>
			s<="0110";

			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" then
				nextstate<=s13;
			else
				nextstate<=s12;
			end if;
		when s12=>
			s<="0110";
			send<='0';
			nextstate<=s13;
			
		when s13=>
			s<="0111";
			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000"  then
				nextstate<=s15;
			else
				nextstate<=s14;
			end if;
		when s14=>
			s<="0111";
			send<='0';
			nextstate<=s15;
			
		when s15=>
			s<="1000";

			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000"  then
				nextstate<=s17;
			else
				nextstate<=s16;
			end if;
		when s16=>
			s<="1000";
			send<='0';
			nextstate<=s17;
			
		when s17=>
			s<="1001";

			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000" and LCM_5="00110000"  then
				nextstate<=s19;
			else
				nextstate<=s18;
			end if;
		when s18=>
			s<="1001";
			send<='0';
			nextstate<=s19;
			
		when s19=>
			s<="1010";
	
			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000" and LCM_5="00110000" and LCM_6="00110000" then
				nextstate<=s21;
			else
				nextstate<=s20;
			end if;
		when s20=>
			s<="1010";
			send<='0';
			nextstate<=s21;
			
		when s21=>
			s<="1011";
	
			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000" and LCM_5="00110000" and LCM_6="00110000" AND LCM_7="00110000"  then
				nextstate<=s23;
			else
				nextstate<=s22;
			end if;
		when s22=>
			s<="1011";
			send<='0';
			nextstate<=s23;
			
		when s23=>
			s<="1100";
	
			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000" and LCM_5="00110000" and LCM_6="00110000" AND LCM_7="00110000" AND LCM_8="00110000"  then
				nextstate<=s25;
			else
				nextstate<=s24;
			end if;
		when s24=>
			s<="1100";
			send<='0';
			nextstate<=s25;
		
		when s25=>
			s<="1101";
		
			send<='1';
			if LCM_1="00110000" and LCM_2="00110000" and LCM_3="00110000" and LCM_4="00110000" and LCM_5="00110000" and LCM_6="00110000" AND LCM_7="00110000" AND LCM_8="00110000" AND LCM_9="00110000"  then
				nextstate<=s27;
			else
				nextstate<=s26;
			end if;
		when s26=>
			s<="1101";
			send<='0';
			nextstate<=s27;
			
		when s27=> -- setting last number of lcm
			s<="1110";
			
			send<='1';
			nextstate<=s28;
		when s28=> -- sending last number of lcm
			s<="1110";
			send<='0';
			nextstate<=s0;
		
		
	end case;

	end process;
	data_send<=send_data;
	s_out<=s;
end sender_arc;