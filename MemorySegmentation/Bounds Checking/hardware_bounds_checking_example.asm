section .data
    array db 1, 2, 3, 4, 5
    array_size equ $ - array

section .text
    global _start

_start:
    mov ecx, 6          ; Attempt to access the 6th element
    cmp ecx, array_size ; Compare index with the array size
    ja out_of_bounds    ; Jump if index is out of bounds

    ; Safe access
    mov al, [array + ecx]
    ; Do something with the value

out_of_bounds:
    ; Handle the error (this is just an example, real handling might differ)
    ; Normally, the system would raise an exception or similar.
    mov eax, 1          ; sys_exit
    int 0x80            ; Trigger exit
