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
        MAX DW 0 
        KEY DW 0
        MSG1 DB 10,13,'ENTER THE ELEMENT: $'
        MSG2 DB 10,13,'THE GIVEN ARRAY: $'
        MSG3 DB 10,13,'THE ELEMENT IS FOUND IN THE POSITION(S): $'
        MSG4 DB ' -> $'  
        MSG6 DB 'X$'   
        MSG8 DB 10,13,'SORRY, THE ELEMENT NOT FOUND!!!$'
        MSG7 DB 10,13,'PLEASE ENTER THE ELEMENT TO BE SEARCHED: $'
        MSG5 DB 10,13,'ENTER THE SIZE OF THE ARRAY: $'
 
.CODE
        MAIN PROC
            
                MOV AX,@DATA
                MOV  DS,AX
                PRINT MSG5
                READ N,JUMP1,JUMP2
                MOV CX,N
                MOV AX,N
                DEC AX
                MOV M,AX  ;M = (n - 1)
                ADD AX,AX
                MOV MAX,AX
                
                MOV SI,0000H  
                
            LOOP1:      PRINT MSG1
                        READ NUM[SI],JUMP3,JUMP4
                        ADD SI,02H
                        LOOP LOOP1
            PRINT MSG2
            CALL DISPLAY   
            
            PRINT MSG7
            READ KEY,JUMP5,JUMP6
            PRINT MSG6 
            
            PRINT MSG3
            
            MOV CX,KEY  
            MOV SI,0000H
            MOV BX,00H
            MOV DX,M   
            
            ;bx will hold the value of l = 0 initially
            ;dx will hold the value of h = (n - 1) initially
            ;ax will hold mid value = (l + h) / 2
            
            OUTER:  CMP BX,DX     ;if(l > h)
                    JA NOT_FOUND  ; jump to not possible
                    
                    MOV AX,BX     ;ax = l
                    ADD AX,DX     ;ax = (h + l)
                    SHR AX,1      ;ax = (h + l) / 2
                    MOV SI,AX     ;i = ax
                    ADD SI,SI            
                    
                    CMP CX,NUM[SI]  ;cmp key, num[mid]
                    JL GREATER
                    JE FOUND 
                    
            LOWER:        ADD AX,01
                          MOV BX,AX  ;l = (m + 1)
                          
                          JMP OUTER 
                    
            GREATER:  SUB AX,01H
                      MOV DX,AX   ;h = (m - 1)
                      JMP OUTER 
                      
            FOUND:     MOV BX,AX   ;bx = m 
            
                       ;code to print the first mid position encountered
                       MOV DL,AL
                       ADD DL,48
                       MOV AH,2H
                       INT 21H 
                       
                       PRINT MSG4
                       JMP NXT  
                    
            NOT_FOUND:   PRINT MSG8
                         JMP END1  
                    
            NXT:    MOV SI,BX
                    ADD SI,SI
                    MOV DI,BX
                    ADD DI,DI  
                    
            BACK:   SUB SI,02H
                    CMP SI,00H
                    JL FORWARD 
                       
                    CMP NUM[SI],CX
                    JNE FORWARD
                    MOV BX,SI 
                    SHR BX,1
                    MOV DL,BL
                    ADD DL,48
                    MOV AH,2H
                    INT 21H  
                   ; PRINTMUL BX,JUMP10,JUMP11
                    PRINT MSG4
                    JMP BACK   
                    
            FORWARD:ADD DI,02H
                    CMP DI,MAX  ;MAX has been set to (n - 1) 
                    JG CROSS    
                    
                    CMP NUM[DI],CX
                    JNE CROSS
                    
                    MOV BX,DI
                    SHR BX,1
                    MOV DL,BL 
                    ADD DL,48
                    MOV AH,2H
                    INT 21H
                   ; PRINTMUL BX,JUMP12,JUMP13  
                    PRINT MSG4
                    JMP FORWARD
                    
             CROSS: PRINT MSG6 
                    
             END1:  MOV AH,4CH
                    INT 21H
                    
 
    MAIN ENDP    
        
    DISPLAY PROC
        MOV CX,N
        MOV SI,00H
    L4: PUSH CX
        
        PRINTMUL NUM[SI],L5,L6
        ADD SI,02H
        POP CX 
        PRINT MSG4
        LOOP L4 
        PRINT MSG6   
        RET
    DISPLAY ENDP   
    
END