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

    s db 1,2,3,4,5
    l equ $-s ; l=len(s)
    lend equ l-1 
    d times lend db 0
    
   
    
; our code starts here
segment code use32 class=code
    start:
    
    mov ECX , lend
    mov ESI , 0 ;ESI-pargurge variabila bite cu byte
    jecxz final ;verific daca ecx = 0 , ecx-numarul de cate ori se face 
    repeat:
        mov AL , [s+ESI]
        mov BL , [s+ESI+1]
        add AL , BL
        mov [d+ESI] , AL
        inc ESI
        loop repeat
    final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   