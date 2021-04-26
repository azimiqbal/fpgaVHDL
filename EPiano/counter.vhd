-- Listing 4.10
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity univ_bin_counter is
   generic(N: integer := 10);
   port(
      clk, rst: in std_logic;
      clear, incr, up: in std_logic;
      max_tick, min_tick: out std_logic;
      address: out std_logic_vector(N-1 downto 0)
   );
end univ_bin_counter;

architecture arch of univ_bin_counter is
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
   r_next <= (others=>'0') when clear='1' else
             r_reg + 1     when incr ='1' and up='1' else
             r_reg - 1     when incr ='1' and up='0' else
             r_reg;
   -- output logic
   address <= std_logic_vector(r_reg);
   max_tick <= '1' when r_reg=(2**N-1) else '0';
   min_tick <= '1' when r_reg=0 else '0';
end arch;