bits 32 ; assembling for the 32 bits architecture

global start
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

section data use32 class=data
    file_name db "solution.txt" , 0 
    a dw 543
    sir dd "Ana", 0
    
    access_mode db "a", 0           ; file access mode:                 
    file_descriptor dd 10          ; variable to hold the file descriptor

section code use32 class=code
start:
    
    ;A file name and a decimal number (on 16 bits) are given (the decimal number is in the unsigned interpretation). Create a file with the given name and write each digit composing the number on a different line to file.
    
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack
        
        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        
        mov ax, word[a]    
        mov cx, 10    

        cmp ax , 0
        ja divide 

    divide:
        mov dx , 0       ; high part = 0
        push dx
        push ax
        pop eax 
        div cx             
        mov bx , ax
        mov ax, dx
        add ax, '0'
        mov dx , 0
        push dx
        push ax
        pop eax
        push dword eax 
        push dword [file_descriptor]
        call [fprintf]
        add esp ,4*2
        
        mov ax , bx
        
        cmp ax , 0
        ja divide
            
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
        
    final:
        
    
      
    
    ; exit(0)
    push dword 0         ; push the parameter for exit onto the stack
    call [exit]          ; call exit to terminate the program
