library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_driver is
    port(
      clk_in : in std_logic;
      HSYNC : out std_logic;
      VSYNC : out std_logic;
      valid : out std_logic;
      hPos: out unsigned(4 downto 0);
      vPos : out unsigned(3 downto 0)
      );
end vga_driver;

architecture synth of vga_driver is

signal row : unsigned(9 downto 0) := "0000000000";
signal column : unsigned(8 downto 0) := "000000000";

begin

  process (clk_in) begin
    if rising_edge(clk_in) then
      if (row < 640 and column < 480) then
        valid <= '1';
      else
        valid <= '0';
      end if;

      if (row <= 799) then
        row <= row + 1;

        if (row > 659 and row < 756) then
          HSYNC <= '0';
        else
          HSYNC <= '1';
        end if;

        if (row = 799) then
          row <= "0000000000";

          if (column <= 524) then
            column <= column + 1;

            if (column > 490 and column < 493) then
              VSYNC <= '0';
            else
              VSYNC <= '1';
            end if;

            if (column = 524) then
                column <= "000000000";
            end if;

          end if;

        end if;

      end if;

    end if;
    
    hPos <= row(9 downto 5);
    vPos <= column(8 downto 5);


  end process;

end synth;