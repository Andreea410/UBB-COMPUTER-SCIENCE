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

    s1 db 1,2,3,4,5
    l1 equ $-s1
    s2 db 6, 7,8
    l2 equ $-s2
    lend equ l1+l2
    d times lend db 0
    
   
    
; our code starts here
segment code use32 class=code
    start:
    
    mov ECX , lend
    mov ECX , l1
    mov ESI , 0 ;iterator sir sursa
    mov EDI , 0 ;iterator sir destinatie
    jecxz afterloop1
    loop1
        mov AL , [s1+ESI]
        mov [d+EDI] ,AL
        inc ESI
        inc EDI
    loop loop1
    afterloop1
    mov ECX , l2
    jecxz afterloop2
    mov ESI , l2-1
    loop2
        mov AL , [s2+ESI]
        mov [d+EDI] , AL
        dec ESI
        inc EDI
    loop loop2
    afterloop2
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   