----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2021 10:16:22 PM
-- Design Name: 
-- Module Name: code_converter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity code_converter is
    Port ( 
            mem_data : in STD_LOGIC_VECTOR(7 downto 0);
            note_in : out STD_LOGIC_VECTOR(17 downto 0)
    );
end code_converter;

architecture Behavioral of code_converter is

begin
    process (mem_data)
    begin   
        case mem_data is
            when "01110001" => note_in <= "101110101010001001"; 
            when "01110111" => note_in <= "101001100100010110"; 
            when "01100101" => note_in <= "100101000010000110";
            when "01110010" => note_in <= "100010111101000101";
            when "01110100" => note_in <= "011111001001000001";
            when "01111001" => note_in <= "011011101111100100";
            when "01110101" => note_in <= "011000101101110111";
            
            when "01100001" => note_in <= "010111010101000100";
            when "01110011" => note_in <= "010100110010001011";
            when "01100100" => note_in <= "010010100001000011";
            when "01100110" => note_in <= "010001011110100010";
            when "01100111" => note_in <= "001111100100100000";
            when "01101000" => note_in <= "001101110111110010";
            when "01101010" => note_in <= "001100010110111011";
            when others => note_in <=     "000000000000000001";
        end case;
    end process;
end Behavioral;
