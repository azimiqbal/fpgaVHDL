----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2020 11:26:23 AM
-- Design Name: 
-- Module Name: mod_m_counter_en - Behavioral
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

entity mod_m_counter_en is
    generic(N : integer := 4;
            M : integer := 10);
    Port ( reset      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           en       : in STD_LOGIC;
           q        : out STD_LOGIC_VECTOR (N-1 downto 0);
           max_tick : out STD_LOGIC);
end mod_m_counter_en;

architecture Behavioral of mod_m_counter_en is
------------internal memory--------
signal r_reg, r_next : unsigned(N-1 downto 0);    --unsgined not std_logic because
begin

    process(reset, clk)
        begin
---------------------sequential part----------
            if(reset = '1') then
                r_reg <= (others =>'0');
            elsif (rising_edge(clk)) then      --(clk'event and clk = '1'), event means if anything changes in clock signal we set clk to 1, raising edge
                 if(en = '1') then
                r_reg <= r_next;
              end if; --en  
            end if; --rst
        end process;
--------------------next sate logic-----------
-------input: r_reg
-------output: r_next
      r_next <= (others => '0') when r_reg = M-1 else  --the counter value should be reset if it breaks the maximum value m-1, else it goes up by one value
                r_reg +1;
--------------------output logic---------------
--------r_reg and external inout signal

    q <= std_logic_vector(r_reg);   --important here to have r_reg and not r_next in order to have synchronous design
    max_tick <= '1' when r_reg = M-1 else
            '0';
end Behavioral;