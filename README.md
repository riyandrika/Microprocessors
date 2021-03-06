# Academic Projects for EE3002 Microprocessors

Third-year Undergraduate Course at Electrical & Electronic Engineering, Nanyang Technological University

Instructed by Gan Woon Seng, Professor of Audio Engineering

This course gave a solid foundation in microprocessor development, specifically for ARM7 processors. There was strong emphasis on low-level programming with Assembly and C programming to perform tasks in a microprocessor.

Scope of course: 
1. Programmer's Model, Assembler Directives
2. Load, Store & Addressing
3. Logic & Arithmetic, Flow Control Instructions
4. Stacks, Subroutines & Exception Handling
5. THUMB Instructions
6. C Programming & Inline Assembly
7. Peripherals Interfacing

## Task: Temperature Conversion
We were tasked to write a program to convert temperature values between Celsius & Fahrenheit in assembly language.

Additionally we had to process data and perform conversions across different Q-formats for 32-bit floating points.

Refer to [CelsiusToFahrenheit.s](CelsiusToFahrenheit.s) and [FahrenheitToCelsius.s](FahrenheitToCelsius.s)

## Task: Digital Filtering
Given an equation for a digital filter, we were to execute the arithmetic operations by memory access in read-write RAM address space of the processor. The data to be passed into the digital filter is stored in a known address in a stack.

Subsequently, we had to perform more tasks using THUMB instructions, the more lightweight 16-bit version of ARM instructions.

Refer to [DigitalFilter.s](DigitalFilter.s), [DigitalFilterTHUMB.s](DigitalFilterTHUMB.s) and [DigitalFilterExtended.s](DigitalFilterExtended.s)
