[BITS 16]       
ORG 0x7C00    

start:
    mov si, message  
    call print_string 

    call switch_to_pm

    jmp 0x10000  

    jmp $

print_string:
    mov ah, 0x0E    
.loop:
    lodsb         
    or al, al      
    jz done
    int 0x10        
    jmp .loop
done:
    ret

message db 'Booting OS...', 0  

switch_to_pm:
    cli                    
    lgdt [gdt_descriptor]   

    mov eax, cr0
    or eax, 1
    mov cr0, eax           

    jmp CODE_SEG:init_pm   

gdt:
    dq 0               
    dq 0x00CF9A000000FFFF 
    dq 0x00CF92000000FFFF 

gdt_descriptor:
    dw gdt_descriptor - gdt - 1
    dd gdt

[BITS 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov esp, 0x90000  

    jmp 0x10000  

CODE_SEG equ 0x08
DATA_SEG equ 0x10

times 510 - ($-$$) db 0 
dw 0xAA55
