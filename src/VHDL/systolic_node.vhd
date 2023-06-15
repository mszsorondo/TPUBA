library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity systolic_node is
generic(N_dim : natural := 4;
        operable_bits: natural := 16);

port(
    clk_i : in std_logic;
    reset_i : in std_logic;
    el_i : in std_logic;
    eu_i: in std_logic;
    up_i : in signed(operable_bits downto 0);
    left_i : in signed(operable_bits downto 0); -- luego pasar a floats
    down_o : out signed(operable_bits downto 0);
    right_o : out signed(operable_bits downto 0);
    ed_o: out std_logic;
    er_o: out std_logic
    );
end entity;

architecture systolic_node_arch of systoclic_node is
    signal r_count : signed(2*operable_bits downto 0);
    signal up_val: signed(operable_bits downto 0);
    signal left_val: signed(operable_bits downto 0);

    begin
        SYSTOLIC_NODE_PROC: process(ckl_i, up_i, right_i)
            begin
                if rising_edge(ckl_i) then
                    if reset_i then
                        r_count <= (others => '0');
                    else
                        if (el_i and eu_i) then

                            down_o <= up_val;
                            right_o <= left_val;
                            ed_o <= '1';
                            er_o <= '1';
                        end if;
                    end if;
                end if;
            end process;
        r_count <= r_count + up_i*left_i;
        up_val <= up_i;
        left_val <= left_i;
    end architecture;
    

    
        
        
                            
