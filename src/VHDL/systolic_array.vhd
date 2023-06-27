library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package systolic_array_pkg is
    --Constants
    constant D: natural:= 3;
    constant operable_bits: natural := 16;

    --Types
    type systolic_array_input_vector is array(dimension downto 0, dimension downto 0) of unsigned(operable_bits downto 0);
    type handShakeBuffer is array (dimension downto 0, dimension downto 0) of std_logic;

    --Functions
    function get_buffer_j_index(iteration_num: in natural)
        return natural;
    function get_downwards_buffer_j_index(iteration_num: in natural)
        return natural;
    function get_rightwise_buffer_i_index(iteration_num: in natural)
        return natural;
    function get_rightwise_buffer_j_index(iteration_num: in natural)
        return natural;
end package;

package body systolic_array_pkg is
    function get_buffer_j_index(iteration_num: in natural)
        return natural is
            variable result: natural;
        begin
            result := iteration_num mod
    end get_buffer_j_index;

end package body;
entity systolic_array is
    generic(dimension: natural := 3;
            operable_bits: natural := 16
            );
    
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        bufferA_i : in systolic_array_input_vector(dimension, operable_bits);
        bufferB_i : in systolic_array_input_vector(dimension, operable_bits)
        );
end entity;


architecture systolic_array_arch of systolic_array is

    
    signal en_rightwise, en_downwise: handShakeBuffer

    signal downwards_buffer, rightwise_buffer: systolic_array_input_vector(dimension, dimension, operable_bits);

    begin
        NODES: for i in 0 to (dimension*dimension)-1 generate
            if ((i mod dimension) = (dimension-1) ) =
            NODE_ITERATION: entity work.systolic_node            
            generic map(operable_bits => operable_bits);

            port map(clk_i => clk_i
                    reset_i => reset_i
                    el_i : en_rightwise(i);
                    eu_i: en_downwise(i);
                    up_i : downwards_buffer(i);
                    left_i : rightwise_buffer(i); -- luego pasar a floats
                    down_o : ;
                    right_o : ;
                    ed_o: out std_logic;
                    er_o: out std_logic 

                )

                    
begin

end systolic_array_arhc ; -- systolic_array_arhc