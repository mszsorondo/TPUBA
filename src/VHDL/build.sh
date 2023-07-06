ghdl -a systolic_node.vhd systolic_array_pkg.vhd  systolic_array.vhd testbenches/systolic_array_tb.vhd 
ghdl -e systolic_array_tb 
ghdl -r systolic_array_tb --vcd=systolic_array_tb.vcd