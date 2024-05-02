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

    a dd 1
    b db 2
    c dw 3
    d db 4
    e dq 5
    
; our code starts here
segment code use32 class=code
    start:
    
       mov AL , [b]
       mov AH , 0
       mov DX , 0
       div word[c]
       
       mov BX , AX
       mov AX , 2
       mul [d]
       
       mov CX , 0
       add BX , word[a]
       adc CX , word[a+2]
       
       mov DX , 0
       sub BX , AX
       sbb CX , DX
       
       push CX
       push BX
       pop EBX
       mov ECX , 0
       
       sub EBX , dword[e]
       sbb ECX , dword[e+4]
      
   ; Signed representation
       mov AL , [b]
       cbw
       cwd
       idiv [c]
       
       mov BX , AX
       mov AL , 2
       imul [d]
       mov CX , AX
       mov AX , BX
       cwd
       add AX , word[a]
       adc DX , word[a+2]
       mov [c] , DX
       mov BX , AX
       mov AX , CX
       cwd
       mov CX , [c]
       sub BX , AX
       sbb CX , DX
       push CX
       push BX
       pop EBX
       mov EAX , EBX
       cdq 
       sub EAX , dword[e]
       sbb EDX , dword[e+4]
    
       
       
       
        
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
