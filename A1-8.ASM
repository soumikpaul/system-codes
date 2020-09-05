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
    N DW ?   
    M DW ? 
    GCD DW ?
    MS DB "ENTER THE 1ST NUMBER: $" 
    MT DB 0DH,0AH,"ENTER THE 2ND NUMBER: $"  
    LCM DB 0DH,0AH,"THE LCM OF THE 2 NOS IS: $"  
    HCF DB 0DH,0AH,"THE HCF OF THE 2 NOS IS: $" 
.CODE
    MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX 
        
        PRINT MS
        READ N,G1,G2 
        
        PRINT MT
        READ M,B1,B2
          
        PRINT HCF 
        
        MOV AX,N
        MOV BX,M
        
        CMP AX,BX
        JG GO 
        
        SWAP: MOV CX,BX
              MOV BX,AX
              MOV AX,CX   
              
        GO: XOR DX,DX  
            XOR AH,AH
            DIV BX   
            CMP DX,00H
            JE HC
            MOV AX,BX
            MOV BX,DX
            JMP GO
            
       HC:  MOV AX,BX   
            MOV GCD,AX
            PRINTMUL AX,Y1,W2   
            
       PRINT LCM
       
       MOV AX,N
       MUL M
       MOV BX,GCD
       DIV BX
       
       PRINTMUL AX,V3,B8
        
    MAIN ENDP
END MAIN