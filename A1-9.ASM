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
    TEMP DW 0 
    MULT DW 1
    MS DB "ENTER THE HEXA-DECIMAL NUMBER: $" 
    MT DB 0DH,0AH,"THE EQUIVALENT DECIMAL NUMBER IS: $"  
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX 
        
        PRINT MS  
        
        XOR CX,CX
        LEV:MOV AH,1H
            INT 21H 
            CMP AL,0DH
            JE GO 
            XOR AH,AH
            PUSH AX
            INC CX
            JMP LEV
        
        GO:PRINT MT
        
        OK: POP AX 
            SUB AX,30H 
            CMP AX,9H
            JL NXT
            SUB AX,7H
        NXT:MUL MULT 
            MOV BX,TEMP
            ADD AX,BX  
            MOV TEMP,AX    ;TEMP=AX*BX+TEMP
            
            MOV AX,MULT  
            MOV DX,10H
            MUL DX
            MOV MULT,AX     ;MULT=MULT*16
            
            LOOP OK   
            
       PRINTMUL TEMP,B0,V2
        
    MAIN ENDP
END MAIN