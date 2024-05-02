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

    a dw 2
    b db 6
    c db 3
    d db 1
    e dd 2
    x dq 5
    
; our code starts here
segment code use32 class=code
    start:
    ;(a*2+b/2+e)/(c-d)+x/a --unsigned

     mov AX , 2   ;AX=2 -->word
     mul word[a]  ; DX:AX = 2*a -->dword 
     
     push DX 
     push AX
     
     mov AL , byte[b]
     mov AH , 0   ;AX =b -->word
     mov BL , 2
     div BL       ;AL = b/2 --> byte
     mov BL , AL  ;BL = b/2 --> byte
     
     pop EAX      ;EAX = a*2 --> dword
     
     mov BH , 0   ; BX = b/2 -->word
     mov CX , 0   ; CX:BX = b/2 -->dword
     push CX
     push BX
     pop EBX      ;EBX = b/2 -->dword
     
     add EAX , EBX ;EAX = a*2 + b/2 --> dword
     add EAX , dword[e]  ;EAX = a*2 + b/2 + e  --> dword
     
     mov BL , [c]
     sub BL , [d]    ;BL = c-d --> byte
     mov BH , 0      ;BX = c-d -->word
     
     div BX ; AX = (a*2 + b/2 + e)/(c-d) --> word
     mov DX , 0   ;DX:AX=(a*2 + b/2 + e)/(c-d) --> dword
     
     push DX
     push AX
     pop EAX 
     mov [e] , EAX  ; e=(a*2 + b/2 + e)/(c-d) --> dword
     
     mov EAX , dword[x]
     mov EDX , dword[x+4]   ;EDX:EAX = x -->dq
     mov BX , [a]
     mov CX , 0
     push CX
     push BX
     pop EBX        ;EBX = a -->dd
     div EBX        ;EAX = x/a -->dd
     
     add EAX , [e]   ;EAX=(a*2 + b/2 + e)/(c-d)+ x/a --> dword
     
     
     
     
     
     
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   