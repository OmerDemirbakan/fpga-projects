# Traffic Light Controller (Verilog)

A 4-state traffic light controller with a different duration for each light, written in Verilog and verified in simulation.

## Sequence

RED → RED+YELLOW → GREEN → YELLOW → RED 

| State       | Lights on   | Cycles |
|-------------|-------------|--------|
| RED         | red         | 5      |
| RED+YELLOW  | red, yellow | 1      |
| GREEN       | green       | 5      |
| YELLOW      | yellow      | 2      |

One full cycle = 13 clock cycles.

## How it works

A `counter` counts clock cycles. Each state has a target value, `duration`. When `counter` reaches `duration`, the counter resets to 0 and the FSM moves to the next state. A state therefore lasts `duration + 1` clock cycles.

## Waveform

You can find docs/waveform.png in repo


## Files

- `rtl/traffic_light.v`: the design
- `tb/tb_traffic_light.v`: testbench (generates the clock, applies reset, dumps `dump.vcd`)

## How to run

1. Open [EDA Playground](https://edaplayground.com).
2. Select **Icarus Verilog** as the simulator.
3. Paste `traffic_light.v` into the design window and `tb_traffic_light.v` into the testbench window.
4. Enable **Open EPWave after run**, then press **Run**.

## What I learned

- I started by learning the fundamentals of logic design, and I wanted to test myself, so I built this simple learning project.
- My first version had no counter: the light simply changed state on every clock cycle. I then upgraded it with a counter and a separate duration for each light, which made it behave more like a real-world traffic light.
- Waveforms were very important for understanding this design. They let me inspect the signals, find mistakes and fix them quickly.

## Next steps

- Self-checking testbench
- Run on a real FPGA board (with a clock divider)
