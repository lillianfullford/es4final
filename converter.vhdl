library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity converter is
port (
index : in unsigned(4 downto 0);
row : out unsigned(31 downto 0)
);
end converter;

architecture synth of converter is

component LFSR is
port(
clk : in std_logic;
reset : in std_logic;
count : out std_logic_vector(4 downto 0)
);
end component;

signal connector : std_logic_vector(4 downto 0);
signal output : unsigned (31 downto 0);
signal type_convert : unsigned(4 downto 0);
signal clock : std_logic;
signal reset1 : std_logic;
begin
connection : LFSR port map (count=>connector,reset=>reset1,clk=>clock);

type_convert <= unsigned(connector);
process
begin

-- -- for i in 0 to 31 loop
-- -- wait for 1 ns;
-- -- if i = type_convert then
-- -- output(i) <= '1';
-- -- else
-- -- output(i) <= '0';
-- -- end if;

-- -- wait for 5 ns;
-- -- end loop;

-- row <= output;
end process;
end;