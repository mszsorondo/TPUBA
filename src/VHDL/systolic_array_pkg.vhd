library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package systolic_array_pkg is
    --Constants
    constant operable_bits: natural := 16;

    --Types
    
    type systolic_array_input_vector is array(integer range <>) of signed(operable_bits-1 downto 0);
    type systolic_array_output_vector is array(integer range <>) of signed(operable_bits*2-1 downto 0);
    type systolic_array_input_mtx is array (integer range <>) of systolic_array_input_vector(2 downto 0);
    type handShakeBuffer is array (integer range <>) of std_logic;
    type int_array is array(integer range <>) of integer;
    type int_matrix is array(integer range <>) of int_array(2 downto 0);

    --Functions
    function get_downwards_buffer_index(iteration_num: in natural; dimension: in natural)
        return natural;
    function get_rightwise_buffer_index(iteration_num: in natural; dimension: in natural)
        return natural;
    function to_sytolic_array_input_vector(vector: in int_array)
        return systolic_array_input_vector;
    function to_systolic_array_input_matrix(matrix: in int_matrix)
        return systolic_array_input_mtx;
end package;

package body systolic_array_pkg is
    function get_downwards_buffer_index(iteration_num: in natural; dimension: in natural)
        return natural is
            variable result: natural;
        begin
            if iteration_num >= dimension*(dimension-1) then
                result := dimension*dimension;
            else 
                result := iteration_num + dimension;
            end if;
            return result;
    end get_downwards_buffer_index;
    
    function get_rightwise_buffer_index(iteration_num: in natural; dimension: in natural)
        return natural is
            variable result: natural;
        begin
            if iteration_num mod dimension = dimension-1 then
                result := dimension*dimension;
            else 
                result := iteration_num+1;
            end if;
            return result;
    end get_rightwise_buffer_index;

    function to_sytolic_array_input_vector(vector: in int_array)
    return systolic_array_input_vector is
        variable result: systolic_array_input_vector(vector'range);
    begin
        for i in vector'range loop
            result(i) := to_signed(vector(i), operable_bits);
        end loop;
        return result;
    end function to_sytolic_array_input_vector;

function to_systolic_array_input_matrix(matrix: in int_matrix)
    return systolic_array_input_mtx is
        variable result: systolic_array_input_mtx(matrix'range);
    begin
        for i in matrix'range loop
            result(i) := to_sytolic_array_input_vector(matrix(i));
        end loop;
        return result;
    end function to_systolic_array_input_matrix;
end package body;
