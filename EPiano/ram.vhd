----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2021 07:03:40 PM
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
    generic(
        ADDR_WIDTH : integer :=10;
        DATA_WIDTH : integer :=8
    );
    Port (
        clk : in STD_LOGIC;
        write_enable : in STD_LOGIC;
        addr : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        din : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        dout : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
   );
end ram;

architecture Behavioral of ram is
    type ram_type is array (2** ADDR_WIDTH-1 downto 0)
        of STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    signal ram : ram_type;
begin
    process (clk)
    begin
        if (clk'event and clk = '1') then 
            if (write_enable = '1') then
                ram(to_integer(unsigned(addr))) <= din;
            end if;
        end if;
    end process;
    dout <= ram(to_integer(unsigned(addr)));

end Behavioral;
