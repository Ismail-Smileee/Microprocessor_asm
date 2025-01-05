                   ;Largest Number.
.model small
.stack 100h

.data
    msg_input db 10,13, 'Enter a digit: $'
    msg_result db 10, 13, 'The largest digit is: $'
    largest db 0      ; Variable to store the largest digit

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Input first digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    mov bl, al         ; Store the first digit in bl
    mov largest, bl    ; Initialize largest with the first digit

    ; Input second digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    mov bh, al         ; Store the second digit in bh

    ; Compare with largest
    cmp bh, largest
    jg update_largest
    jmp next_input

update_largest:
    mov largest, bh    ; Update largest

next_input:
    ; Input third digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    mov cl, al         ; Store the third digit in cl

    ; Compare with largest
    cmp cl, largest
    jg update_largest_final

    ; Display result message
    mov ah, 9
    lea dx, msg_result
    int 21h

    ; Convert largest to ASCII
    mov al, largest     ; Load largest digit
    add al, 48          ; Convert to ASCII
    mov ah, 2           ; Function to print character
    mov dl, al          ; Load result to DL
    int 21h             ; Print result

    ; Exit program
    mov ah, 4Ch
    int 21h

update_largest_final:
    mov largest, cl    ; Update largest with the third digit
    jmp next_result

next_result:
    ; Display result message
    mov ah, 9
    lea dx, msg_result
    int 21h

    ; Convert largest to ASCII
    mov al, largest     ; Load largest digit
    add al, 48          ; Convert to ASCII
    mov ah, 2           ; Function to print character
    mov dl, al          ; Load result to DL
    int 21h             ; Print result

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
