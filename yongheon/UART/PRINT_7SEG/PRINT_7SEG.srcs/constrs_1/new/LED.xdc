############################
# Clock & Reset
############################

set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports clk]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports rst]

############################
# UART RX (FTDI ¡æ FPGA)
############################
set_property PACKAGE_PIN G17 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports led[7]]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports led[6]]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports led[5]]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports led[4]]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports led[3]]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports led[2]]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports led[1]]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports led[0]]
# SEG
set_property PACKAGE_PIN D20 [get_ports {seg[0]}] ;# A
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN C20 [get_ports {seg[1]}] ;# B
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN C22 [get_ports {seg[2]}] ;# C
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN B22 [get_ports {seg[3]}] ;# D
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN B21 [get_ports {seg[4]}] ;# E
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN A21 [get_ports {seg[5]}] ;# F
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN E22 [get_ports {seg[6]}] ;# G
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

set_property PACKAGE_PIN D22 [get_ports {seg[7]}] ;# DP
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]

# DIGIT
set_property PACKAGE_PIN E14 [get_ports {digit[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]

set_property PACKAGE_PIN E16 [get_ports {digit[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]

set_property PACKAGE_PIN D16 [get_ports {digit[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]

set_property PACKAGE_PIN D14 [get_ports {digit[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]

set_property PACKAGE_PIN AB11 [get_ports {digit[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[4]}]

set_property PACKAGE_PIN AB12 [get_ports {digit[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[5]}]

set_property PACKAGE_PIN AA9 [get_ports {digit[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[6]}]

set_property PACKAGE_PIN AB10 [get_ports {digit[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit[7]}]



set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS33} [get_ports digit[7]]
set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVCMOS33} [get_ports digit[6]]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports digit[5]]
set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports digit[4]]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports digit[3]]
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS33} [get_ports digit[2]]
set_property -dict {PACKAGE_PIN AB12 IOSTANDARD LVCMOS33} [get_ports digit[1]]
set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVCMOS33} [get_ports digit[0]]