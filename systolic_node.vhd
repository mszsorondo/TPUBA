library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity systolic_node IS
generic(N_dim : natural := 3;
        operable_bits: natural := 16);

port(
    a,b :in signed(operable_bits downto 0); -- luego pasar a floats
    p, a_right. b_down : out signed(operable_bits downto 0);
    )
end entity;

