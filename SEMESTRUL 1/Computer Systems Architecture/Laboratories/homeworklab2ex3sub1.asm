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
    b db 1
    c db 3
    d dw 1
    
; our code starts here
segment code use32 class=code
    start:
    ;[(10+d)-(a*a-2*b)]/c

      
        mov DX , [d] 
        add DX , 10 ;DX = 10+d
        
        mov AL , [a]
        mul AL      ;AX = a*a ->dw
        mov BX , AX ;BX = a*a
        mov AL , 2
        mul byte[b] ; AX = 2*b -->dw
        sub BX , AX  ; BX = a*a - 2*b -->word
        mov AX , BX ; AX = a*a - 2*b 
        
        sub DX , AX ; AX = (10+d) - (a*a - 2*b) ->word
        
        mov CL , [c]
        mov AX , DX
        div CL
        
        
        
        
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   