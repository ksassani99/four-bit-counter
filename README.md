# 4-bit Verilog Counter

A 4-bit synchronous counter written in Verilog demonstrating RTL design, simulation, waveform analysis, and testbench creation using Icarus Verilog and Surfer.

## Project Structure
counter4.v        # RTL design (4-bit counter)
tb_counter4.v     # Testbench

## Design Overview
This design implements a 4-bit synchronous up-counter with:
- 4-bit output count with `count[3:0]`
- Active-low reset with `reset_n`
- Clocked behavior on `posedge clk`
- Enable control with `enable`
- Overflow flag with `overflow` when count reaches 15 (max for 4-bit)

## Simulation
### Compile
`iverilog -o sim counter4.v tb_counter4.v`

### Run
`vvp sim`

This produces `tb_counter.vcd` which you can open in Surfer.

## Viewing Waveforms in Surfer
### Open Surfer
`surfer tb_counter4.vcd`

### Waveform Results
Waveform confirms the counter behaves correctly:

- **Reset (0-20 ns)
`reset_n` is low, which keeps `count = 0` regardless of clock or enable.

- **Reset Released (at 20 ns)
`reset_n` goes high, which starts incrementing the counter on the next rising clock edge since `enable` is high.

- **Counting (20-220 ns)
`count` increases by 1 on every rising clock edge (values shown as hexadecimal on waveform)

- **Enable Inactive (at 220 ns)
`enable` goes low, which stops incrementing `count`.

- **Overflow
`overflow` goes high when `count = 15`, indicating max value for 4-bit.

- **Wrap-Around
After reaching 15, the 4-bit output rolls over to 0 on the next rising clock edge.

## Testbench Overview
The testbench provides:
- A 10 ns clock with `always #5 clk = ~clk` (10 ns period, clock inverted every 5 ns)
- `$dumpfile` and `$dumpvars` for VCD generation
- Reset and enable sequencing