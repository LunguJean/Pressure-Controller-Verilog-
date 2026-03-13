
##Nota:PIN-urile sunt de pe dispozitivul xc7s50csga324-1, singurul disponibil in laborator. 
##Acest fisier poate fi modificat(PIN-urile, LED-urile) in functie de dispozitiv
##Switches
set_property -dict { PACKAGE_PIN V2   IOSTANDARD LVCMOS33 } [get_ports { data }]; #SW 3
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports { ready }]; #SW 2
set_property -dict { PACKAGE_PIN K1   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #SW 1
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #SW 1
set_property -dict { PACKAGE_PIN U1   IOSTANDARD LVCMOS33 } [get_ports { test }]; #SW 1


##LEDs
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { led0 }]; #LED 0
set_property -dict { PACKAGE_PIN E5   IOSTANDARD LVCMOS33 } [get_ports { led1 }]; #LED 1
set_property -dict { PACKAGE_PIN E6   IOSTANDARD LVCMOS33 } [get_ports { led2 }]; #LED 2