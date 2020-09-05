PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9H
    INT 21H
ENDM
.MODEL SMALL
.STACK 100H
.DATA
    MS DB "ENTER A CHARACTER: $"
    MT DB 0DH,0AH,"THE CHARACTER IS: $"
.CODE
    MAIN PROC   
        MOV AX,@DATA
        MOV DS,AX
        
        PRINT MS
        
        MOV AH,1H
        INT 21H
        
        MOV BL,AL
        
        PRINT MT
        
        MOV AH,2H
        MOV DL,BL
        INT 21H
        
    MAIN ENDP
    
END MAIN        