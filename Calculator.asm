.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter first number: $'
    MSG2 DB 'Enter second number: $'
    MSG3 DB 'The result is: $'
    MSG4 DB 'Choose an operation: $'
    MSG5 DB '1. Add $'
    MSG6 DB '2. Subtract $'
    MSG7 DB '3. Multiply $'
    MSG8 DB '4. Divide $'
    MSG9 DB 'Invalid choice. Please choose again.$'
    NUM1 DB ?
    NUM2 DB ?
    RESULT DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX    ; Initialize data segment

    ; Display options
    LEA DX, MSG4
    MOV AH, 09h
    INT 21h

    LEA DX, MSG5
    MOV AH, 09h
    INT 21h

    LEA DX, MSG6
    MOV AH, 09h
    INT 21h

    LEA DX, MSG7
    MOV AH, 09h
    INT 21h

    LEA DX, MSG8
    MOV AH, 09h
    INT 21h

    ; Ask user to choose an operation
    LEA DX, MSG4
    MOV AH, 09h
    INT 21h

    MOV AH, 01h    ; Read user input
    INT 21h        ; Get user input for operation choice
    SUB AL, 30h    ; Convert ASCII to integer
    MOV BL, AL     ; Store the choice in BL

    ; Ask for the first number
    LEA DX, MSG1
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h        ; Get the first number
    SUB AL, 30h    ; Convert ASCII to integer
    MOV NUM1, AL   ; Store the number in NUM1

    ; Ask for the second number
    LEA DX, MSG2
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h        ; Get the second number
    SUB AL, 30h    ; Convert ASCII to integer
    MOV NUM2, AL   ; Store the number in NUM2

    ; Perform operation based on the choice
    CMP BL, 1      ; Check if the choice is 1 (Add)
    JE ADDITION

    CMP BL, 2      ; Check if the choice is 2 (Subtract)
    JE SUBTRACTION

    CMP BL, 3      ; Check if the choice is 3 (Multiply)
    JE MULTIPLICATION

    CMP BL, 4      ; Check if the choice is 4 (Divide)
    JE DIVISION

    ; If invalid choice
    LEA DX, MSG9
    MOV AH, 09h
    INT 21h
    JMP MAIN       ; Go back to the main menu

ADDITION:
    MOV AL, NUM1
    ADD AL, NUM2   ; Add NUM1 and NUM2
    MOV RESULT, AL

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    ADD AL, 30h    ; Convert result to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h        ; Display result
    JMP EXIT

SUBTRACTION:
    MOV AL, NUM1
    SUB AL, NUM2   ; Subtract NUM2 from NUM1
    MOV RESULT, AL

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    ADD AL, 30h    ; Convert result to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h        ; Display result
    JMP EXIT

MULTIPLICATION:
    MOV AL, NUM1
    MOV BL, NUM2
    MUL BL          ; Multiply NUM1 and NUM2 (result in AX)
    MOV RESULT, AL

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    ADD AL, 30h    ; Convert result to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h        ; Display result
    JMP EXIT

DIVISION:
    MOV AL, NUM1
    MOV BL, NUM2
    DIV BL          ; Divide NUM1 by NUM2 (quotient in AL)
    MOV RESULT, AL

    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    ADD AL, 30h    ; Convert result to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h        ; Display result
    JMP EXIT

EXIT:
    MOV AH, 4Ch     ; Exit program
    INT 21h

MAIN ENDP
END MAIN
