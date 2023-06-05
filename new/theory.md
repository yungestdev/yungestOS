# Theory

## How a computer starts up:

        1:
            BIOS (Basic Input Output System) is copied from a ROM chip into RAM
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

### Example


        var: dw 100

            mov ax, var     ; copy offset to ax
            mov ax, [var]   ; copy memory contents

### Another one

        array: dw 100, 200, 300

            mov bx, array       ; copy offset to ax
            mov si, 2 * 2       ; array[2], words are 2 bytes wide

            mov ax, [bx + si]   ; copy memory contents


## The Stack

        - Memory accessed in a FIFO (First In, First Out) manner using push and pop
        - Used to save the return addess when calling functions
        - Growing backwards, must be initialized at the start of the program, otherwise it will over write the OS

## Interrupts

        Signal with makes the processor stop what it's doing in order to handle that signal.

        Can be triggered by:
            1: An exception (e.g. dividing by zero, segmentation fault, page fault)
            2: Hardware (e.g. keyboard key is pressed or released, timer tick, disk controller finished an operation)
            3: Software, through the INT instruction

## Examples of BIOS (Basic Input Output System) Interrupts

        INT 10h -- Video
        INT 11h -- Equipment Check
        INT 12h -- Memory Size
        INT 13h -- Disk I/O
        INT 14h -- Serial communications
        INT 15h -- Cassette
        INT 16h -- Keyboard I/O
    
### BIOS INT 10h

        AH = 00h -- Set Video Mode
        AH = 01h -- Set Cursor Shape
        AH = 02h -- Set Cursor Position
        AH = 03h -- Get Cursor Position & Shape
        ...
        AH = 0Eh -- Write Character in TTY Mode
        ...

#### BIOS INT 10h, AH = 0Eh
        prints a character to the screen in TTY mode.

        AH = 0E
        AL = ASCII character to write
        BH = page number (text modes)
        BL = foreground pixel color (graphics modes)

        returns nothing

        - Cursor advances after write
        - Characters BEL (7), BS (8), LF (A) and CR (D) are treated as control nodes