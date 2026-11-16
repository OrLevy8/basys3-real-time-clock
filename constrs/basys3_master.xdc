## ==============================================================================
## Project: 24-Hour Digital Real-Time Clock with Programmable Load & Prescaler
## Target Board: Digilent Basys 3 (Xilinx Artix-7 XC7A35T-1CPG236C)
## Peripheral: Digilent Pmod SSD (Dual 7-Segment Display on Header JA/JB)
## File: basys3_master.xdc
## ==============================================================================

##########
# Clocks #
##########
# On-board 100 MHz Oscillator (W5)
create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports CLK]

###############
# Input Delay #
###############
set_input_delay 0 -clock CLK -add_delay [get_ports {RESET TESTMODE LOAD ADDRS* DATA_IN*}]

################
# Output Delay #
################
set_output_delay -clock CLK -add_delay 0.000 [get_ports {BASYS_SEGMENTS_OUT* SSD_SEGMENTS_OUT* BASYS_ANODE_OUT* SSD_CATHODE_OUT}]

##############################
# Pin Locations and Voltages #
##############################

## Clock signal (100 MHz oscillator)
set_property -dict {PACKAGE_PIN W5  IOSTANDARD LVCMOS33} [get_ports CLK]

## Push Buttons
# Center Button (btnC) -> System Synchronous Reset
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports RESET]
# Right Button (btnR)  -> Test Mode (Fast Simulation / Prescaler bypass)
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports TESTMODE]
# Left Button (btnL)   -> Synchronous Load Strobe
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports LOAD]

## Address Switches (Register select: 00=Hours, 01=Minutes, 10=Seconds)
# SW0 -> ADDRS[0]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {ADDRS[0]}]
# SW1 -> ADDRS[1]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {ADDRS[1]}]

## Data Input Switches (6-bit binary value: 0 to 59)
# SW2 -> DATA_IN[0]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[0]}]
# SW3 -> DATA_IN[1]
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[1]}]
# SW4 -> DATA_IN[2]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[2]}]
# SW5 -> DATA_IN[3]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[3]}]
# SW6 -> DATA_IN[4]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[4]}]
# SW7 -> DATA_IN[5]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {DATA_IN[5]}]

## Onboard 4-Digit 7-Segment Display (Anodes - Active Low)
# Anode 3 (Leftmost digit: Tens of Hours)
set_property -dict {PACKAGE_PIN W4  IOSTANDARD LVCMOS33} [get_ports {BASYS_ANODE_OUT[3]}]
# Anode 2 (Units of Hours)
set_property -dict {PACKAGE_PIN V4  IOSTANDARD LVCMOS33} [get_ports {BASYS_ANODE_OUT[2]}]
# Anode 1 (Tens of Minutes)
set_property -dict {PACKAGE_PIN U4  IOSTANDARD LVCMOS33} [get_ports {BASYS_ANODE_OUT[1]}]
# Anode 0 (Rightmost digit: Units of Minutes)
set_property -dict {PACKAGE_PIN U2  IOSTANDARD LVCMOS33} [get_ports {BASYS_ANODE_OUT[0]}]

## Onboard 4-Digit 7-Segment Display (Cathodes/Segments CA..CG - Active Low)
# CA (Segment A)
set_property -dict {PACKAGE_PIN W7  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[6]}]
# CB (Segment B)
set_property -dict {PACKAGE_PIN W6  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[5]}]
# CC (Segment C)
set_property -dict {PACKAGE_PIN U8  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[4]}]
# CD (Segment D)
set_property -dict {PACKAGE_PIN V8  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[3]}]
# CE (Segment E)
set_property -dict {PACKAGE_PIN U5  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[2]}]
# CF (Segment F)
set_property -dict {PACKAGE_PIN V5  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[1]}]
# CG (Segment G)
set_property -dict {PACKAGE_PIN U7  IOSTANDARD LVCMOS33} [get_ports {BASYS_SEGMENTS_OUT[0]}]

## External Pmod SSD (Dual 7-Segment Display for Seconds - Common Cathode)
# Pmod Header JXADC / JA / JB Pin Assignments
# Cathode Select (Digit 1 / Digit 2 toggle)
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports SSD_CATHODE_OUT]
# Pmod Segments (Active High: A..G)
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[6]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[5]}]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[4]}]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[3]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[2]}]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[1]}]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {SSD_SEGMENTS_OUT[0]}]

##########################
# Configuration Settings #
##########################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
