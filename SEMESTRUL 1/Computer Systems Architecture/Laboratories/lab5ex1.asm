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

    a db 01010101b
    b db 0
   
    
; our code starts here
segment code use32 class=code
    start:
    
    mov AL , [a]
    not AL  ;AL = 10101010b
    and AL , 00000111b ;AL = 00000010
    or [b] , AL ; b=00000010b
    or byte[b] , 00011000b ; b = 00011010b
    mov AL , [a]
    SHL byte[a] , 2 ;a = 01010100b
    and byte[a] , 11100000b ; a=01000000b
    or byte[b] , AL
     
     
     
     
     
     
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   