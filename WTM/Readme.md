# Wallace Tree Multiplier (WTM)
The Wallace Tree reduces the 32 × 32 partial-product matrix through successive Half Adder (HA) and Full Adder (FA) compression stages to produce two final rows.

Two implementations use different final carry-propagate adders: a 64-bit Ripple-Carry Adder (RCA) and a 64-bit Kogge-Stone Adder (KSA), allowing the impact of parallel-prefix carry 
computation on multiplier PPA and timing to be characterized.

<p align="center">
  <img src="images/wtm_waveform.png" width="1000"/>
  <br>
  <sub>32-Bit Wallace Tree Multiplication</sub>
</p>

## Features

- 32-bit × 32-bit unsigned multiplication
- Combinational Wallace Tree architecture
- 1024 partial products
- Multi-stage HA/FA partial-product reduction
- 64-bit product
- 64-bit final carry-propagate adder
- RCA and KSA final-adder implementations

## Synthesis Results

Technology: Sky130 HD  
Tool: Yosys

| Metric | Wallace + RCA | Wallace + KSA |
|---|--- |--- |
| Width | 32 × 32-bit | 32 × 32-bit |
| Product Width | 64-bit | 64-bit |
| Area | 31911.856 µm² | 40904.2304 µm² |

## Static Timing Analysis

| Metric | Wallace + RCA | Wallace + KSA |
|---|---|---|
| Critical Path | 18.53 ns | 13.66 ns |
| Estimated Fmax | ~53.97 MHz | ~73.20 MHz |

## Power

| Metric | Wallace + RCA | Wallace + KSA |
|---|---|---|
| Total Power | 117 mW | 159 mW |

## Latency & Throughput

| Metric | Wallace + RCA | Wallace + KSA |
|---|--- |--- |
| Cycles / Multiplication | 1 | 1 |
| Critical Path | 18.53 ns | 13.66 ns |
| Estimated Fmax | ~53.97 MHz | ~73.20 MHz |
| Latency / Multiplication | 18.53 ns | 13.66 ns |
| Throughput | ~53.97 M/s | ~73.20 M/s |
