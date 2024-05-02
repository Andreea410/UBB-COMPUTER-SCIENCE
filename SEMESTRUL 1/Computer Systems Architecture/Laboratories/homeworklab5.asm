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

    a dd 10111011101110111011101110111011b
    b dw 1011100110011001b 
    c dw 0
    d db 0
   
    
; our code starts here
segment code use32 class=code
    start:
    ;Given the doubleword A and the word B, compute the word C as follows:
        ;the bits 0-4 of C are the invert of the bits 20-24 of A
        ;the bits 5-8 of C have the value 1
        ;the bits 9-12 of C are the same as the bits 12-15 of B
        ;the bits 13-15 of C are the same as the bits 7-9 of A
    
        mov EAX , [a]
        shr EAX , 4
        and EAX , 00000000000111110000000000000000b ; EAX = 0000000000000000000000000000000
        not EAX ; EAX = 11111111101010011111111111111111
        push EAX
        pop DX
        pop AX
        or word[c] ,DX ; c=000000000001010
        or word[c] , 0000000111100000b
        mov BX , [b]
        shr BX , 3
        or word[c] , BX
        mov EAX , [a]
        shl EAX , 22
        push EAX , 
        pop DX 
        pop AX
        or word[c] , DX
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   