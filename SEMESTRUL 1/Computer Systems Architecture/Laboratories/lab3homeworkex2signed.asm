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
    b db 2
    c db 3
    e dd 4
    x dq 5
    
; our code starts here
segment code use32 class=code
    start:
      ; a/2 + b*b - a*b*c +e + x -signed
      
      mov AL , [a]
      CBW ; AX = a -->word
      mov BL , 2
      idiv BL ;AL =a/2 -->byte
      CBW ;AX =a/2 -- word
      mov BX , AX ; BX=a/2 --word
      
      mov AL ,byte [b]
      imul AL ; AX = b*b --word
      
      add BX , AX ; BX=a/2 + b*b --word
      CWD ; CX:BX = a/2 + b*b --dd
      push CX
      push BX
      
      mov AL , [a] 
      imul byte[b] ; AX = a*b
      mov BL , [c]
      CBW
      imul BX ; DX:AX = a*b*c
      
      pop EBX ;EBX = a/2 +b*b ->dd
      
      push DX
      push AX
      pop EAX ; EAX =a*b*c ->dd
      
      sub EBX , EAX ;EBX = a/2 + b*b -a*b*c - dd
      
      add EBX , dword[e] ;EBX = a/2 +b*b -a*b*c + e ->dd
      
      mov EAX , EBX ;EAX = a/2 +b*b -a*b*c + e ->dd
      
      CDQ ; EDX:EAX = a/2 +b*b -a*b*c + e ->dd
      
      add EAX , dword[x]
      adc EDX , dword[x+4]
      
      
      
      
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   