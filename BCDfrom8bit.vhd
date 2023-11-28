library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCDfrom8bit is
    Port (
        RST     : in  STD_LOGIC;
        START   : in  STD_LOGIC;
        INPUT8 : in  UNSIGNED (7 downto 0);
        CLK     : in  STD_LOGIC;
        DONE    : out STD_LOGIC;
        OUPUT1  : out UNSIGNED (3 downto 0);
        OUPUT2  : out UNSIGNED (3 downto 0);
        OUPUT3  : out UNSIGNED (3 downto 0)
    );
end BCDfrom8bit;

architecture Behavioral of BCDfrom8bit is
    signal INITIAL      : UNSIGNED (7 downto 0);
    signal COUNTER      : INTEGER := 0;
    signal EVALUATE     : INTEGER := 0;
    signal TEMP1        : UNSIGNED (3 downto 0);
    signal TEMP2        : UNSIGNED (3 downto 0);
    signal TEMP3        : UNSIGNED (3 downto 0);
    
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
                
            else
                if (COUNTER = 0) then
                    if START = '1' then
						COUNTER <= COUNTER + 1;
						INITIAL <= INPUT8;
						InternalDone <= '0';
					end if;
                elsif ((COUNTER >= 1) and (COUNTER <= 8)) then
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
							TEMP3(0) <= INITIAL(7);
													
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


end Behavioral;
