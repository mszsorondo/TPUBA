library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.systolic_array_pkg.all;

entity systolic_node_tb is
end systolic_node_tb;   

architecture testbench of systolic_node_tb is

constant N: natural := 16;
constant dimension: natural := 3;

signal clk_i : std_logic := '1';
signal rst_i : std_logic := '1';
signal bufferA_i : systolic_array_input_vector(dimension downto 0);
signal bufferB_i : systolic_array_input_vector(dimension downto 0);
signal bufferC_o : systolic_array_input_vector(dimension downto 0);


signal mat_bufferA_i : systolic_array_input_mtx(dimension+dimension-1 downto 0) := to_systolic_array_input_matrix(((3, 0, 0), (2, 6, 0), (1, 5, 9), (0, 4, 8), (0, 0, 7)));
signal mat_bufferB_i : systolic_array_input_mtx(dimension+dimension-1 downto 0):= to_systolic_array_input_matrix(((0, 0, 0), (0, 0, 0), (1, 1, 1), (0, 0, 0), (0, 0, 0)));


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
        reset_i <= '1';
        wait for clk_period * 5 + 1 ps;
        reset_i <= '0';
        test_iter: for i in 0 to mat_bufferA_i'length loop
            bufferA_i <= mat_bufferA_i(i);
            bufferB_i <= mat_bufferB_i(i);
            wait for clk_period;
        end loop test_iter;
    end process ; -- TEST_PROC

    SYSTOLIC_NODE: entity work.systolic_array
    generic map(
        dimension => dimension
    )
    port map(
        clk_i => clk_i,
        reset_i => reset_i,
        bufferA_i => bufferA_i,
        bufferB_i => bufferB_i,
        bufferC_o => bufferC_o
    );
end architecture;