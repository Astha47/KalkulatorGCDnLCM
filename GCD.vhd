library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gcd is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           INPUT_NUM1 : in unsigned(7 downto 0);
           INPUT_NUM2 : in unsigned(7 downto 0);
           done : out STD_LOGIC;
           gcd : out unsigned(7 downto 0));
end gcd;

architecture Behavioral of gcd is
    signal temp_a, temp_b : unsigned(7 downto 0);
    signal busy : STD_LOGIC;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' and busy = '0' then
                temp_a <= INPUT_NUM1;
                temp_b <= INPUT_NUM2;
                busy <= '1';
                done <= '0';
            elsif busy = '1' then
                if temp_a > temp_b then
                    temp_a <= temp_a - temp_b;
                elsif temp_a < temp_b then
                    temp_b <= temp_b - temp_a;
                else
                    busy <= '0';
                    gcd <= temp_a;
                    done <= '1';
                end if;
            end if;
        end if;
    end process;
    
end Behavioral;
