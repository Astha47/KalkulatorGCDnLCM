library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity converter32 is
    Port ( input_8bit : in unsigned(7 downto 0);
           output_32bit : out unsigned (31 downto 0));
end converter32;

architecture Behavioral of converter32 is
begin
    output_32bit <= "000000000000000000000000" & input_8bit;
end Behavioral;
