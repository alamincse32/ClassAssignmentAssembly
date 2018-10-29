.MODEL SMALL
.STACK 100H 
.DATA
.CODE

MAIN PROC  
    
    MOV AH,01H
    INT 21H
    
    MOV BH,AL
    SUB BL,48
    
    INT 21H
    
    MOV BL,AL
    SUB BL,48
    
    MOV CL, BL 
    MOV AH,0
    TOP:
       ADD AH,10
       LOOP TOP
    ADD AH,BL
    
    MOV DL,AH
    MOV AH,02H
    INT 21H
    
    
    
    
    EXIT:  
    MOV AH,04CH
    INT 21H
    MAIN ENDP
END MAIN


