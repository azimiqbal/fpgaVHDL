----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2020 11:51:29 AM
-- Design Name: 
-- Module Name: mod_16_test_block - Behavioral
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
--use UNISIM.VComponents.all

entity mod_16_test_block is
    Port ( reset  : in STD_LOGIC;
           button : in STD_LOGIC;
           clk  : in STD_LOGIC;
           seg  : out STD_LOGIC_VECTOR (7 downto 0);
           an   : out STD_LOGIC_VECTOR (3 downto 0));
end mod_16_test_block;
architecture Behavioral of mod_16_test_block is

component debouncing_circuit is
    port(clk : in std_logic;
         reset : in std_logic;
         btn : in std_logic;
         output : out std_logic
        );
end component;

component edge_detector is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           level : in STD_LOGIC;
           tick : out STD_LOGIC);
end component;

component mod_m_counter_en is
    generic(N : integer := 4;
            M : integer := 10);
    Port ( reset      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           en       : in STD_LOGIC;
           q        : out STD_LOGIC_VECTOR (N-1 downto 0);
           max_tick : out STD_LOGIC);
end component;

component hex_to_seg is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-------internal signals-----
signal q1 : std_logic_vector(3 downto 0);
signal max_tick_1hz : std_logic;
signal q : std_logic_vector(3 downto 0);
signal level : std_logic;
signal level2 : std_logic;

------component declaration------
begin
debouncing:debouncing_circuit
port map(reset => reset, clk => clk, btn => button, output => level);

edge_detection:edge_detector
port map(clk => clk, reset => reset, level => level, tick => level2);

m10_counter:mod_m_counter_en
generic map (N => 4, M => 10)
port map(reset => reset, clk => clk, en => level2, q => q1, max_tick => open);

hex_display:hex_to_seg
port map (hex => q1, an => an, seg => seg);

end Behavioral;