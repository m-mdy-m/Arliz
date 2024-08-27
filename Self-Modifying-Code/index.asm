section .data
    ; Define an array with an initial NOP (0x90) instruction
    code_array db 0x90  ; NOP (No Operation) instruction
    msg db 'Initial: 0x90, Modified: ', 0

section .bss
    hex_buffer resb 8   ; Buffer to hold hexadecimal representation

section .text
    global _start

_start:
    ; Write the initial value of code_array (0x90) to stdout
    mov rax, 1         ; SYS_write system call number
    mov rdi, 1         ; File descriptor 1 is stdout
    mov rsi, msg       ; Address of the message
    mov rdx, 16        ; Length of the message
    syscall            ; Call kernel

    ; Convert initial value to hexadecimal and print
    mov rax, [code_array]    ; Load the byte from code_array
    call byte_to_hex          ; Convert byte to hex string

    ; Print the hexadecimal representation of the initial value
    mov rax, 1         ; SYS_write system call number
    mov rdi, 1         ; File descriptor 1 is stdout
    mov rsi, hex_buffer   ; Address of the hexadecimal buffer
    mov rdx, 2         ; Length of the hexadecimal string
    syscall            ; Call kernel

    ; Modify the instruction in code_array to a different instruction
    mov byte [code_array], 0xCC

    ; Convert modified value to hexadecimal and print
    mov rax, [code_array]    ; Load the modified byte from code_array
    call byte_to_hex          ; Convert byte to hex string

    ; Print the hexadecimal representation of the modified value
    mov rax, 1         ; SYS_write system call number
    mov rdi, 1         ; File descriptor 1 is stdout
    mov rsi, hex_buffer   ; Address of the hexadecimal buffer
    mov rdx, 2         ; Length of the hexadecimal string
    syscall            ; Call kernel

    ; Exit the program
    mov rax, 60        ; SYS_exit system call number
    xor rdi, rdi       ; Return code 0
    syscall            ; Call kernel

; Function to convert a byte to hexadecimal string
byte_to_hex:
    mov rbx, rax            ; Copy byte to rbx
    shr rbx, 4              ; Shift right to get the high nibble
    and rbx, 0x0F           ; Mask out the high nibble
    add rbx, '0'            ; Convert to ASCII
    cmp rbx, '9'            ; Check if it's greater than '9'
    jbe .skip_high
    add rbx, 7              ; Adjust ASCII code for 'A'-'F'
.skip_high:
    mov [hex_buffer], rbx   ; Store high nibble in buffer
    mov rbx, rax            ; Copy byte to rbx
    and rbx, 0x0F           ; Mask out the low nibble
    add rbx, '0'            ; Convert to ASCII
    cmp rbx, '9'            ; Check if it's greater than '9'
    jbe .skip_low
    add rbx, 7              ; Adjust ASCII code for 'A'-'F'
.skip_low:
    mov [hex_buffer+1], rbx ; Store low nibble in buffer
    ret
