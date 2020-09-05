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
        NUM DW 100 DUP(0)
        N DW 0 
        CNT1 DW 0 
        CNT2 DW 0 
        MSG1 DB 10,13,'PLEASE ENTER THE NO OF ELEMENTS: $'
        MSG2 DB 10,13,'ENTER THE ELEMENT: $'
        MSG3 DB 10,13,'THE COUNT OF NUMBERS WHICH ARE LESS THAN 20: $'
        MSG4 DB ' -> $' 
        MSG5 DB 10,13,'THE COUNT OF NUMBERS WHICH ARE GREATER THAN 40: $'   
        MSG6 DB 'X$'    
        MSG7 DB 10,13,'THE ELEMENTS OF THE ARRAY ARE: $'  
 

.CODE
        MAIN PROC
            
                MOV AX,@DATA
                MOV  DS,AX
                PRINT MSG1
               READ N,JUMP1,JUMP2
                MOV CX,N
                MOV AX,N
                DEC AX
                MOV SI,0000H
            LOOP1:      PRINT MSG2
                        READ NUM[SI],JUMP3,JUMP4
                        ADD SI,02H
                        LOOP LOOP1
            PRINT MSG7
            CALL DISPLAY

            MOV CX,N
            MOV SI,0000

            LEV:	CMP NUM[SI],20
            		JGE CHK
            		INC CNT1	
            		JMP NXT

            CHK:	CMP NUM[SI],40
            		JLE NXT
            		INC CNT2

            NXT:	ADD SI,02H
            		LOOP LEV

            PRINT MSG3
            MOV DX,CNT1
            ADD DX,30H
            MOV AH,2H
            INT 21H

            PRINT MSG5
            MOV DX,CNT2
            ADD DX,30H
            MOV AH,2H
            INT 21H

            MOV AH,4CH
            INT 21H
 
    MAIN ENDP  
        
    DISPLAY PROC
                        MOV CX,N
                        MOV SI,00H
                        L4: PUSH CX
                            PRINTMUL NUM[SI],L5,L6   
                            PRINT MSG4
                            ADD SI,02H
                            POP CX
                            LOOP L4   
                            
                            PRINT MSG6
                            RET
           DISPLAY ENDP

END