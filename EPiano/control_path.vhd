library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_path is
    Port (      
            clk, rst, rx_done_tick, timer_done, play : in STD_LOGIC;
            clear, incr, write_enable, timer_on, mute: out STD_LOGIC;
            uart_data : in STD_LOGIC_VECTOR(7 downto 0);
            ram_data : in STD_LOGIC_VECTOR(7 downto 0);
            address : in STD_LOGIC_VECTOR(9 downto 0)
    );
end control_path;

architecture Behavioral of control_path is

    type state_type is (init, abandon_init, play_from_uart_1, play_from_uart_2, play_from_ram, abandon_play_from_ram, wait_for_play_button, abandon_uart);
    signal state_reg, state_next : state_type;

   -- register
begin

    process(clk, rst)
        begin
        if (rst = '1') then
            state_reg <= init;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

   -- next-state logic
    process (state_reg, play, rx_done_tick, uart_data, ram_data, timer_done)
    begin
        state_next <= state_reg;
        mute <= '0';
        timer_on <= '0';
        write_enable <= '0';
        clear <= '0';
        incr <= '0';
        
        case state_reg is
            when init =>
                clear <= '1';
                mute <= '1';
                if rx_done_tick = '1' then
                    if (uart_data = x"71" or uart_data = x"77" or uart_data = x"65" or -- qwe
                        uart_data = x"72" or uart_data = x"74" or uart_data = x"79" or -- rty
                        uart_data = x"75" or uart_data = x"61" or uart_data = x"73" or -- uas
                        uart_data = x"64" or uart_data = x"66" or uart_data = x"67" or -- dfg
                        uart_data = x"68" or uart_data = x"6A") then --if ascii valid
                        state_next <= abandon_init;
                    end if;
                end if;
            when abandon_init => 
                write_enable <= '1';
                state_next <= play_from_uart_1;
            when play_from_uart_1 =>
                if (rx_done_tick = '1') then
                    if (uart_data=x"0D") then --end of tune? --enter key
                        incr <= '1';
                        state_next <= abandon_uart;
                    elsif (uart_data = x"71" or uart_data = x"77" or uart_data = x"65" or -- qwe
                            uart_data = x"72" or uart_data = x"74" or uart_data = x"79" or -- rty
                            uart_data = x"75" or uart_data = x"61" or uart_data = x"73" or -- uas
                            uart_data = x"64" or uart_data = x"66" or uart_data = x"67" or -- dfg
                            uart_data = x"68" or uart_data = x"6A") then --if ascii valid
                            incr <= '1';
                            state_next <= abandon_init;
                    elsif (uart_data = x"20") then -- if space
                        state_next <= play_from_uart_2;
                    end if;
                end if;
            when play_from_uart_2 =>
                mute <= '1';
                if (rx_done_tick <= '1') then
                    if (uart_data = x"0D") then
                        write_enable <= '1';
                        state_next <= abandon_uart;
                    elsif (uart_data = x"71" or uart_data = x"77" or uart_data = x"65" or -- qwe
                        uart_data = x"72" or uart_data = x"74" or uart_data = x"79" or -- rty
                        uart_data = x"75" or uart_data = x"61" or uart_data = x"73" or -- uas
                        uart_data = x"64" or uart_data = x"66" or uart_data = x"67" or -- dfg
                        uart_data = x"68" or uart_data = x"6A") then
                        incr <= '1';
                        state_next <= abandon_init;
                    end if;
                end if;
            when abandon_uart =>
                write_enable <= '1';
                clear <= '1';
                state_next <= wait_for_play_button;
            when wait_for_play_button =>
                mute <= '1';
                if (play = '1') then
                    state_next <= play_from_ram;
                elsif (rx_done_tick <= '1') then
                    if (uart_data = x"71" or uart_data = x"77" or uart_data = x"65" or -- qwe
                        uart_data = x"72" or uart_data = x"74" or uart_data = x"79" or -- rty
                        uart_data = x"75" or uart_data = x"61" or uart_data = x"73" or -- uas
                        uart_data = x"64" or uart_data = x"66" or uart_data = x"67" or -- dfg
                        uart_data = x"68" or uart_data = x"6A") then
                        write_enable <= '1';
                        state_next <= play_from_uart_1;
                    end if;
                end if;
            when play_from_ram => 
                timer_on <= '1'; 
                if (ram_data = x"0D") then
                    clear <= '1';
                    state_next <= wait_for_play_button;
                elsif (rx_done_tick = '1') then
                    if (uart_data = x"71" or uart_data = x"77" or uart_data = x"65" or -- qwe
                        uart_data = x"72" or uart_data = x"74" or uart_data = x"79" or -- rty
                        uart_data = x"75" or uart_data = x"61" or uart_data = x"73" or -- uas
                        uart_data = x"64" or uart_data = x"66" or uart_data = x"67" or -- dfg
                        uart_data = x"68" or uart_data = x"6A") then
                        clear <= '1';
                        state_next <= abandon_play_from_ram;
                    end if;
                elsif (timer_done = '1') then
                    incr <= '1';
                end if;
            when abandon_play_from_ram =>
                write_enable <= '1';
                state_next <= play_from_uart_1;
        end case;
    end process;
                        
end Behavioral;
