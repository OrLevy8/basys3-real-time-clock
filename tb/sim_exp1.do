# ==============================================================================
# ModelSim Simulation Script - Experiment 1 (Hours -> Minutes -> Seconds)
# ==============================================================================

vlib work

# Compile source files
vcom -93 -work work ../src/REAL_CLK5.vhd
vcom -93 -work work ../src/DECODER.vhd
vcom -93 -work work ../src/CLK_CNTR.vhd
vcom -93 -work work ../src/BIN_TO_BCD.vhd
vcom -93 -work work ../src/BCD_TO_7SEGMENT_PMOD_SSD.vhd
vcom -93 -work work ../src/BCD_TO_7SEGMENT.vhd

# Compile testbench
vcom -93 -work work TB_REAL_CLK5_A.vhd

# Launch simulation
vsim -voptargs=+acc=lprn TB_REAL_CLK5_A

# Add Waveforms
add wave -noupdate -divider "Control & Clocks"
add wave -noupdate /TB_REAL_CLK5_A/tb_CLK
add wave -noupdate /TB_REAL_CLK5_A/tb_RESET
add wave -noupdate /TB_REAL_CLK5_A/tb_TESTMODE
add wave -noupdate /TB_REAL_CLK5_A/tb_LOAD
add wave -noupdate -radix binary /TB_REAL_CLK5_A/tb_ADDRS
add wave -noupdate -radix unsigned /TB_REAL_CLK5_A/tb_DATA_IN

add wave -noupdate -divider "Internal Counters"
add wave -noupdate -radix unsigned /TB_REAL_CLK5_A/DUT/U1/Q_HOURS
add wave -noupdate -radix unsigned /TB_REAL_CLK5_A/DUT/U1/Q_MINUTES
add wave -noupdate -radix unsigned /TB_REAL_CLK5_A/DUT/U1/Q_SECONDS

add wave -noupdate -divider "Display Outputs"
add wave -noupdate -radix binary /TB_REAL_CLK5_A/tb_BASYS_ANODE_OUT
add wave -noupdate -radix binary /TB_REAL_CLK5_A/tb_BASYS_SEGMENTS_OUT
add wave -noupdate /TB_REAL_CLK5_A/tb_SSD_CATHODE_OUT
add wave -noupdate -radix binary /TB_REAL_CLK5_A/tb_SSD_SEGMENTS_OUT

run 200 ns
wave zoomfull
