Library IEEE;
use IEEE.std_logic_1164.all,IEEE.numeric_std.all;

ENTITY debounce_tb IS
END debounce_tb;

architecture testbench of debounce_tb is
Component debounce
port(clk :in std_logic;
    btn :in std_logic;
    dbnc :out std_logic);
end Component;

signal clock_tb : std_logic := '0';
signal btn_tb : std_logic;
signal dbnc_tb : std_logic;

constant clk_period : time := 10 ns;

begin
DUT: debounce 
    PORT MAP (clk => clock_tb,
              btn => btn_tb,
              dbnc => dbnc_tb);

generate_clk_process :process
    begin
        clock_tb <= '0';
        wait for clk_period/2;
        clock_tb <= '1';
        wait for clk_period/2;


end process;


simulate_process: process
    begin
        wait for 100ns;
        btn_tb<='1';
        wait;
    end process;
end;
 
