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
    b dw 1
    c dd 3
    d dq 4
    
; our code starts here
segment code use32 class=code
    start:
     
     ;(d + c) - (c + b) - (b + a) -unsigned
      
     mov EAX , dword[c]
     mov EDX , 0 
     add EAX , dword[d]
     adc EDX , dword[d+4]
     
    ;EDX:EAX = d+c --dq
    
     mov BX , word[b]
     mov CX , 0 ; CX:BX = b ->dd
     
     add BX , word[c]
     adc CX , word[c+2]
     
     ;CX:BX = c+b -- dd
     
     push CX
     push BX
     pop EBX
     mov ECX , 0
     
     ;ECX:EBX = c+d -dq
     
     sub EAX , EBX
     sbb EDX , ECX
     ;EDX:EAX = (d+c) - (c+b) -dq
     
     mov BX , word[b]
     mov AL , byte[a]
     mov AH , 0
     add BX , AX
     
     ;BX = b+a -- dw
     
     mov CX , 0 ; CX:BX = b+a -- dd
     push CX
     push BX
     pop EBX 
     mov ECX , 0  ; ECX:EBX =b+a -dq
     
     sub EAX , EBX
     sbb EDX , ECX
     ;EDX:EAX = (d+c) - (c+b) -(b+a) -dq
     

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   