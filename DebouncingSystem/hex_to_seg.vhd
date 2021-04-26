----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2020 12:17:05 PM
-- Design Name: 
-- Module Name: hex_to_seg - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hex_to_seg is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end hex_to_seg;

architecture Behavioral of hex_to_seg is

begin
an <= "0111";   ---use all for seg, 0 means turn on for this circuit
seg(7) <= '1';  ---dp is turned off, because 1 means off for this circuit
    process(hex)
        begin
            case hex is
                when "0000" => --0
                seg(6 downto 0) <= "1000000";
                when "0001" =>   --1
                seg(6 downto 0) <= "1111001";
                when "0010" =>   --2
                seg(6 downto 0) <= "0100100";
                when "0011" =>   --3 
                seg(6 downto 0) <= "0110000";
                when "0100" =>   --4
                seg(6 downto 0) <= "0011001";
                when "0101" =>   --5
                seg(6 downto 0) <= "0010010";
                when "0110" =>   --6
                seg(6 downto 0) <= "0000010";
                when "0111" =>   --7
                seg(6 downto 0) <= "1111000";
                when "1000" =>   --8
                seg(6 downto 0) <= "0000000";
                when "1001" =>   --9
                seg(6 downto 0) <= "0010000";
                when "1010" =>   --10 | A
                seg(6 downto 0) <= "0001000";
                when "1011" =>   --11 | B
                seg(6 downto 0) <= "0000011";
                when "1100" =>   --12 | C
                seg(6 downto 0) <= "1000110";
                when "1101" =>   --13 | D
                seg(6 downto 0) <= "0100001";
                when "1110" =>   --14 | E
                seg(6 downto 0) <= "0000110";
                when "1111" =>   --15 | F 
                seg(6 downto 0) <= "0001110";                              
            end case;
        end process;
end Behavioral;
