# ✖ High-Performance-Multipliers

A study and implementation of high-performance binary multiplier architectures, focusing on how different multiplication strategies translate into hardware.
The primary characterization uses the `Sky130 HD` standard-cell library

## 🛠️ Tools & Technologies

![Icarus Verilog](https://img.shields.io/badge/Icarus_Verilog-Simulation-1E88E5?style=flat-square)
![GTKWave](https://img.shields.io/badge/GTKWave-Waveforms-F57C00?style=flat-square)
![Yosys](https://img.shields.io/badge/Yosys-Synthesis-43A047?style=flat-square)
![OpenSTA](https://img.shields.io/badge/OpenSTA-Static_Timing_Analysis-8E24AA?style=flat-square)
![Sky130HD](https://img.shields.io/badge/Sky130HD-Primary_Characterization-455A64?style=flat-square)

## 🔬 Physical Characterization
The following table summarizes post-synthesis implementation results obtained using the Sky130 HD standard-cell library.

> Sky130HD

| Module | Area (µm²) | Fmax (MHz) | Critical Path (ns) | Power (µW) | ADP (µm²·ns) | PDP (µW·ns) |
|---|---|---|---|---|---|---|
| [SHA](./SHA) | 9266.3872 | ~161.3 | 6.20 | 807 | 57449.60 | 5003.40 |
| [BAM](./BAM) | 36198.4672 | ~29.17 | 34.28 | 523000 | 1240883.46 | 17928440 |
| [WTM](./WTM) | 40904.2304 | ~73.20 | 13.66 | 159000 | 558751.79 | 2171940 |
| [DTM](./DTM) | 40322.4224 | ~176.99 | 5.65 | 154000 | 227821.69 | 870100 |

> Note: SHA, WTM, and DTM results shown above use a **64-bit Kogge-Stone Adder (KSA)** as the final carry-propagate adder. A 64-bit Ripple-Carry Adder (RCA) implementation was also evaluated to characterize the impact of the final carry-propagation architecture. RCA results are documented in the respective architecture folders.

## ⚡ Latency & Throughput Analysis
Because the evaluated multiplier architectures use different execution models, Fmax alone does not fully describe multiplication performance. Iterative architectures perform one multiplication over multiple clock cycles, while combinational architectures produce one result per operation.

| Architecture | Cycles / Multiplication | Latency / Multiplication | Multiplications / Second |
|---|----|--- |--- |
| Shift-and-Add Multiplier| 32 | 198.4 ns | ~5.04 Million/s |
| Braun Array Multiplier | 1 | 34.28 ns | ~29.17 Million/s |
| Wallace Tree Multiplier | 1 | 13.66 ns | ~73.20 Million/s |
| Dadda Tree Multiplier | 1 | 5.65 ns | ~176.99 Million/s |

### Relative Performance
> Baseline: Shift-and-Add Multiplier

| Architecture | Area | Fmax | Power | Latency / M | M / Second | ADP | PDP |
|---|---|---|---|---|---|---|---|
| Shift-and-Add Multiplier | 1.00× | 1.00× | 1.00× | 1.00× | 1.00× | 1.00× | 1.00× |
| Braun Array Multiplier | 3.91× | 0.18× | 648.08× | **0.17×** | **5.79×** | 21.60× | 3583.25× |
| Wallace Tree Multiplier | 4.41× | 0.45× | 197.03× | **0.069×** | **14.52×** | 9.73× | 434.09× |
| Dadda Tree Multiplier | 4.35× | 1.10× | 190.83× | **0.028×** | **35.12×** | 3.97× | 174.00× |

# 📜License
- Source code and HDL files are licensed under the MIT License.
- Documentation, diagrams, images, and PDFs are licensed under Creative Commons Attribution 4.0 (CC BY 4.0).
