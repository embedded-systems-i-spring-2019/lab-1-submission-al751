library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_top is
Port (btn, sw: in std_logic_vector(3 downto 0);
      clk: in std_logic;
      led: out std_logic_vector(3 downto 0));
end counter_top;

architecture counter of counter_top is

signal div_result: std_logic;
signal dbnc: std_logic_vector(3 downto 0) := (others => '0');

--------------------Fancy Counter Component-------------------------
component fancy_counter
Port (clk: in std_logic;
      clk_en: in std_logic;
      dir: in std_logic;
      ld, en: in std_logic;
      rst: in std_logic;
      updn: in std_logic;
      val: in std_logic_vector(3 downto 0);
      cnt: out std_logic_vector(3 downto 0));
end component;

--------------------Debounce Component---------------------------------
component debounce
Port (clk, btn: in std_logic;
      dbnc: out std_logic);
end component;

--------------------Clock Divider Component----------------------------
component clock_div is
    Port (clk: in std_logic;
          div: out std_logic);
end component;

begin

Clock_Divider: clock_div
    port map(clk => clk,
             div => div_result);

Button_Debounce0: debounce
    port map(clk => clk,
             btn => btn(0),
             dbnc=> dbnc(0));

Button_Debounce1: debounce
    port map(clk => clk,
             btn => btn(1),
             dbnc=> dbnc(1));

Button_Debounce2: debounce
    port map(clk => clk,
             btn => btn(2),
             dbnc=> dbnc(2));
             
Button_Debounce3: debounce
                 port map(clk => clk,
                          btn => btn(3),
                          dbnc=> dbnc(3));

F_Counter: fancy_counter
    port map(clk => clk,
             clk_en => div_result,
             dir => sw(0),
             en => dbnc(1),
             ld => dbnc(3),
             rst => dbnc(0),
             updn => dbnc(2),
             val(0) => sw(0),
             val(1) => sw(1),
             val(2) => sw(2),
             val(3) => sw(3),
             cnt(0) => led(0),
             cnt(1) => led(1),
             cnt(2) => led(2),
             cnt(3) => led(3));

end counter;