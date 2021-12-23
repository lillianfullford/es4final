library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity board is
    port(
    clk : in std_logic;
    clk_pxl : out std_logic; --use this clock
    clk_locked : out std_logic;
    rgb : out std_logic_vector(5 downto 0);
    HSYNC : out std_logic;
    VSYNC : out std_logic;
    a_pressed : in std_logic;
    b_pressed : in std_logic
    );
end board;

architecture synth of board is

    component pll is
        port (
           clk_in : in std_logic;
           clk_out : out std_logic;
           clk_locked : out std_logic
           );
end component;

type ramboard is array (0 to 14) of unsigned(31 downto 0); -- DECLARING ARRAY

--port map


-- component HSOSC is
--     generic (
--         CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2ˆN (0-3)
--     port(
--         CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
--         CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
--         CLKHF : out std_logic := 'X'
--     );
-- end component;

-- component converter is
--     port (  
--         index : in unsigned(4 downto 0);
--         row : out unsigned(31 downto 0)
--     );
-- end component;

-- component characters is
--     port (
--         a_button : in std_logic;
--         b_button : in std_logic;
--         clk : in std_logic;
--         char : out unsigned(31 downto 0)
--     );
-- end component;

component vga_driver is
    port(
      clk_in : in std_logic;
      HSYNC : out std_logic;
      VSYNC : out std_logic;
      valid : out std_logic;
      hPos: out unsigned(4 downto 0);
      vPos : out unsigned(3 downto 0)
      );
end component;


--SIGNAL DECLARATION
signal arr : ramboard := (others =>(others=> '0'));
signal block_pos : unsigned(31 downto 0);
signal char_pos : unsigned(31 downto 0);
signal counter : unsigned(25 downto 0);
signal vga_row : unsigned(9 downto 5);
signal vga_col : unsigned (8 downto 5);
signal a : std_logic;
signal b : std_logic;
signal i : integer;
signal int1 : integer;
signal int2 : integer;
signal char_loc :  unsigned(4 downto 0);
signal  block_loc :  unsigned(31 downto 0);
signal HSYNC_signal : std_logic;
signal VSYNC_signal : std_logic;
signal valid1: std_logic;
signal clk_locked2 : std_logic;



begin

-------VGA PORT MAP
    -- clock : HSOSC port map(CLKHFPU=>'1',CLKHFEN=>'1',CLKHF=>clk1);
    -- blocks : converter port map(index=>vga_row,row=>block_pos);
    -- --char : characters port map(clk=>clk1,a_button=>a,b_button=>b,char=>char_pos);

vga : vga_driver port map (hPos => vga_row , vPos => vga_col, clk_in => clk_pxl, HSYNC => HSYNC_signal, VSYNC => VSYNC_signal,   valid => valid1);
pll1 : pll port map (clk, clk_pxl, clk_locked);



HSYNC <= HSYNC_signal;
VSYNC <= VSYNC_signal;

    process (clk_pxl) is
        begin
            if rising_edge(clk_pxl) then
                arr(0) <= block_pos;
                arr(14) <= char_pos;

    
                    -- for int1 in 0 to 14 loop
                    --     for int2 in 0 to 19 loop
                    --         if int1 = vga_row and int2 = vga_col then
                    --             if arr(int1)(int2) = '1' then
                    --                 rgb <= "111111";
                    --             else
                    --                 rgb <= "000000";
                    --             end if;
                    --         end if;
                    --     end loop;
                    -- end loop;
                
                    -- arr(1) <= arr(0);
                    -- arr(2) <= arr(1);
                    -- arr(3) <= arr(2);
                    -- arr(4) <= arr(3);
                    -- arr(5) <= arr(4);
                    -- arr(6) <= arr(5);
                    -- arr(7) <= arr(6);
                    -- arr(8) <= arr(7);
                    -- arr(9) <= arr(8);
                    -- arr(10) <= arr(9);
                    -- arr(11) <= arr(10);
                    -- arr(12) <= arr(11);
                    -- arr(13) <= arr(12);
                    -- arr(0) <= block_pos;
                    -- arr(14) <= char_pos;

                    if vga_row < 640 and vga_col < 480 then
                        rgb <= "111111";
                    else
                        rgb <= "000000";
                    end if;
            end if;
           
            -- if arr(14) = arr(13) then
            --     for i in 0 to 14 loop
            --         arr(i) <= "00000000000000000000000000000000";
            --     end loop;
            -- end if;
        end process;
end;