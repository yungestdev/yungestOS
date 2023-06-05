# Theory

## How a computer starts up:

        1:
            BIOS is copied from a ROM chip into RAM
        2:
            BIOS starts executing code
                - initializes hardware
                - runs some test (POST = power-on self test)
        3:
            BIOS searches for an Operating System to start
        4:
            BIOS loads and starts the operating system
        5:
            Operating System runs
 
# How the BIOS finds an OS
 
### Legacy booting:
        - BIOS loads first sector of each bootable device into memory (at address location 0x7C00)
        - BIOS checks for 0xAA55 signature
        - If found, it starts executing code
### EFI booting:
        - BIOS look into special EFI partitions
        - Operatins system must be compiled as an EFI program
 
# Memory Segmentation:
        0x1234:0x5678
        segments:offset
 
## Registers to specify active segments:
        CS - Currently running segment
        DS - Data segment
        SS - Stack segment
        ES, FS, GS - Extra (data) segment
 
## Referencing a memory location
 
        segment:[base + index * scale + displacement] (offset)
    
        All fields are optional:
            segment: CS, DS, ES, FS, GS, SS (DS if unspecified)
            base: (16 bits) BP/BX
                (32/64 bits) any general purpose register
            index: (16hbits) SI/DI
                (32/64 bits) any general purpose register
            scale (32/64 bits only) 1, 2, 4 or 8
            displacement: a (signed) constant value

## Example
        ```asm

            var: dw 100

                mov ax, var     ; copy offset to ax
                mov ax, [var]   ; copy memory contents
        ```