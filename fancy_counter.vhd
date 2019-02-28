----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 09:18:40 PM
-- Design Name: 
-- Module Name: fancy_counter - Behavioral
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

entity fancy_counter is
Port (clk: in std_logic;
      clk_en: in std_logic;
      dir: in std_logic;
      ld, en: in std_logic;
      rst: in std_logic;
      updn: in std_logic;
      val: in std_logic_vector(3 downto 0);
      cnt: out std_logic_vector(3 downto 0));
end fancy_counter;

architecture Behavioral of fancy_counter is
signal cnt_result: std_logic_vector(3 downto 0) := (others => '0');
signal hold: std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                cnt <= (others => '0');
            end if;
            if(clk_en = '1' and en = '1') then 
                if(ld = '1') then 
                    cnt_result <= val;
                    hold <= cnt_result;
                    cnt <= cnt_result;
                end if;
                if(updn = '1') then
                    if(dir = '1') then 
                        cnt_result <= std_logic_vector(unsigned(cnt_result) + 1);
                        cnt <= cnt_result;
                        if(cnt_result = hold) then
                            cnt_result <= "0000";
                        end if;
                    else
                        cnt_result <= std_logic_vector(unsigned(cnt_result) - 1);
                        cnt <= cnt_result;
                        if(cnt_result = "0000") then
                            cnt_result <= hold;
                            cnt <= cnt_result;
                        end if;
                    end if;
             end if;
            end if;
        end if;
    end process;

end Behavioral;