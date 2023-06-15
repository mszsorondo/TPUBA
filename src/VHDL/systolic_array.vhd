library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package systolic_array_pkg is
    constant D: natural:= 3,
    constant operable_bits: natural :=
    type systolic_array_input_vector is array(dimension-1 downto 0) of unsigned(operable_bits downto 0)
end package ;

entity systolic_array is
    generic(dimension: natural := 3,
            operable_bits: natural := 16
            )
    
    port(
        clk_i : in std_logic;
        reset_i : in std_logic;
        buffera_i : in array(dimension-1 downto 0) of unsigned(operable_bits downto 0);
        bufferb_i : in array(dimension-1 downto 0) of unsigned(operable_bits downto 0);   
        )

