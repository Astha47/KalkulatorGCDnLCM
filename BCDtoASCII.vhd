library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCDtoASCII is
    Port ( BCD_in : in  UNSIGNED (3 downto 0);
           ASCII_out : out  UNSIGNED (7 downto 0));
end BCDtoASCII;

architecture Behavioral of BCDtoASCII is
begin
    process(BCD_in)
    begin
        case BCD_in is
            when "0000" => ASCII_out <= "00110000"; -- 0
            when "0001" => ASCII_out <= "00110001"; -- 1
            when "0010" => ASCII_out <= "00110010"; -- 2
            when "0011" => ASCII_out <= "00110011"; -- 3
            when "0100" => ASCII_out <= "00110100"; -- 4
            when "0101" => ASCII_out <= "00110101"; -- 5
            when "0110" => ASCII_out <= "00110110"; -- 6
            when "0111" => ASCII_out <= "00110111"; -- 7
            when "1000" => ASCII_out <= "00111000"; -- 8
            when "1001" => ASCII_out <= "00111001"; -- 9
            when others => ASCII_out <= "00111111"; -- Invalid
        end case;
    end process;
end Behavioral;
