library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity systolic_node is
generic(operable_bits: natural := 16);

port(
    clk_i : in std_logic;
    reset_i : in std_logic;
    el_i : in std_logic;
    eu_i: in std_logic;
    up_i : in signed(operable_bits-1 downto 0);
    left_i : in signed(operable_bits-1 downto 0); -- luego pasar a floats
    down_o : out signed(operable_bits-1 downto 0);
    right_o : out signed(operable_bits-1 downto 0);
    ed_o: out std_logic;
    er_o: out std_logic;
    res_o: out signed(operable_bits*2-1 downto 0)
    );
end entity;

architecture systolic_node_arch of systolic_node is
    signal r_count : signed((2*operable_bits)-1 downto 0);
    signal r_count_next : signed((2*operable_bits)-1 downto 0);
    signal up_val: signed(operable_bits-1 downto 0);
    signal left_val: signed(operable_bits-1 downto 0);
    signal prod: signed((2*operable_bits)-1 downto 0);

    begin
        SYSTOLIC_NODE_PROC: process(clk_i)    
            begin
                if rising_edge(clk_i) then
                    if (reset_i = '1') then
                        r_count <= to_signed(0, 2*  operable_bits);
                    elsif (el_i and eu_i) ='1' then
                            r_count <= r_count_next;
                            down_o <= up_val;
                            right_o <= left_val;
                            ed_o <= '1';
                            er_o <= '1';
                    end if;
                end if;
            end process; 
        
        prod <= up_i*left_i;
        up_val <= up_i;
        left_val <= left_i;
        r_count_next <= r_count + prod;
        res_o <= r_count;
    end architecture;
    

    
        
        
                            
