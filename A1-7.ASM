PRINT MACRO MSG
      LEA DX,MSG
      MOV AH,09H
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
                MOV BX,0AH
                MOV AX,N1
                XOR CX,CX 
                
           L2: XOR DX,DX
               DIV BX
               PUSH DX
               INC CX
               CMP AX,00H
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
    M DW 0  
    MS DB 0DH,0AH,"ENTER NUMBER: $"    
    PRI DB 0DH,0AH,"PRIME$"
    NPRI DB 0DH,0AH,"NOT PRIME$"
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX
                      
        PRINT MS
        READ N,U1,U2 
        
        MOV AX,N 
        CMP AX,01H
        JE PR 
        CMP AX,02H
        JE PR
        CMP AX,03H
        JE PR
        
        MOV BX,02H     
        DIV BX  
        CMP DX,00H
        JE NPR 
        
        MOV BX,3H
        LEV: MOV AX,N 
             XOR DX,DX
             DIV BX
             CMP DX,00H
             JE NPR
             INC BX
             INC BX
             CMP BX,N
             JL LEV
             
        PR: PRINT PRI 
            JMP GO
        
        NPR: PRINT NPRI
        
        GO: NOP
    MAIN ENDP
END MAIN