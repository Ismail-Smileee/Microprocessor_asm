;ID:2215151116(5c1)
;Name:Ismail Hossain Shifat

.model small
.stack 100h
.data 
    msg1 db "Enter the first number: $"  
    msg2 db 10,13, "Enter the second number: $"   
    msg3 db 10,13, "The sub: $"  
 .code
    

main proc
    mov ax,@data
    mov ds,ax
    
    ;msg 1
    mov ah,9
    mov dx,offset msg1
    int 21h 
    
    ;take first input
    mov ah,1
    int 21h
    mov bl,al
    
    ;msg 2
    mov ah,9
    mov dx,offset msg2
    int 21h 
    
    ;take second input
    mov ah,1
    int 21h
    mov bh,al
              
    ;msg 3
    mov ah,9
    mov dx,offset msg3
    int 21h 
    
    ;code for subtraction
    sub bl,bh
    add bl,48
    
    ;result print
    mov ah,2
    mov dl,bl
    int 21h
    
    main endp
end main
    