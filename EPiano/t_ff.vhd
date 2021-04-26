----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2021 05:33:14 PM
-- Design Name: 
-- Module Name: t_ff - Behavioral
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

entity t_ff is
    Port ( 
            rst, clk, tick, mute : in STD_LOGIC;
            output : out STD_LOGIC
);
end t_ff;

    architecture Behavioral of t_ff is

   signal r_reg, r_nxt: std_logic;
begin

   -- T FF
   process(clk,rst)
   begin
      if (rst='1') then
         r_reg <='0';
      elsif rising_edge(clk) then
         r_reg <= r_nxt;
      end if;
   end process;
	
   -- next-state logic
	process(r_reg, mute, tick)
   begin
	if (mute = '1') then
		r_nxt <= '0';
	elsif (tick = '1') then
		r_nxt <= not(r_reg);
	else
		r_nxt <= r_reg;
	end if;
	end process;

   -- output logic
   output <= r_reg;
	
end Behavioral;
