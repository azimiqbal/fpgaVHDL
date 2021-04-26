----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 04:19:03 PM
-- Design Name: 
-- Module Name: debouncing_circuit - Behavioral
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

entity debouncing_circuit is
    port(clk : in std_logic;
         reset : in std_logic;
         btn : in std_logic;
         output : out std_logic
        );
end debouncing_circuit;
architecture behavioral of debouncing_circuit is

constant max_counter : integer := 20; --this variable decides how long i hold the button in for
constant btn_active : std_logic := '1';

signal count : integer := 0;
type state_type is (idle,wait_time); --the two states
signal state : state_type := idle;

begin
process(reset, clk)
begin
    if(reset = '1') then
        state <= idle;
        output <= '0';
   elsif(rising_edge(clk)) then
        case (state) is
            when idle =>
                if(btn = btn_active) then  
                    state <= wait_time;
                else
                    state <= idle; --wait until button is pressed.
                end if;
                output <= '0';
            when wait_time =>
                if(count = max_counter) then
                    count <= 0;
                    if(btn = btn_active) then
                        output <= '1';
                    end if;
                    state <= idle;  
                else
                    count <= count + 1;
                end if; 
        end case;       
    end if;        
end process;                                                         
end architecture behavioral;