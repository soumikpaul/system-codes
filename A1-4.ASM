PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9H
    INT 21H
ENDM
.MODEL SMALL
.STACK 100H
.DATA
    MS DB "MY NAME IS: Dibyayan Mondal $"
.CODE
    MAIN PROC   
        MOV AX,@DATA
        MOV DS,AX
        
        PRINT MS
        
    MAIN ENDP
    
END MAIN        