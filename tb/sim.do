vlib work
vcom REAL_CLK5.vhd
vcom DECODER.vhd
vcom CLK_CNTR.vhd
vcom BIN_TO_BCD.vhd
vcom BCD_TO_7SEGMENT_PMOD_SSD.vhd
vcom BCD_TO_7SEGMENT.vhd
vcom TB_REAL_CLK5_A.vhd
vsim -voptargs=+acc=lprn TB_REAL_CLK5_A