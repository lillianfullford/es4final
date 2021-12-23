library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LFSR is
port (
clk : in std_logic;
reset : in std_logic;
count : out std_logic_vector(4 downto 0)
);
end LFSR;

architecture synth of LFSR is
begin
process (all) is
begin
if reset then
count <= "00001";
elsif rising_edge(clk) then
count(0) <= count(1);
count(1) <= count(2);
count(2) <= count(3) xor count(3);
count(3) <= count(4);
count(4) <= count(0);
end if;
end process;
end;
