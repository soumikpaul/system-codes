PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9H
    INT 21H
ENDM

.MODEL SMALL
.STACK 100H
.DATA
    N DW 1AH    
    SPC DB " $"  
    LN DB 0DH,0AH,"$"
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX 
        
        MOV CX,N
        MOV AX,41H  
        
        LEV:MOV DL,AL 
            MOV AH,2H
            INT 21H   
            PUSH AX  
            PRINT SPC   
            POP AX
            XOR AH,AH
            INC AL
            LOOP LEV   
            
        PRINT LN
        
        MOV CX,N
        MOV AX,61H  
        
        LEV1:MOV DL,AL 
            MOV AH,2H
            INT 21H   
            PUSH AX  
            PRINT SPC   
            POP AX
            XOR AH,AH
            INC AL
            LOOP LEV1  
        
    MAIN ENDP
END MAIN