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

    a dw 1011101110111011b
    b dw 1011100110011001b ;
    c dw 0
   
    
; our code starts here
segment code use32 class=code
    start:
    
    mov BX , [b] 
    shr BX , 10
    and BX , 0000000000000111b ; BX = 0000000000000110
    or [c] ,BX ; 
    or word[c] , 0000000000111000b ; c = 00000000001111
    mov AX , [a]
    rol AX , 6
    and AX , 0000011110000000b ; c = 
    or [c] , AX
    and word[c] , 1110011111111111b
    mov BX , [b]
    mov CL , 4
    rol BX ,CL
    and BX , 1110000000000000b
    or [c] , BX
    
     
     
     
     
     
     
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   