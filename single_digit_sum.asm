;Three Number Sum.
.model small
.stack 100h

.data
    msg_input db 'Enter a digit: $'
    msg_result db 10, 13, 'The sum is: $'
    sum db 0           ; Variable to store the sum

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Initialize sum to 0
    xor al, al         ; Clear AL
    mov sum, al        ; Set initial sum to 0

    ; Input first digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    add sum, al        ; Add to sum

    ; Input second digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    add sum, al        ; Add to sum

    ; Input third digit
    mov ah, 9
    lea dx, msg_input
    int 21h
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    add sum, al        ; Add to sum

    ; Display result message
    mov ah, 9
    lea dx, msg_result
    int 21h

    ; Convert sum to ASCII
    mov al, sum        ; Load sum
    add al, 48         ; Convert to ASCII
    mov ah, 2          ; Function to print character
    mov dl, al         ; Load result to DL
    int 21h            ; Print result

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
