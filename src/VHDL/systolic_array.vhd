library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.systolic_array_pkg.all; 

entity systolic_array is
    
    generic(dimension: natural := 3
            );
    
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        bufferA_i : in systolic_array_input_vector(dimension-1 downto 0);
        bufferB_i : in systolic_array_input_vector(dimension-1 downto 0);
        bufferC_o : out systolic_array_output_vector(dimension*dimension downto 0)
        );
end entity;


architecture systolic_array_arch of systolic_array is

    signal en_rightwise, en_downwards: handShakeBuffer(dimension*dimension downto 0);

    signal downwards_buffer, rightwise_buffer: systolic_array_input_vector(dimension*dimension downto 0);

    begin
        NODES: for i in 0 to (dimension*dimension)-1 generate
            NODE_ITERATION: entity work.systolic_node            
            generic map(operable_bits => 16)

            port map(clk_i => clk_i,
                    reset_i => reset_i,
                    el_i => en_rightwise(i),
                    eu_i => en_downwards(i),
                    left_i => rightwise_buffer(i), -- luego pasar a floats
                    up_i => downwards_buffer(i),
                    down_o => downwards_buffer(get_downwards_buffer_index(i, dimension)),
                    right_o => rightwise_buffer(get_rightwise_buffer_index(i, dimension)),
                    ed_o => en_downwards(get_downwards_buffer_index(i, dimension)),
                    er_o => en_rightwise(get_rightwise_buffer_index(i, dimension)),
                    res_o => bufferC_o(i)
                );
        end generate;

        input : process(clk_i, bufferA_i, bufferB_i)
        begin
            if rising_edge(clk_i) then
                input_assignment: for i in 0 to dimension-1 loop
                    downwards_buffer(i) <= bufferA_i(i);
                    en_downwards(i) <= '1';
                    rightwise_buffer(i*dimension) <= bufferB_i(i);
                    en_rightwise(i*dimension) <= '1';
                end loop;
            end if;
        end process ; -- input

end architecture; -- systolic_array_arhc