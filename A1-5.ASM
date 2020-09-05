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
    A DW 1
    B DW 1
    N DW 0  
    MS DB 0DH,0AH,"ENTER HOW MANY FIBONACCI NUMBERS DO YOU WANT: $"   
    ANS DB 0DH,0AH,"THE REQUIRED FIBONACCI NUMBERS ARE$"   
    ARR DB " --> $"            
    CRS DB "X$"
    LN DB 0DH,0AH,"$"
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX
                      
        PRINT MS
        READ N,U1,U2  
        MOV CX,N
        
        PRINT ANS 
        PRINT LN 
        
        CMP CX,1H
        JNE CHK   
        MOV AH,2H
        MOV DL,31H
        INT 21H   
        
        PRINT ARR
        JMP GO
              
        CHK: MOV AH,2H
        MOV DL,31H
        INT 21H  
        
        PRINT ARR
                
        MOV AH,2H
        MOV DL,31H
        INT 21H    
        
        PRINT ARR
        
        CMP CX,2H
        JE GO  
        
        DEC CX
        DEC CX 
        
        ADDI: MOV AX,A
              ADD AX,B  
              
               
              MOV BX,B 
              MOV A,BX
              MOV B,AX    
               
              PUSH CX
              PRINTMUL AX,G1,G2 
              PRINT ARR   
              POP CX  
              LOOP ADDI
        
        GO:PRINT CRS

        MOV AH,4CH
        INT 21H
        
    MAIN ENDP
END MAIN