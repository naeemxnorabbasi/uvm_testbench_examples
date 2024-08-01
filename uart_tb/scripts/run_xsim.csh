#!/bin/csh -f

# Capture the start time
start_time=$(date +%s)
echo "Simulation started at: $(date)"

# Run the simulation
xvlog -sv -f uart_filelist.f -L uvm ; 
xelab uart_tb -relax -s top -timescale 1ns/1ps;  
xsim top -testplusarg UVM_TESTNAME=test -testplusarg UVM_VERBOSITY=UVM_LOW -runall 

# Capture the end time
end_time=$(date +%s)
echo "Simulation ended at: $(date)"

# Calculate the runtime
runtime=$((end_time - start_time))
echo "Total simulation runtime: $runtime seconds"
