DATA SEGMENT        MSG DB 'HELLO'    CNT EQU $-MSG    SRC EQU 'E' ;CHARACTER TO SEARCH        MSG1 DB 10,13,'CHARACTER FOUND$'    MSG2 DB 10,13,'CHARACTER NOT FOUND$'    DATA ENDS
CODE SEGMENT                              ASSUME CS:CODE,DS:DATA,ES:DATA        START:                 MOV AX,DATA        MOV DS,AX        MOV ES,AX        LEA SI,MSG        MOV AL,SRC        MOV CL,CNT        MOV CH,00H        CLD        UP: SCASB            JZ DOWN        LOOP UP        LEA DX,MSG2        MOV AH,09H        INT 21H        JMP EXIT         DOWN: LEA DX,MSG1            MOV AH,09H        INT 21H            EXIT: MOV AH,4CH                INT 21H        CODE ENDSEND START






CODE SEGMENT    ASSUME: CS:CODE    MAINP:     MOV CX,1AH    MOV DL,41HNEXTC:    MOV AH,02H    INT 21H      INC DL    LOOP NEXTC        MOV AX, 4C00H    INT 21H    CODE ENDSEND MAINP






org 100h
main proc near    mov dx,offset message ; String in dx    call stringLength ; returns length in cx    mov ax,cx           mov si,offset strHextToAsc ; Convert Length to ascii    call hexToAsc
    mov ah,09 ; Display Length    mov dx,offset strHextToAsc    int 21h             mov ah,4ch ; Terminate and return to dos    mov al,00    int 21hendp    



stringLength proc near    mov si,dx     dec si    mov cx,0loop_String_Length:    inc si        inc cx    cmp [si],'$'       jne loop_String_Length      dec cx    dec cx    retendp    hexToAsc proc near ;AX input , si point result storage addres        mov cx,00h        mov bx,0ah        hexloop1:                mov dx,0                div bx                add dl,'0'                push dx                inc cx                cmp ax,0ah                jge hexloop1                add al,'0'                mov [si],al        hexloop2:                pop ax                inc si                mov [si],al                loop hexloop2                inc si                mov al,'$'                mov [si],al                retendp  
message db "Hello World$"strHextToAsc db " $" 
end main
ret







DATA SEGMENT    XX DB ?    YY DB ?DATA ENDS
CODE SEGMENT    ASSUME: CS:CODE,DS:DATA    MAINP:    MOV AX,DATA    MOV DS,AX    MOV CX,03H    NEXTP:    MOV AH,01H    INT 21H    MOV XX,AL    MOV AH,01H        INT 21H    MOV YY,AL        MOV BH,XX    MOV BL,YY    CMP BH,BL        JNE NOT_EQUAL    EQUAL:    MOV AH,02H    MOV DL,'Y' ;IF EQUAL THEN Y WILL BE PRINTED    INT 21H    JMP CONTINUE    NOT_EQUAL:    MOV AH,02H    MOV DL,'N' ;IF NOT EQUAL THEN N WILL BE PRINTED    INT 21H
CONTINUE:    LOOP NEXTP    MOV AH,4CH    INT 21H    CODE ENDSEND MAINP



DATA SEGMENT str1 db 20 dup(?)		; Original Stringstr2 db 20 dup(?)		; Reversed Stringn db ?msg1 db 10, 13, "String is palindrome",10, 13,"$"msg2 db 10, 13, "String is Not palindrome",10, 13,"$"msg3 db 10, 13, "enter the string", 10, 13, "$"NL db 10, 13 , '$'DATA ENDScode segmentassume cs:code, ds:datastart:        MOV AX, data        MOV DS, AX        LEA SI, str1        LEA DI, str2        MOV CL, 00H        LEA DX, msg3        MOV AH, 09H 	; DISPLAY MSG3        INT 21HUP: MOV AH, 01H 	; to read string until enter key is pressed        INT 21H        CMP AL, 0dh 	; for enter key        JZ L2        MOV [SI], AL        INC SI        INC CL        JMP UPL2: MOV n, CL        MOV CL, 00H        DEC SI 		; BRING SI TO POINT TO LAST CHAR OF STR1               UP1: CMP CL, n        JZ CHECK        MOV AL, [SI]        MOV [DI], AL ; REVERSE         DEC SI        INC CL        INC DI        JMP UP1CHECK:        LEA SI, str1        LEA DI, str2        MOV CL, 00H              UP2: CMP CL, n        JZ PAL        MOV AL, [SI]        CMP AL, [DI]        JNZ NOTPAL        INC SI        INC DI        INC CL        JMP UP2 NOTPAL: LEA DX, msg2	; Display Not Palindrome        MOV AH, 09H        INT 21H        JMP EXITPAL: 	 LEA DX, msg1	; Display Palindrome        MOV AH, 09H        INT 21HEXIT: 	 MOV AH,4CH        INT 21H code ENDS END start