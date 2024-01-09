; this sample prints out a hex value of DL register.
org 100h
mov dl, 8Ah
; load address of data table in bx, for xlat instruction:lea bx, table  
; xlat does the following:; al = ds:[bx + unsigned al]
mov al, dlshr al, 4 ; leave high part only.xlat ; get hex digit. mov ah, 0eh ; teletype sub-function.int 10h

mov al, dland al, 0fh ; leave low part only.xlat ; get hex digit.     mov ah, 0eh ; teletype sub-function.int 10h
; wait for any key press:mov ah, 0int 16h

ret
table db '0123456789abcdef'





org 100h
main proc nearmov ah,09hmov dx,offset messageint 21h
mov ah,4chmov al,00int 21h       endp        message db "Hello World!$"        end main
ret