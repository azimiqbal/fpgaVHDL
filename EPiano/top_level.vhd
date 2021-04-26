----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2021 06:17:51 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port (
            clk : in STD_LOGIC;    
            rst : in STD_LOGIC;
            output : out STD_LOGIC;
            play : in STD_LOGIC;
            rx : in STD_LOGIC
     );
end top_level;

architecture Behavioral of top_level is

signal clear, incr, write_enable, timer_on, mute: STD_LOGIC;
signal rx_done_tick, timer_done : STD_LOGIC;
signal address : STD_LOGIC_VECTOR(9 downto 0);
signal uart_data : STD_LOGIC_VECTOR(7 downto 0);
signal ram_data : STD_LOGIC_VECTOR(7 downto 0);
signal s_tick : STD_LOGIC;
signal tick : STD_LOGIC;
signal notes_to_ff : STD_LOGIC_VECTOR(17 downto 0);

begin

    
	-- instantiate mod-m counter (baud rate generator for UART)
    baud_rate_generator: entity work.mod_m_counter(arch)
    port map(clk => clk, rst => rst, max_tick => s_tick);
    
	address_counter_unit: entity work.univ_bin_counter(arch)
		port map(clk => clk, rst => rst, clear => clear, incr => incr,
					address => address, up => '1');

	uart_receiver_unit: entity work.uart_rx(arch)
		port map(clk => clk, rst => rst, rx => rx, s_tick => s_tick,
					rx_done_tick => rx_done_tick, dout => uart_data);   
    
    memory_unit_ram: entity work.ram(Behavioral)
        port map(clk => clk, write_enable => write_enable, din => uart_data, addr => address, dout => ram_data);
        
    converter_unit: entity work.code_converter(Behavioral)
        port map(mem_data => ram_data, note_in => notes_to_ff);

	mod_m_down_counter_to_ff: entity work.uni_mod_down_counter(arch)
		port map(clk => clk, rst => rst, note_in => notes_to_ff, min_tick => tick);  
         
    t_ff_unit: entity work.t_ff(Behavioral)
        port map(rst => rst, clk => clk, tick => tick, mute => mute, output => output);
        
    control_path_unit: entity work.control_path(Behavioral)
        port map(rst => rst, clk => clk, rx_done_tick => rx_done_tick, mute => mute, clear => clear, incr => incr, write_enable => write_enable,
        timer_on => timer_on, timer_done => timer_done, play => play, uart_data => uart_data, ram_data => ram_data, address => address);
    
    timer_unit: entity work.timer(arch)
        port map(rst => rst, clk => clk, timer_on => timer_on, timer_done => timer_done);
    
end Behavioral;
