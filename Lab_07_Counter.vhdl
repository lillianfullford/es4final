library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Lab_07_Counter is
  port(
output : out unsigned(19 downto 0)
  );
end Lab_07_Counter;

architecture synth of Lab_07_Counter is
component HSOSC is
generic (
    CLKHF_DIV : String := "0b00");
port(
    CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
    CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
    CLKHF : out std_logic := 'X'); -- Clock output
end component;

signal counter : unsigned(19 downto 0);
signal clk : std_logic;

begin

clksignal : HSOSC port map('1','1',clk);

process(clk) is
begin
    if rising_edge(clk) then
    counter <= counter + 1;
    end if;
end process;


output <= counter;


end;
