# UVM TestBench Examples

- `README.md` - this file
- `add_tb` - Adder
- `apb_ram_tb` - RAM with APB interface
- `axi_ram_tb` - RAM with AXI interface
- `dff_tb` - D Flip-Flop 
- `i2c_tb` - I2C interface
- `mul_tb` - Multiplier
- `ram_tb` - RAM 
- `spi_ram_tb` - RAM with SPI interface
- `uart_tb` - UART interface
- `virtual_sequencer_tb` - Demonstrates the use of virtual sequencer
- `tlm_analysis_fifo_tb` - Demonstrates use of TLM analysis FIFO


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

```sh
cd scripts
source run_xsim.csh
