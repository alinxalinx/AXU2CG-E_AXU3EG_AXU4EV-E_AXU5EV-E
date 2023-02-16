set_property PACKAGE_PIN AE10 [get_ports {cam_gpio[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cam_gpio[0]}]
set_property PULLUP true [get_ports {cam_gpio[0]}]

set_property PACKAGE_PIN Y9  [get_ports cam_i2c_scl_io]
set_property PACKAGE_PIN AA8 [get_ports cam_i2c_sda_io]

set_property IOSTANDARD LVCMOS33 [get_ports cam_i2c_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports cam_i2c_sda_io]


set_property PULLUP true [get_ports cam_i2c_scl_io]
set_property PULLUP true [get_ports cam_i2c_sda_io]

