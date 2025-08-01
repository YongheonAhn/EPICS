# ========= Clock =========
set_property PACKAGE_PIN R4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# ========= Reset =========
set_property PACKAGE_PIN U7 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# ========= UART =========
set_property PACKAGE_PIN G17 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

# ========= LCD Control =========
set_property PACKAGE_PIN V3 [get_ports lcd_en]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_en]

set_property PACKAGE_PIN AA1 [get_ports lcd_rs]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rs]

set_property PACKAGE_PIN AB1 [get_ports lcd_rw]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_rw]

# ========= LCD Data [7:0] =========
set_property PACKAGE_PIN AB3 [get_ports {lcd_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[0]}]

set_property PACKAGE_PIN AB2 [get_ports {lcd_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[1]}]

set_property PACKAGE_PIN Y3 [get_ports {lcd_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[2]}]

set_property PACKAGE_PIN AA3 [get_ports {lcd_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[3]}]

set_property PACKAGE_PIN AA5 [get_ports {lcd_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[4]}]

set_property PACKAGE_PIN AB5 [get_ports {lcd_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[5]}]

set_property PACKAGE_PIN Y4 [get_ports {lcd_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[6]}]

set_property PACKAGE_PIN AA4 [get_ports {lcd_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[7]}]
