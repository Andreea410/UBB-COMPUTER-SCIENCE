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

    a db 4
    b dw 1
    c dd 3
    d dq 2
    
; our code starts here
segment code use32 class=code
    start:
      
      ;(c + b) - (a -d +b) --signed
      
     mov BX , [b]
     mov CX , 0 ; CX:BX = b --dd
     add BX , word[c]
     adc CX , word[c+2] ;CX:BX = c+b --dd
     mov [c] , BX
     
     
     mov AL , [a]
     CBW ;AX = a --dw
     CWD ;DX:AX = a --dd
     CDQ ; EDX:EAX = a -dq
     sub EAX , dword[d]
     sbb EDX , dword[d+4] ; EDX:EAX = a-d --dq
     
     mov BX , [b]
     CWD ; CX:BX = b -- dd
     CDQ ; ECX:EBX = b  --dq
     add EAX , EBX
     adc EDX , ECX 
     ;EDX:EAX = a-d+b -dq
     
     mov EBX , [c]
     CDQ
     sub EAX , EBX
     sbb EDX , ECX
     
     
     
     
     
     
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   