set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design] 

set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_clk_p]
set_property PACKAGE_PIN AE5 [get_ports sys_clk_clk_p]
set_property PACKAGE_PIN AF5 [get_ports sys_clk_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_clk_n]
create_clock -period 5.000 -name sys_clk_clk_p -waveform {0.000 2.500} [get_ports sys_clk_clk_p]

set_property PACKAGE_PIN AA11 [get_ports {fan_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fan_tri_o[0]}]