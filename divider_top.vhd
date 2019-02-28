
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg is
port(clk, chip_enable, input: in std_logic;
     q: out std_logic);
end reg;

architecture my_reg of reg is
begin 
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(chip_enable = '1') then
                q <= input;
            else 
                q <= '0';
            end if;
        end if;
     end process;
end my_reg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;        
entity divider_top is
port(Clock: in std_logic;
     led0: inout std_logic);
end divider_top;

architecture led_reg of divider_top is
---------------intermediate signals----------------------------
signal new_clk: std_logic;
signal led0_i: std_logic;
--------------clock_div Component-------------------------------
component clock_div
Port (clk: in std_logic; 
      div: out std_logic);
end component;

component reg
port(clk, chip_enable, input: in std_logic;
     q: out std_logic);
end component;

begin
led0_i <= not led0;
clock_divider: clock_div
    port map(clk => Clock,
             div => new_clk);

led0_reg: reg
port map(clk => clock,
         chip_enable => new_clk,
         input => led0_i,
         q => led0);
end led_reg;