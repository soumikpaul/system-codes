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
        M DW 0
        MSG1 DB 10,13,'PLEASE ENTER THE NO OF ELEMENTS: $'
        MSG2 DB 10,13,'ENTER THE ELEMENT: $'
        MSG3 DB 10,13,'THE GIVEN ARRAY BEFORE SORTING: $'
        MSG4 DB ' -> $' 
        MSG5 DB 10,13,'THE CURRENT STATE OF THE ARRAY: $'   
        MSG6 DB 'X$'    
        MSG7 DB 10,13,'THE FINAL ARRAY AFTER SORTING: $'

;PROGRAM TO IMPLEMENT SELECTION SORT

.CODE
      MAIN PROC
                MOV AX,@DATA
                MOV  DS,AX
                PRINT MSG1
                READ N,JUMP1,JUMP2
                MOV CX,N
                MOV AX,N
                DEC AX
                MOV M,AX
                MOV SI,0000H 
                
            LOOP1:      PRINT MSG2
                        READ NUM[SI],JUMP3,JUMP4
                        ADD SI,02H
                        LOOP LOOP1  
                        
            PRINT MSG3
            CALL DISPLAY 
            
            MOV SI,0000H
            XOR CX,CX  
                 
            ;DI is used for min_index
            ;SI is used for comparing the array values, comparing a[SI] with a[SI+1]  
            ;CX is used for both the loops. It's value is being saved in the stack 
            ;for future use
            OUTERLOOP:  MOV AX,NUM[SI]
                        MOV DI,SI
                        PUSH CX
                        PUSH SI   
                        MOV SI,DI   
                        
                        INNERLOOP:  
                                     ADD SI,02H
                                     CMP AX,NUM[SI]
                                     JL CHECK
                                     MOV AX,NUM[SI]  
                                     MOV DI,SI   
                                     
                             CHECK:  INC CX
                                     CMP CX,M
                                     JL INNERLOOP
                                     
                        POP SI
                        POP CX  
                            
                        ;THE SWAPPING PROCEDURE
                        MOV BX,NUM[SI]   
                        MOV NUM[DI],BX   ;a[min_index]=a[i]
                        MOV NUM[SI],AX   ;a[i]=a[min_index]
                        
                        ;push CX and SI into stack so that their value can be got after display
                        PUSH CX
                        PUSH SI   
                        
                        ;printing the current state
                        PRINT MSG5
                        CALL DISPLAY  
                            
                        ;retrieving CX and SI from stack    
                        POP SI
                        POP CX    
                        
                        ADD SI,02H     ;i++
                        INC CX
                        CMP CX,M
                        JL OUTERLOOP  
                        
                        PRINT MSG7
                        CALL DISPLAY
                        
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