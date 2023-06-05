; Tell the assembler to load code at address 0x7C00 (Assembler uses this information to calculate label addresses)
org 0x7C00
; Specifying to the Assembler to generate 16-bits code
bits 16


; Creating a macro for the ENDLine Character, so we don't have to remember the HexaDecimal Code each time.
%define ENDL 0x0D, 0x0A

start:
    jmp main 


;
; Prints a string to the screen
; Params:
;   - ds:si points to string
;
puts:
    ; save registers to modify
    push si
    push ax

loop:
    lodsb           ; loads next character in al
    or al, al       ; verify if next character is null?
    jz done
    

    mov ah, 0x0e    ; call BIOS interrupt
    mov bh, 0       ; set page number to 0
    int 0x10

    jmp loop
done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0           ; can't write to ds/es directly
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ; stack grows downwards from where we loaded in memory

    ; print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt


msg_hello: db 'Hello World!', ENDL, 0

; Padding program up to 510 Bytes ($-$$ = Size of program so far (in bytes) )
times 510-($-$$) db 0
; Declare signature (For the BIOS booting)
dw 0AA55h