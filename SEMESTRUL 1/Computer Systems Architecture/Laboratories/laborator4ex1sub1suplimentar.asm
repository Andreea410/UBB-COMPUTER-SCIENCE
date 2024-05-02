bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db 2
    b dw 1
    c dd 3
    d dq 1
    
; our code starts here
segment code use32 class=code
    start:
    ;(a-b)+(c-b-d)+d --unsigned

      mov AL , [a]
      mov AH , 0 ;AX = a -->word
      mov BX , [b]
      sub AX , BX ;AX = a-b -->word 
      
      
      mov [b] , AX
      mov CX , 0 ;CX:BX=b --dd
      push CX
      push BX
      pop EBX ; EBX =b --dd
      
      
      mov EAX , [c] ;EAX = c --dd
      sub EAX , EBX ;EAX = c-b --dd
      mov EDX , 0  ; EDX:EAX = c-b --dq
      sub EAX , dword[d]
      sbb EDX , dword[d+4] ; EDX:EAX = c-b-d -->dq
      
      mov EBX , [b]
      mov ECX , 0 ; ECX:EBX = a-b --dq
      
      add EAX , EBX 
      adc EDX , ECX ;EDX:EAX = (a-b)+(c-b-d) -- dq
      
      add EAX , dword[d]
      adc EDX , dword[d+4] ;EDX:EAX = (a-b)+(c-b-d)+d -- dq  
      
      
      
      
      
      
      
      
      
      
      
        
        
        
        
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   