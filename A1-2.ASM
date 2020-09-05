PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9H
    INT 21H
ENDM
.MODEL SMALL
.STACK 100H
.DATA
    MS DB 0DH,0AH,"ENTER AN UPPER CASE CHARACTER: $"
    MT DB 0DH,0AH,"THE LOWER CASE CHARACTER IS: $"   
    WR DB 0DH,0AH,"WRONG INPUT$"
.CODE
    MAIN PROC   
        MOV AX,@DATA
        MOV DS,AX
        
        LEV: PRINT MS
        
        MOV AH,1H
        INT 21H
        
        CMP AL,41H
        JL NO
        CMP AL,5AH
        JG NO
        
        ADD AL,20H
        MOV BL,AL
        
        PRINT MT
        
        MOV AH,2H
        MOV DL,BL
        INT 21H   
        
        JMP GO
        
        NO: PRINT WR
            JMP LEV
            
        GO:NOP
        
    MAIN ENDP
    
END MAIN        