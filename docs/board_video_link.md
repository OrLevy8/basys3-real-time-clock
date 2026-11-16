# Hardware Demonstration Video

This document contains the recording and demonstration details for the Real-Time Clock implemented on the Digilent Basys 3 FPGA board.

## Video Access Link
- **SharePoint Link:** [Basys 3 Real-Time Clock Hardware Demonstration](https://gjctacil-my.sharepoint.com/:v:/g/personal/orlev_g_jct_ac_il/EeOraA01wDtKiLFiv6LwWPYBSL3SGPeE2fRB4Dj4Snh_vQ?e=jtXFVR)

## Demonstration Outline
1. **FPGA Bitstream Programming:**
   - Loading the bitstream via Vivado Hardware Manager.
   - Initial reset state and default display activation.
2. **Time Setting via Switches & Buttons:**
   - Selecting target register (`ADDRS[1:0]`): Hours, Minutes, Seconds.
   - Configuring target value (`DATA_IN[5:0]`) via slide switches SW2-SW7.
   - Strobe loading with button `LOAD` (btnL).
3. **Minute Rollover Verification:**
   - Setting time to `09:35:54` and witnessing smooth rollover to `09:36:00`.
4. **24-Hour Midnight Rollover Verification:**
   - Setting time to `23:59:54` and witnessing rollover to `00:00:00`.
5. **Test Mode vs. Real-Time Mode:**
   - Fast clocking with `TESTMODE = 1` for rapid verification of cascade counting.
   - Switching to `TESTMODE = 0` for standard 1 Hz wall-clock operation.
