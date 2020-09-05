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
        M2 DB 0DH, 0AH, "THE 2ND MAXIMUM ELEMENT OF THE ARRAY IS: $"
        M5 DB 0DH, 0AH, "AND THE 2ND MINIMUM ELEMENT OF THE ARRAY IS: $"
        MSG4 DB " -> $"
        MSG6 DB "X$"     
        
        ARRAY DW 100 DUP(0)
        N DW 0 
        MAXI DW 0
        MINI DW 99     
        SEC_MAXI DW 0
        SEC_MINI DW 99

.CODE
        MAIN PROC

                MOV AX,@DATA
                MOV  DS,AX
                PRINT MSG1
               READ N,JUMP1,JUMP2
                MOV CX,N
                MOV SI,0000H
            LOOP1:      PRINT MSG2
                        READ ARRAY[SI],JUMP3,JUMP4
                        ADD SI,02H
                        LOOP LOOP1
            PRINT MSG7
            CALL DISPLAY    ; call the procedure PRINT_ARRAY

                CALL FIND_SECOND_MAXIMUM      ; call the procedure FIND_SECOND_MAXIMUM

                CALL FIND_SECOND_MINIMUM      ; call the procedure FIND_SECOND_MINIMUM

                MOV AH, 4CH
                INT 21H

        MAIN ENDP

        FIND_SECOND_MAXIMUM PROC

                MOV SI, 00H
                MOV CX, N

                MOV AX, ARRAY[SI]
                MOV MAXI, AX
                MOV SEC_MAXI, AX

                NEXT1: MOV AX, ARRAY[SI]
                      CMP AX, MAXI
                      JG CHECK
                      CMP AX,SEC_MAXI
                      JG GY
                      JMP NEXT_ELEMENT1

                      CHECK:
                            ;MOV SEC_MAXI,MAXI 
                            MOV BX,MAXI
                            MOV SEC_MAXI,BX
                            ;MOV MAXI,ARRAY[SI]  
                            MOV BX,ARRAY[SI]
                            MOV MAXI,BX
                            
                            JMP NEXT_ELEMENT1 
                       
                       GY: CMP AX,MAXI
                            JNE HI 
                            JMP NEXT_ELEMENT1
                            
                       HI: ;MOV SEC_MAXI,ARRAY[SI]
                            MOV BX,ARRAY[SI]
                            MOV SEC_MAXI,BX

                      NEXT_ELEMENT1: 
                                ADD SI,02H
                                LOOP NEXT1 

                LEA DX, M2
                MOV AH, 9H
                INT 21H
                
                PRINTMUL SEC_MAXI,K1,K2
                ;MOV DX, SEC_MAXI
                ;ADD DL, 30H
                ;MOV AH, 2H
                ;INT 21H

                RET

        FIND_SECOND_MAXIMUM ENDP
        
         
         FIND_SECOND_MINIMUM PROC
                MOV SI, 00H
                MOV CX, N

                ;MOV AX, ARRAY[SI]
                ;MOV MINI, AX
                ;MOV SEC_MINI, AX

                NEXT2: MOV AX, ARRAY[SI]
                      CMP AX, MINI
                      JL CHECK2
                      CMP AX,SEC_MINI
                      JL GY2
                      JMP NEXT_ELEMENT2

                      CHECK2:
                            ;MOV SEC_MAXI,MAXI 
                            MOV BX,MINI
                            MOV SEC_MINI,BX
                            ;MOV MAXI,ARRAY[SI]  
                            MOV BX,ARRAY[SI]
                            MOV MINI,BX
                            
                            JMP NEXT_ELEMENT2 
                       
                       GY2: CMP AX,MINI
                            JNE HI2 
                            JMP NEXT_ELEMENT2
                            
                       HI2: ;MOV SEC_MAXI,ARRAY[SI]
                            MOV BX,ARRAY[SI]
                            MOV SEC_MINI,BX

                      NEXT_ELEMENT2: 
                                ADD SI,02H
                                LOOP NEXT2 

                LEA DX, M5
                MOV AH, 9H
                INT 21H
                
                PRINTMUL SEC_MINI,G1,G2

                RET
         
       FIND_SECOND_MINIMUM ENDP  
         
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