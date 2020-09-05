PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9H
    INT 21H
ENDM      

READ MACRO N,J1,J2
      J1: MOV AH,01H
          INT 21H
          CMP AL,0DH
          JE J2
          SUB AL,30H
          MOV BL,AL
          MOV AX,N
          MOV DX,0AH
          MUL DX
          XOR BH,BH
          ADD AX,BX
          MOV N,AX
          JMP J1
      J2: NOP
ENDM     

PRINTMUL MACRO N1,L2,L3
                MOV BX,000AH
                MOV AX,N1
                XOR CX,CX 
                
           L2: XOR DX,DX
               DIV BX
               PUSH DX
               INC CX
               CMP AX,0000H
               JNE L2      
               
           L3: POP DX
               ADD DL,30H
               MOV AH,02H
               INT 21H
               LOOP L3
ENDM  

.MODEL SMALL
.STACK 100H
.DATA
    N DW 0 
    MS DB "ENTER THE NUMBER: $"   
    FAC DB 0DH,0AH,"THE FACTORIAL IS: $" 
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX 
        
        PRINT MS
        READ N,G1,G2   
        PRINT FAC   
        
        MOV CX,N 
        CMP CX,1H
        JNE GO   
        MOV DL,31H
        MOV AH,2H
        INT 21H
        JMP OK
        
     GO:DEC CX
        MOV BX,2
        MOV AX,1
        
        LEV: MUL BX
             INC BX
             LOOP LEV
        
          
        PRINTMUL AX,U1,U2  
        
     OK: NOP
        
    MAIN ENDP
END MAIN