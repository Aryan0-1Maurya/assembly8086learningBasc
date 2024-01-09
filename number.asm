.model small
.data
 no db 10
.code
   mov ax, @data  
   mov ds, ax
   mov cl, no
   mov al, no
   mul cl
   mov bx, 00

; convert the hex value in cl to decimal
 p1: cmp al, 64h    
   jc p2
   sub al, 64h
   inc bl
   jmp p1
 p2: cmp al, 0ah
   jc p3
   sub al, 0ah
   inc bh
   jmp p2
 p3:
   mov ah, 02h
   add bl, 30h
   mov dl, bl
   int 21h
   mov ah, 02h
   add bh, 30h
   mov dl, bh
   int 21h
   mov ah, 02h
   add cl, 30h
   mov dl, al
   int 21h
   mov ah, 4ch
   int 21h
end