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
    b dw 4
    c dd 3
    d dq 1
    
; our code starts here
segment code use32 class=code
    start:
    ;(b+b)-c-(a+d) --signed

     mov AX , [b]
     add AX , word[b]   ;AX = b+b -->word
     CWD           ;DX:AX = b+b -->dword
     push DX 
     push AX
     pop EAX       ;EAX = b+b -->dword
     
     sub EAX , dword[c]  ;EAX = (b+b)-c -->dword
     CDQ                 ;EDX:EAX = (b+b)-c -->qword
     
     mov EBX , EAX  
     mov ECX , EDX      ;ECX:EBX = (b+b)-c -->qword
     
     mov AL , [a]
     CBW           ;AX = a -->word
     CWD           ;DX:AX = a -->dword
     CDQ           ;EDX:EAX = a -->qword
     add EAX , dword[d]
     adc EDX , dword[d+4]   ;EDX:EAX = a+d --qword
     
     sub EBX , EAX 
     sbb ECX , EDX    ;ECX:EBX = (b+b)-c - (a+d)
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   