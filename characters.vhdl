library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity characters is
    port(
        a_button : in std_logic;
        b_button : in std_logic;
        clk : in std_logic;
        char : out unsigned(31 downto 0)
);
end characters;

architecture synth of characters is

--component Lab07_Top is
--    port(
--        control_in : in std_logic;
--        latch : out std_logic;
--        clk : out std_logic;
--        a_pressed : out std_logic;
--        b_pressed : out std_logic
--    );
--end component;

signal a_1 : std_logic;
signal b_1 : std_logic;
signal init_loc : unsigned(4 downto 0); -- initial location
signal position : unsigned(4 downto 0);

begin
--    nes : Lab07_Top port map(a_pressed=>a_1,b_pressed=>b_1);
    init_loc <= "00101";
    process (all) is
begin
        if a_1 = '1' then
            if init_loc < "10011" then
                position <= init_loc + '1';
            else
                position <= position;
            end if;
        elsif b_1 = '1' then
            if init_loc > "00000" then
                position <= init_loc - '1';
            else
                position <= position;
            end if;
        else
            position <= position;
        end if;


        init_loc <= position;


        for i in 0 to 31 loop
            if i = position then
                char(i) <= '1';
            else
                char(i) <= '0';
            end if;
        end loop;
    end process;
end;