-- uart_rx.vhd: UART controller - receiving (RX) side
-- Author(s): Dmitrii Ivanushkin (xivanu00)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



-- Entity declaration (DO NOT ALTER THIS PART!)
entity UART_RX is
    port(
        CLK      : in std_logic;
        RST      : in std_logic;
        DIN      : in std_logic;
        DOUT     : out std_logic_vector(7 downto 0);
        DOUT_VLD : out std_logic
    );
end entity;



-- Architecture implementation (INSERT YOUR IMPLEMENTATION HERE)
architecture behavioral of UART_RX is

    signal CNT_CYCLE : std_logic_vector(4 downto 0);
    signal CNT_BIT   : std_logic_vector(3 downto 0);
    signal CYCLE_EN  : std_logic;
    signal BIT_EN    : std_logic;
    
begin

    -- Instance of RX FSM
    fsm: entity work.UART_RX_FSM
    port map (
        CLK       => CLK,
        RST       => RST,
        DIN       => DIN,
        CNT_CYCLE => CNT_CYCLE,
        BIT_CYCLE => BIT_CYCLE,
        CYCLE_EN  => CYCLE_EN,
        BIT_EN    => BIT_EN,
        DOUT_VLD  => DOUT_VLD
    );

    counter_cycle: process(CLK, RST, CYCLE_EN)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                CYCLE_CNT <= '00000';
            elsif CYCLE_EN = '1' then
                CYCLE_CNT <= CYCLE_CNT + 1;
            end if;
        end if;
    end process;

    counter_bit: process(CLK, RST, CYCLE_EN, BIT_EN)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                BIT_CNT <= '00000';
            elsif CYCLE_EN = '1' and BIT_EN = '1' then
                BIT_CNT <= BIT_CNT + 1;
            end if;
        end if;
    end process;

end architecture;
