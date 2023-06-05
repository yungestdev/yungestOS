



; Tell the assembler to load code at address 0x7C00 (Assembler uses this information to calculate label addresses)
org 0x7C00
; Specifying to the Assembler to generate 16-bits code
bits 16



main:
    hlt

.halt:
    jmp .halt


; Padding program up to 510 Bytes ($-$$ = Size of program so far (in bytes) )
times 510-($-$$) db 0
; Declare signature (For the BIOS booting)
dw 0AA55h