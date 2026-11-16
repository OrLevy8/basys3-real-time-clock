@echo off
REM ==============================================================================
REM Script to run ModelSim simulation for Basys 3 Real-Time Clock
REM ==============================================================================

echo [INFO] Starting ModelSim Simulation...
cd /d "%~dp0..\tb"

if exist "sim_exp1.do" (
    vsim -do sim_exp1.do
) else (
    vsim -do do.do
)

pause
