library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LCM is
    Port (
        clk : in STD_LOGIC;
        start : in STD_LOGIC;
        INPUT_NUM1 : in unsigned(31 downto 0);
        INPUT_NUM2 : in unsigned(31 downto 0);
        done : out STD_LOGIC;
        lcm : out unsigned(31 downto 0)
    );
end LCM;

architecture Behavioral of LCM is
    signal temp1, temp2 : unsigned(31 downto 0);
    signal running : STD_LOGIC;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' then
                temp1 <= INPUT_NUM1;
                temp2 <= INPUT_NUM2;
                running <= '1';
            elsif running = '1' then
                if temp1 < temp2 then
                    temp1 <= temp1 + INPUT_NUM1;
                elsif temp1 > temp2 then
                    temp2 <= temp2 + INPUT_NUM2;
                else
                    lcm <= temp1;
                    running <= '0';
                end if;
            end if;
        end if;
    end process;
    done <= not running;
end Behavioral;
