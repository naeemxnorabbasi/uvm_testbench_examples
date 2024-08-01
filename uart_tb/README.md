# uart_tb - UART TestBench

## Project Structure

- `src/`: Contains source files.
- `testbench/`: Contains UVM testbench files.
  - `sequences/`: Contains transaction and generator sequences.
  - `drivers/`: Contains driver classes.
  - `monitors/`: Contains monitor classes.
  - `scoreboards/`: Contains scoreboard classes.
  - `agents/`: Contains agent classes.
  - `env/`: Contains environment classes.
  - `tests/`: Contains test classes.
- `scripts/`: Contains simulation scripts.

## How to Compile and Run

### Vivado

Run the following command:

cd uart_tb/scripts
source run_xsim.csh

