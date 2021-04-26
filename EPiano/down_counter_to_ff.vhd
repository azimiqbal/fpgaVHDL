-- Listing 4.10
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity uni_mod_down_counter is
   generic(N: integer := 18);
   port(
      clk, rst: in std_logic;
      note_in: in std_logic_vector(N-1 downto 0);
      min_tick: out std_logic;
      q: out std_logic_vector(N-1 downto 0)
   );
end uni_mod_down_counter;

architecture arch of uni_mod_down_counter is
   signal r_reg: unsigned(N-1 downto 0);
   signal r_next: unsigned(N-1 downto 0);
begin
   -- register
   process(clk,rst)
   begin
      if (rst='1') then
         r_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         r_reg <= r_next;
      end if;
   end process;
   -- next-state logic
   r_next <= (others=>'0') when r_reg>=(unsigned(note_in)-1) else
             r_reg + 1;

   -- output logic
   q <= std_logic_vector(r_reg);
   min_tick <= '1' when r_reg>=(unsigned(note_in)-1) else '0';
end arch;