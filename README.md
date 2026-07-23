# UART-Controlled 16x2 LCD

## Overview

This project implements a UART-controlled 16x2 LCD interface in Verilog HDL. Characters received through UART are displayed on a standard 16x2 LCD in real time.

The design was implemented and hardware validated on the Nexys A7 (Artix-7 100T) FPGA board using Xilinx Vivado.

## Features

- UART Receiver (9600 baud)
- 16x2 LCD Interface
- 8-bit LCD Data Mode
- Finite State Machine (FSM) Based Controller
- Automatic Cursor Movement
- Automatic Second Line Transition
- Hardware Validation using Tera Term

## Hardware

- FPGA Board: Nexys A7 (Artix-7 100T)
- 16x2 Character LCD

## Tools Used

- Verilog HDL
- Xilinx Vivado 2019.2
- Tera Term

## Project Structure

```text
rtl/
constraints/
images/
```

## Results

The design successfully receives ASCII characters through UART and displays them on the LCD. After filling the first row, the cursor automatically moves to the second row.

## Future Improvements

- LCD Busy Flag Support
- Backspace Support
- Scrolling Text
- Custom Character Generation
