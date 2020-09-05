   .MODEL SMALL

        .STACK 32

        .DATA

               STR1 DB 0DH,0AH, 'ENTER THE BINARY NUMBER :- $'
               STR2 DB 0DH,0AH, 'THE HEXADECIMAL EQUIVALENT IS :-  $'  
               STR3 DB 0DH,0AH, 'CURRENT STATE IS: $'
               nl db 0dh,0ah,'$'
               T1 DB 0 
               T2 DB 0
               T3 DB 0

        .CODE
         MAIN PROC

                MOV AX,@DATA
                MOV DS,AX


         DISP:
                LEA DX,STR1
                MOV AH,09H
                INT 21H

                MOV CL,00
                

         READ:   MOV AH,01H

                INT 21H

                MOV BL,AL

                PUSH BX
                INC CX
                CMP AL,0DH

                JZ DISPLAY
                
                JMP READ
                
         DISPLAY:

                LEA DX,STR2
                MOV AH,09H
                INT 21H

               XOR CX,CX
                 POP BX               
         ANS:   POP BX
                SUB BX,30H
                ADD CX,BX
                
                POP BX
                SUB BX,30H
                SHL BX,1
                ADD CX,BX
                
                POP BX   
                SUB BX,30H
                SHL BX,2
                ADD CX,BX
                
                POP BX  
                SUB BX,30H
                SHL BX,3
                ADD CX,BX
                
                CMP CX,09H
                JG LE 
                ADD CX,30H 
                JMP RED
         LE:    ADD CX,30H
                ADD CX,7H
                   
        RED:    MOV T1,CL   
        
                 XOR CX,CX 
                 XOR BX,BX           
                  POP BX
                SUB BX,30H
                ADD CX,BX
                
                POP BX
                SUB BX,30H
                SHL BX,1
                ADD CX,BX
                
                POP BX   
                SUB BX,30H
                SHL BX,2
                ADD CX,BX
                
                POP BX  
                SUB BX,30H
                SHL BX,3
                ADD CX,BX
                
                CMP CX,09H
                JG LE1 
                ADD CX,30H
                JMP RED1
         LE1:    ADD CX,30H
                ADD CX,7H
                             
         RED1:    MOV T2,CL   
        
                 XOR CX,CX 
                 XOR BX,BX           
                  POP BX
                SUB BX,30H
                ADD CX,BX
                
                POP BX
                SUB BX,30H
                SHL BX,1
                ADD CX,BX
                
                POP BX   
                SUB BX,30H
                SHL BX,2
                ADD CX,BX
                
                POP BX  
                SUB BX,30H
                SHL BX,3
                ADD CX,BX
                
                CMP CX,09H
                JG LE2 
                ADD CX,30H 
                JMP RED2
         LE2:    ADD CX,30H
                ADD CX,7H
        RED2:    MOV T3,CL   
        
                 XOR CX,CX 
                 XOR BX,BX           
                  POP BX
                SUB BX,30H
                ADD CX,BX
                
                POP BX
                SUB BX,30H
                SHL BX,1
                ADD CX,BX
                
                POP BX   
                SUB BX,30H
                SHL BX,2
                ADD CX,BX
                
                POP BX  
                SUB BX,30H
                SHL BX,3
                ADD CX,BX
                
                CMP CX,09H
                JG LE3 
                ADD CX,30H 
                JMP RED3
         LE3:    ADD CX,30H
                ADD CX,7H
        
        
        RED3:   MOV DL,CL
                MOV AH,2H
                INT 21H  
                
                MOV DL,T3
                MOV AH,2H
                INT 21H
                
                MOV DL,T2
                MOV AH,2H
                INT 21H
                
                MOV DL,T1
                MOV AH,2H
                INT 21H
        
                END MAIN
                END