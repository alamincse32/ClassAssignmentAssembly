;****************************************************;
;This program will calculate the multiplication      ;
;of two numbers. The numbers will be at most         ;
;two digits. But no MUL,IMUL,DIV,IDIV instruction    ;
;will be used.                                       ;
;                                                    ;
; For example:                                       ;
; First number : 14                                  ;
; Second number : 6                                  ;
; The multiplication of two number : 84              ;
;                                                    ;
;                                                    ;
;                                                    ;
;****************************************************;
                        
                      



.MODEL SMALL
.STACK 100H
.DATA

MGS1 DB 'Enter the first number : $'
MGS2 DB 'Enter the second number : $'
MGS3 DB 'Product of two given number is : $'
MGS4 DB 'You have entered wrong number$'

NUM1 DB '?'
NUM2 DB '?'
NUM3 DB '?'
NUM4 DB '?'
NUM5 DD '?'


.CODE

MAIN PROC
       
      ; GET ADDRESS OF DATA SEGMENT  
      MOV AX,@DATA
      MOV DS,AX
      
      
      ; TAKE INOUT FROM USER. THIS IS VERY TRICKY BECASUE YOU HAVE TO DETERMINE DIGIT OF NUMBERS
      CALL INPUT_TWO_NUMBER
      
      ; JUST PRINT THE TAKEN INPUT VALUE ONLY FOR CHECK
      
      CALL DISPLY
      
      ; FORM THE NUMBER FROM TAKEN INPUT
      
      CALL NUMBER_FORMATION
      
      ; MULTIPLICATON OF TOW NUMBER
      
      CALL MULTIPLICATION
      
    
    
    
    
    
    EXIT:
    MOV AH,04CH
    INT 21H
    MAIN ENDP  

  
  

MULTIPLICATION PROC    
    
    
    MOV CL, NUM1
    MOV CH,0
    MOV AX,0
    MOV BH,0
    MOV BL,NUM3
    TOP3:
      ADD AX,BX
    LOOP TOP3  
    
    MOV NUM5,AX
    
    ;PRINT MESSAGE OF RESULT
    LEA DX, MGS3
    MOV AH, 09H
    INT 21H
     
    ; ROL
    MOV CL,04
    MOV BX,NUM5
    AND BX,000FH
    
    CALL PRINT
    
     
    
    
    
    
    
    
    
    
    
    RET
    MULTIPLICATION ENDP  
 
 
 PRINT PROC   
    
    
    
    RET
    PRINT ENDP 

NUMBER_FORMATION PROC    
       
        
       ;CHECK VALIDITY OF THE NUMBER 
       CMP NUM1, '?'
       JE ERROR_MESSAGE
       
       ;TAKE ACCTUAL DIGIT
       SUB NUM1, '0' 
       
       CMP NUM2, '?'
       JE CHECK_SECOND_NUMER
       
       SUB NUM2,'0'
       
       
       
       MOV CH,0
       MOV CL,NUM1  
       MOV AH,0
       TOP:
          ADD AH,10
       LOOP TOP
        
       
       ADD AH,NUM2 
       MOV NUM1, AH
     
       
       
       CHECK_SECOND_NUMER: 
            
            CMP NUM3 , '?'
            JE ERROR_MESSAGE
            
            SUB NUM3, '0'
            
            CMP NUM4, '?'
            JE EXIT2
            
            SUB NUM4, '0'
            MOV CH,0
            MOV CL,NUM3
            MOV AH,0
            
            TOP1:
                ADD AH,10
            LOOP TOP1
            
            
            ADD AH, NUM4
            MOV NUM3, AH
            
            MOV DL,NUM3
            MOV AH,02H
            INT 21H
            
            JMP EXIT2
       
       ERROR_MESSAGE:
       
           CALL NEW_LINE
           
           LEA DX,MGS4
           MOV AH,09H
           INT 21H
       
       
       
        EXIT2:
       
       
    RET
    NUMBER_FORMATION ENDP   

DISPLY PROC
    
     CALL NEW_LINE
     
    MOV AH,02H 
    
    MOV DL,NUM1
    INT 21H
    MOV DL,NUM2
    INT 21H
    CALL NEW_LINE
    MOV DL,NUM3
    INT 21H
    MOV DL,NUM4
    INT 21H
               
    RET           
    DISPLY ENDP   


INPUT_TWO_NUMBER PROC    
    
    ;PRINT MGS1 
    
    LEA DX, MGS1
    MOV AH,09H
    INT 21H
    
    ;TAKE FIRST DIGIT OF FIRST INPUT
    MOV AH,01H
    INT 21H
     
    ;COMPARE CARRIAG 
    CMP AL, 0DH
    JE SECOND_NUMBER
    
    ;STORE IN NUM1
    MOV NUM1, AL
    
    
    ;TAKE SECOND DIGIT OF SECOND INPUT 
    INT 21H 
    
    ;COMPARE THE INPUT VALUE WITH CARRIAGE 
    CMP AL, 0DH
    JE SECOND_NUMBER
    
    
    ;IF NOT CARRIAGE, STORE THE VALUE IN NUM2
    MOV NUM2,AL
    
    
    
    
    SECOND_NUMBER: 
         
        CALL NEW_LINE
        ;PRINT THE SECOND MESSAGE
        LEA DX, MGS2
        MOV AH,09H
        INT 21H 
              
        ;TAKE FIRST DIGIT OF SECOND NUMBER
        MOV AH,01H
        INT 21H
        
        ;CHECK NUMBER OR CARRIAGE
        
        CMP AL, 0DH
        JE EXIT1
        
        ;STORE NUMBER IN NUM3
        MOV NUM3,AL
        
        ;TAKE SEOCND DIGIT OF SECOND NUMBER                          
        INT 21H
        CMP AL, 0DH 
        JE EXIT1
                    
                    
        ;STORE NUMBER IS NUM4
        MOV NUM4, AL                        
        
        EXIT1:
    
              
        RET
    
    
    INPUT_TWO_NUMBER ENDP

 
 
 NEW_LINE PROC
     
      
     ;PRINT NEWLINE  
     MOV AH,02H
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H           
                 
     RET
                 
    NEW_LINE ENDP


END MAIN