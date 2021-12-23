library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Lab07_Top is
port(
control_in : in std_logic;
latch : out std_logic;
clk : out std_logic;
a_pressed : out std_logic;
b_pressed : out std_logic
);
end Lab07_Top;

architecture synth of Lab07_Top is

component Lab_07_Counter is
port(
output : out unsigned(19 downto 0)
);
end component;

signal counterOut : unsigned(19 downto 0);
signal NESclk : std_logic;
signal NEScount : unsigned(10 downto 0);
signal data : std_logic_vector(7 downto 0);
signal fullData : std_logic_vector(7 downto 0);


signal select_pressed : std_logic;
signal up_pressed : std_logic;
signal down_pressed : std_logic;
signal left_pressed : std_logic;
signal right_pressed : std_logic;

begin

counter : lab_07_Counter port map(counterOut);
NESclk <= counterOut(8);
NEScount <=(counterOut(19 downto 9));
latch <= '1' when (NEScount = 11b"0") else '0';
clk <= NESclk when (NEScount > "00000000000" and NEScount < "0000001001") else '0';
process(clk) begin
if (rising_edge(clk)) then
data(7 downto 1) <= data(6 downto 0);
data(0) <= control_in;
end if;
end process;

process(NESclk) begin
if (rising_edge(NESclk) and NEScount = "0000001010") then
fullData <= data;
end if;
end process;

--a and b currently set to outputs for debugging, but they should likely be swapped to signals to be kept internal
a_pressed <= not fullData(7);
b_pressed <= not fullData(6);

--these are all internal signals and not actually attached to any output pins yet

select_pressed <= not fullData(5);
up_pressed <= not fullData(3);
down_pressed <= not fullData(2);
left_pressed <= not fullData(1);
right_pressed <= not fullData(0);
end;