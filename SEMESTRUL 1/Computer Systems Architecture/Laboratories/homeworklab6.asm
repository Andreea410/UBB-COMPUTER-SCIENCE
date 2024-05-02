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

    s1 db 1, 10 , 8, 4
    l1 equ $-s1
    s2 db 5 ,6, 7, 8
    l2 equ $-s2
    lend equ l1+l2
    d times lend db 0
    
   
    
; our code starts here
segment code use32 class=code
    start:
    ;Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element contains the minimum of the corresponding elements from S1 and S2.
        ;S1: 1, 3, 6, 2, 3, 7
        ;S2: 6, 3, 8, 1, 2, 5
        ;D: 1, 3, 6, 1, 2, 5
        
    mov ECX , l1
    mov ESI , 0
    mov EDI , 0
    jecxz after_obtaining_d
    loop_obtaining_d
        mov AL , [s1+ESI]
        mov BL , [s2+EDI]
        cmp AL , BL
        ja greater
        jb lower
        greater:
            mov [d+ESI] , BL
            inc ESI
            inc EDI
            dec ECX
            jecxz after_obtaining_d
            ja loop_obtaining_d
        
        lower:
            mov [d+EDI], AL
        inc EDI
        inc ESI
    loop loop_obtaining_d
    after_obtaining_d
        
    
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   