# ==============================================================================
# Vivado Batch Build Script (Non-Project Mode)
# Target: Digilent Basys 3 (xc7a35tcpg236-1)
# ==============================================================================

set outputDir ./build_output
file mkdir $outputDir

# 1. Read VHDL Source Files
read_vhdl ../src/REAL_CLK5.vhd
read_vhdl ../src/CLK_CNTR.vhd
read_vhdl ../src/DECODER.vhd
read_vhdl ../src/BIN_TO_BCD.vhd
read_vhdl ../src/BCD_TO_7SEGMENT.vhd
read_vhdl ../src/BCD_TO_7SEGMENT_PMOD_SSD.vhd

# 2. Read Constraints
read_xdc ../constrs/basys3_master.xdc

# 3. Synthesize Design
synth_design -top REAL_CLK5 -part xc7a35tcpg236-1
write_checkpoint -force $outputDir/post_synth.dcp
report_utilization -file $outputDir/post_synth_util.rpt

# 4. Implementation (Opt, Place, Route)
opt_design
place_design
report_io -file $outputDir/io_placed.rpt
report_utilization -file $outputDir/utilization_placed.rpt
write_checkpoint -force $outputDir/post_place.dcp

route_design
write_checkpoint -force $outputDir/post_route.dcp
report_timing_summary -file $outputDir/timing_summary_routed.rpt

# 5. Generate Bitstream
write_bitstream -force $outputDir/REAL_CLK5.bit
puts "Build completed successfully! Bitstream saved to $outputDir/REAL_CLK5.bit"
