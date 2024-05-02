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
      ; a/2 + b*b - a*b*c +e + x -unsigned
      
      mov AL , [a]
      mov AH , 0 ;AX =a -->word
      mov BL , 2
      div BL ; AL = a/2 -- byte
      mov BL , AL ; BL=a/2
      mov BH , 0 ; BX =a/2 -->word
      
      mov AL ,byte [b]
      mul AL ; AX = b*b -- word
      
      add BX , AX ; BX=a/2 + b*b 
      mov CX , 0 ; CX:BX = a/2 + b*b --dd
      push CX 
      push BX
      
      mov AL , [a] 
      mul byte[b] ;AX = a*b --word
      mov BL , [c]
      mov BH , 0 ; BX = c --word
      mul BX ; DX:AX = a*b*c --dd
      
      pop EBX ;EBX =  a/2 + b*b --dd
      
      push DX
      push AX
      pop EAX ;EAX = a*b*c --dd
      
      sub EBX , EAX  ; EBX = a/2 + b*b -a*b*c --> dd
      
      add EBX , dword[e]; EBX = a/2 + b*b -a*b*c +e --> dd
      
      mov ECX , 0 ;ECX:EBX = a/2 + b*b -a*b*c+e - dq
      
      add EBX , dword[x]
      adc ECX , dword[x+4]
      
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

                   