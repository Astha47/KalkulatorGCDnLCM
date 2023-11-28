library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCDfrom32bit is
    Port (
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
end BCDfrom32bit;

architecture Behavioral of BCDfrom32bit is
    signal INITIAL      : UNSIGNED (31 downto 0);
    signal COUNTER      : INTEGER := 0;
    signal EVALUATE     : INTEGER := 0;
    signal TEMP1        : UNSIGNED (3 downto 0);
    signal TEMP2        : UNSIGNED (3 downto 0);
    signal TEMP3        : UNSIGNED (3 downto 0);
    signal TEMP4        : UNSIGNED (3 downto 0);
    signal TEMP5        : UNSIGNED (3 downto 0);
    signal TEMP6        : UNSIGNED (3 downto 0);
    signal TEMP7        : UNSIGNED (3 downto 0);
    signal TEMP8        : UNSIGNED (3 downto 0);
    signal TEMP9        : UNSIGNED (3 downto 0);
    signal TEMP10       : UNSIGNED (3 downto 0);
    signal InternalDone : STD_LOGIC := '1';

begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                InternalDone <= '1';
                COUNTER <= 0;
                TEMP1 <= (others => '0');
                TEMP2 <= (others => '0');
                TEMP3 <= (others => '0');
                TEMP4 <= (others => '0');
                TEMP5 <= (others => '0');
                TEMP6 <= (others => '0');
                TEMP7 <= (others => '0');
                TEMP8 <= (others => '0');
                TEMP9 <= (others => '0');
                TEMP10 <= (others => '0');
            else
                if (COUNTER = 0) then
                    if START = '1' then
						COUNTER <= COUNTER + 1;
						INITIAL <= INPUT32;
						InternalDone <= '0';
					end if;
                elsif ((COUNTER >= 1) and (COUNTER <= 32)) then
                        if EVALUATE = 1 then
							
							TEMP1(3) <= TEMP1(2);
							TEMP1(2) <= TEMP1(1);
							TEMP1(1) <= TEMP1(0);
							TEMP1(0) <= TEMP2(3);
							
							TEMP2(3) <= TEMP2(2);
							TEMP2(2) <= TEMP2(1);
							TEMP2(1) <= TEMP2(0);
							TEMP2(0) <= TEMP3(3);
							
							TEMP3(3) <= TEMP3(2);
							TEMP3(2) <= TEMP3(1);
							TEMP3(1) <= TEMP3(0);
							TEMP3(0) <= TEMP4(3);
							
							TEMP4(3) <= TEMP4(2);
							TEMP4(2) <= TEMP4(1);
							TEMP4(1) <= TEMP4(0);
							TEMP4(0) <= TEMP5(3);
							
							TEMP5(3) <= TEMP5(2);
							TEMP5(2) <= TEMP5(1);
							TEMP5(1) <= TEMP5(0);
							TEMP5(0) <= TEMP6(3);
							
							TEMP6(3) <= TEMP6(2);
							TEMP6(2) <= TEMP6(1);
							TEMP6(1) <= TEMP6(0);
							TEMP6(0) <= TEMP7(3);
							TEMP7(3) <= TEMP7(2);
							TEMP7(2) <= TEMP7(1);
							TEMP7(1) <= TEMP7(0);
							TEMP7(0) <= TEMP8(3);
							TEMP8(3) <= TEMP8(2);
							TEMP8(2) <= TEMP8(1);
							TEMP8(1) <= TEMP8(0);
							TEMP8(0) <= TEMP9(3);
							TEMP9(3) <= TEMP9(2);
							TEMP9(2) <= TEMP9(1);
							TEMP9(1) <= TEMP9(0);
							TEMP9(0) <= TEMP10(3);
							TEMP10(3) <= TEMP10(2);
							TEMP10(2) <= TEMP10(1);
							TEMP10(1) <= TEMP10(0);
							TEMP10(0) <= INITIAL(31);
							INITIAL(31) <= INITIAL(30);
							INITIAL(30) <= INITIAL(29);
							INITIAL(29) <= INITIAL(28);
							INITIAL(28) <= INITIAL(27);
							INITIAL(27) <= INITIAL(26);
							INITIAL(26) <= INITIAL(25);
							INITIAL(25) <= INITIAL(24);
							INITIAL(24) <= INITIAL(23);
							INITIAL(23) <= INITIAL(22);
							INITIAL(22) <= INITIAL(21);
							INITIAL(21) <= INITIAL(20);
							INITIAL(20) <= INITIAL(19);
							INITIAL(19) <= INITIAL(18);
							INITIAL(18) <= INITIAL(17);
							INITIAL(17) <= INITIAL(16);
							INITIAL(16) <= INITIAL(15);
							INITIAL(15) <= INITIAL(14);
							INITIAL(14) <= INITIAL(13);
							INITIAL(13) <= INITIAL(12);
							INITIAL(12) <= INITIAL(11);
							INITIAL(11) <= INITIAL(10);
							INITIAL(10) <= INITIAL(9);
							INITIAL(9) <= INITIAL(8);
							INITIAL(8) <= INITIAL(7);
							INITIAL(7) <= INITIAL(6);
							INITIAL(6) <= INITIAL(5);
							INITIAL(5) <= INITIAL(4);
							INITIAL(4) <= INITIAL(3);
							INITIAL(3) <= INITIAL(2);
							INITIAL(2) <= INITIAL(1);
							INITIAL(1) <= INITIAL(0);
							INITIAL(0) <= '0';
							
							COUNTER <= COUNTER + 1;
							EVALUATE <= 0;
						else
							if (TEMP10 > 4) then
								TEMP10 <= TEMP10 + 3;
							end if;
							
							if (TEMP9 > 4) then
								TEMP9 <= TEMP9 + 3;
							end if;
							
							if (TEMP8 > 4) then
								TEMP8 <= TEMP8 + 3;
							end if;
							
							if (TEMP7 > 4) then
								TEMP7 <= TEMP7 + 3;
							end if;
							
							if (TEMP6 > 4) then
								TEMP6 <= TEMP6 + 3;
							end if;
							
							if (TEMP5 > 4) then
								TEMP5 <= TEMP5 + 3;
							end if;
							
							if (TEMP4 > 4) then
								TEMP4 <= TEMP4 + 3;
							end if;
							
							if (TEMP3 > 4) then
								TEMP3 <= TEMP3 + 3;
							end if;
							
							if (TEMP2 > 4) then
								TEMP2 <= TEMP2 + 3;
							end if;
							
							if (TEMP1 > 4) then
								TEMP1 <= TEMP1 + 3;
							end if;
					
							EVALUATE <= 1;
						end if;
                else
                    COUNTER <= 0;
                    InternalDone <= '1';
                end if;
            end if;
        end if;
    end process;

    DONE <= InternalDone;

    -- Output ports
	OUPUT1  <= TEMP1;
	OUPUT2  <= TEMP2;
	OUPUT3  <= TEMP3;
	OUPUT4  <= TEMP4;
	OUPUT5  <= TEMP5;
	OUPUT6  <= TEMP6;
	OUPUT7  <= TEMP7;
	OUPUT8  <= TEMP8;
	OUPUT9  <= TEMP9;
	OUPUT10 <= TEMP10;


end Behavioral;
