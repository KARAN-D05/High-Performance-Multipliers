# Radix-4 Booth Encoder

A parameterized radix-4 Booth encoder for signed two's-complement multiplication.
The encoder examines overlapping groups of three multiplier bits and converts them into Booth digits representing `0`, `±1`, or `±2`. Radix-4 encoding reduces the number of partial-product rows by approximately half compared with conventional binary multiplication.

## Booth Encoding

Each Booth digit is generated from an overlapping group of three multiplier bits:

```text
{q[2i+1], q[2i], q[2i-1]}
```

with `q[-1] = 0`.

The encoding is:

| Bits | Booth Digit | Operation |
| ---- | ----------  | --------- |
| 000  |           0 | 0         |
| 001  |          +1 | +M        |
| 010  |          +1 | +M        |
| 011  |          +2 | +2M       |
| 100  |          -2 | -2M       |
| 101  |          -1 | -M        |
| 110  |          -1 | -M        |
| 111  |           0 | 0         |

For a 64-bit multiplier, the encoder produces **32 Booth digits**, reducing the conventional 64 partial-product rows to 32.

## Synthesis Results

Technology: Sky130 HD
Tool: Yosys

| Metric                 | Radix-4 Booth Encoder |
| ---------------------- | --------------------  |
| Multiplier Width       |                64-bit |
| Number of Booth Digits |                    32 |
| Booth Digit Width      |                 3-bit |
| Output Width           |                96-bit |
| Area                   |          864.5792 µm² |

## Static Timing Analysis

| Metric         | Radix-4 Booth Encoder |
| -------------- | --------------------  |
| Critical Path  |               0.18 ns |
| Estimated Fmax |             ~5.56 GHz |
