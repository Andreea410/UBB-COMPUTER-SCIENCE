

converting_to_number:
    ;ret = [esp]
    ;eax= [esp+4]
    mov eax , [esp+4]
    sub eax , '0'
    ret 4