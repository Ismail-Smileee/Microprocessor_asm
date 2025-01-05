ORG 100h    ; Code starts at offset 100h

START:
    ; Ask for card number
    MOV DX, OFFSET cardMsg
    CALL print_string
    CALL scan_num
    MOV DX, AX            ; Store entered card number in DX

    ; Ask for password
    MOV DX, OFFSET passMsg
    CALL print_string
    CALL scan_num
    MOV BX, AX            ; Store entered password in BX

    ; Initialize search
    MOV SI, OFFSET passwords
    MOV CX, 20            ; Number of entries in arrays
    MOV DI, OFFSET cardNumbers

    ; Search for card number in cardNumbers array
    MOV AX, DX
    CLD                   ; Clear direction flag
search_loop:
    MOV DX, [DI]          ; Load card number from array
    CMP AX, DX            ; Compare with entered card number
    JE  FOUND
    ADD DI, 2             ; Move to next card number (2 bytes per word)
    LOOP search_loop

DENIED:
    ; Access Denied Message
    MOV DX, OFFSET deniedMsg
    CALL print_string
    JMP START             ; Restart the program

FOUND:
    ; Calculate password offset
    MOV DX, 20            ; Total size in words
    SUB DX, CX            ; DX = 20 - CX (index of found card)
    SHL DX, 1             ; Multiply by 2 (each entry is 2 bytes)
    ADD SI, DX            ; Move SI to corresponding password entry

    ; Compare passwords
    MOV DL, [SI]
    CMP DL, BL            ; Compare entered password with stored one
    JNE DENIED            ; If not equal, deny access

ALLOWED:
    ; Access Granted Message
    MOV DX, OFFSET allowedMsg
    CALL print_string                                  1100
    111
    INT 20h               ; Terminate program

; Input number procedure (reads up to 5 digits)
scan_num:
    XOR AX, AX            ; Clear AX
    MOV CX, 0
scan_loop:
    MOV AH, 1             ; BIOS Input function
    INT 21h               ; Get input character in AL
    CMP AL, 0Dh           ; Check if Enter key
    JE  scan_done
    SUB AL, '0'           ; Convert ASCII to digit
    MUL CX                ; AX = AX * 10
               ; Add digit to AX
    MOV CX, 10            ; Prepare multiplier
    JMP scan_loop
scan_done:
    RET

; Print string procedure
print_string:
    MOV AH, 09h           ; BIOS print string function
    INT 21h
    RET

; Data section
cardMsg      DB 'Enter card number (0-65535): $'
passMsg      DB 'Enter password (0-15): $'
deniedMsg    DB 13, 10, 'DENIED. Invalid credentials.', 13, 10, '$'
allowedMsg   DB 13, 10, 'ALLOWED. Access granted.', 13, 10, '$'

cardNumbers  DW 1100H, 1101H, 1102H, 1103H, 1104H, 1105H, 1106H, 1107H, 1108H, 1109H
             DW 110AH, 110BH, 110CH, 110DH, 110EH, 110FH, 1110H, 1111H, 1112H, 1113H

passwords    DB 1H, 5H, 7H, 0CH, 0FH, 2H, 9H, 4H, 0DH, 3H
             DB 0BH, 0AH, 8H, 0EH, 0H, 6H, 5H, 0FH, 7H, 0CH

END START
