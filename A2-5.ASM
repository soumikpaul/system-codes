PRINT MACRO MSG
    LEA DX,MSG
    MOV AH,9
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
        MSG1 DB 10,13,'PLEASE ENTER THE SIZE OF THE ARRAY: $'
        MSG2 DB 10,13,'ENTER A NUMBER: $'
        MSG3 DB 10,13,'ORIGINAL ARRAY: $'
        MSG4 DB ' -> $'  
        MSG  DB 'X$'
        MSG5 DB 10,13,'PLEASE ENTER THE KEY TO SEARCHED: $'
        MSG6 DB 10,13,'THE GIVEN ELEMENT FOUND IN POSITION(S): $'  
        
        N DW 0
        NUM DW 100 DUP(0)
        KEY DW 0
.CODE
        MAIN PROC
                        MOV AX,@DATA
                        MOV DS,AX 
                        
                        PRINT MSG1
                        READ N,JUMP1,JUMP2
                        MOV CX,N
                        MOV SI,0000H 
                        
                 LOOP1: PRINT MSG2
                        READ NUM[SI],JUMP3,JUMP4
                        ADD SI,02
                        LOOP LOOP1  

                        PRINT MSG3
                        CALL DISPLAY
                        
                        PRINT MSG5
                        READ KEY,JUMP5,JUMP6  
                        
                  MOV SI,0000H
                  MOV CX,N
                  XOR BL,BL
                  PRINT MSG6  
                  
                  LOOP2:  MOV AX,NUM[SI]
                          CMP AX,KEY
                          JNE NEXT
                          MOV DL,BL
                          ADD DL,30H
                          MOV AH,2H
                          INT 21H  
                          PRINT MSG4
                          
                   NEXT:  INC BL
                          ADD SI,02H
                          LOOP LOOP2  
                          
                   PRINT MSG       
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
                            PRINT MSG
                            RET
          DISPLAY ENDP
END