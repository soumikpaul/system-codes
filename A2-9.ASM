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
        MSG1 DB "ENTER THE NUMBER OF ELEMENTS: $"
        MSG2 DB 0DH, 0AH, "ENTER THE ELEMENT: $"
        MSG7 DB 0DH, 0AH, "THE CONTENTS OF THE ARRAY ARE: $"
        M2 DB 0DH, 0AH, "THE MAXIMUM ELEMENT OF THE ARRAY IS: $"
        M5 DB 0DH, 0AH, "AND THE MINIMUM ELEMENT OF THE ARRAY IS: $"
        MSG4 DB " -> $"
        MSG6 DB "X$"
        M45 DB 0DH,0AH,'$'     
        
        ARRAY DW 100 DUP(0)
        N DW 0 
        MAXI DW 0
        MINI DW 99   
        UY DW 0

.CODE
        MAIN PROC

                MOV AX,@DATA
                MOV  DS,AX
                PRINT MSG1
                READ N,JUMP1,JUMP2
                MOV CX,N    
                SHR CX,1
                MOV UY,CX
                MOV CX,N
                MOV SI,0000H
            LOOP1:      PRINT MSG2
                        READ ARRAY[SI],JUMP3,JUMP4
                        ADD SI,02H
                        LOOP LOOP1
            PRINT MSG7
            CALL DISPLAY

          BV:      CALL FIND_MINIMUM          ; call the procedure FIND_MAXIMUM

                CALL FIND_MAXIMUM          ; call the procedure FIND_MINIMUM   
                
                PRINT M45 
                
                CALL DISPLAY     
                
                MOV AX,00H
                MOV MAXI,AX
                MOV AX,99H
                MOV MINI,AX
                
                MOV AX,UY
                DEC AX
                JZ FINI  
                MOV UY,AX
                JMP BV

        FINI:        MOV AH, 4CH
                INT 21H

        MAIN ENDP

        FIND_MAXIMUM PROC

                MOV SI, 00H
                MOV CX, N

               ; MOV AX, ARRAY[SI]
               ; MOV MAXI, AX

                NEXT1: MOV AX, ARRAY[SI] 
                        CMP AX,00H  
                        JE NEXT_ELEMENT1
                      CMP MAXI, AX
                      JG NEXT_ELEMENT1
                      MOV MAXI, AX 
                      MOV DI,SI

                      NEXT_ELEMENT1: 
                                ;INC SI   
                                ADD SI,02H
                                LOOP NEXT1 

                LEA DX, M2
                MOV AH, 9H
                INT 21H
                
                PRINTMUL MAXI,J7,J8   
                MOV ARRAY[DI],00H
                RET

        FIND_MAXIMUM ENDP
        
        FIND_MINIMUM PROC

                MOV SI, 00H
                MOV CX, N

                ;MOV AX, ARRAY[SI]
                ;MOV MINI, AX

                NEXT2: MOV AX, ARRAY[SI] 
                        CMP AX,00H   
                       JE NEXT_ELEMENT2 
                      CMP MINI, AX
                      JL NEXT_ELEMENT2
                      MOV MINI, AX   
                      MOV DI,SI

                      NEXT_ELEMENT2: 
                                ADD SI,02H
                                LOOP NEXT2 

                LEA DX, M5
                MOV AH, 9H
                INT 21H
               
                PRINTMUL MINI,K1,K2  
                
                MOV ARRAY[DI],0
                

                RET

        FIND_MINIMUM ENDP
        
        DISPLAY PROC
                        MOV CX,N
                        MOV SI,00H
                        L4: PUSH CX
                            PRINTMUL ARRAY[SI],L5,L6   
                            PRINT MSG4
                            ADD SI,02H
                            POP CX
                            LOOP L4   
                            
                            PRINT MSG6
                            RET
           DISPLAY ENDP

END MAIN