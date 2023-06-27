library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity systolic_node_tb is
end systolic_node_tb;   

architecture testbench of systolic_node_tb is

constant N: natural := 16;

signal clk_i : std_logic := '1';
signal rst_i : std_logic := '1';
signal el_i : std_logic := '0';
signal eu_i : std_logic := '0';
signal up_i : signed(N-1 downto 0) := to_signed(0, N);
signal left_i : signed(N-1 downto 0) := to_signed(0, N);
signal er_o : std_logic;
signal ed_o : std_logic;
signal down_o : signed(N-1 downto 0);
signal right_o : signed(N-1 downto 0);
signal res_o : signed(N*2-1 downto 0);

constant clk_period : time := 20 ns;

begin

    CLK_PROC: process
    begin
        clk_i <= '1';
        wait for clk_period/2;
        clk_i <= '0';
        wait for clk_period/2;
    end process;


        
    TEST_PROC : process
    begin
        rst_i <= '1';
        wait for clk_period * 5 + 1 ps;
        rst_i <= '0';
        eu_i <= '0';
        el_i <= '0';
        wait for clk_period * 10 + 1 ps;
        el_i <= '1';
        eu_i <= '1';
        up_i <= to_signed(5, N);
        left_i <= to_signed(5, N);
        wait for clk_period;
        up_i <= to_signed(2, N);
        left_i <= to_signed(3, N);
        wait for clk_period;
        up_i <= to_signed(4, N);
        left_i <= to_signed(1, N);
        wait for clk_period;
        rst_i <= '1';
        wait;
    end process ; -- TEST_PROC

    SYSTOLIC_NODE: entity work.systolic_node
    generic map(
        operable_bits => N
    )
    port map(
        clk_i => clk_i,
        reset_i => rst_i,
        el_i => el_i,
        eu_i => eu_i,
        left_i => left_i,
        up_i => up_i,
        down_o => down_o,
        right_o => right_o,
        ed_o => ed_o,
        er_o => er_o,
        res_o => res_o
    );
end architecture;