bits 32 ; assembling for the 32 bits architecture


global start
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf

%include "seminar10homework2.asm"

section data use32 class=data
    array_size dd  0      ; Size of the array
    s1 times 100 db 0 
    s2 times 100 db 0
    solution times 100 db 0
    number times 100 dd 0
    message1 db "Enter the number of elements: ", 0
    message2 db "Introduce s1: ", 0    
    format  db "%s", 0     
    aux db 0
section code use32 class=code
start:
    ;Read a string of integers s1 (represented on doublewords) in base 10. Determine and display the string s2 composed by the digits in the hundreds place of each integer in the string s1.
        ;Example:    The string s1: 5892, 456, 33, 7, 245
        ;The string s2: 8, 4,   0,  0, 2
    

    push dword message2
    call [printf]
    add esp, 4
    push dword s1
    push dword format
    call [scanf]
    add esp, 8
    
    mov esi ,0
    mov edi , 0
    push esi
    mov esi , 0
    
    mov bl, 100
    mov cl , 10
    
    
    
    function:
        
        
        movzx eax , byte[s1+esi]
        inc esi
        cmp eax , '0'
        jb constructs2
        cmp eax , '9'
        ja constructs2
        push eax
        ;call converting_to_number 

        mov byte[solution+edi] , al
        inc edi
 
        jmp function
        
        constructs2:
            mov ax , solution
            mov dx , '0'
            sub ax , dx
            div bx
            mov ah , 0
            div cx
            mov byte[s2+edi] , ah
            inc edi
            
        
            
       
        
    push dword s2
    call [printf]
    add esp , 4
        
        
        
       

    ; Exit the program
    push dword 0         ; push the parameter for exit onto the stack
    call [exit]          ; call exit to terminate the program
