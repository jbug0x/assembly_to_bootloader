ORG 0x1000

push jump_back
jmp print_hello

jump_back:
    mov AH, 0x13
    mov BP, message_back
    mov CX, 0x10
    mov DL, 0x0
    mov DH, 0xd
    mov BH, 0x0
    mov AL, 0x01
    mov BL, 0x0f
    
    int 0x10

print_hello:
    mov AH, 0x13        ; AH = 13H  - write string
    mov BP, message     ; BP        - addrees message
    mov CX, 0x24        ; CX        - character-only count
    ;mov DX, 0          ; DX        - string possition
    mov DL, 0x0         ; DL        - Column
    mov DH, 0xc         ; DH        - Line
    mov BH, 0x0         ; BH        - page number
    mov AL, 0x01        ; AL        - attribute mode
    mov BL, 0x0f        ; Bl        - attribute (AL=0 or AL=1)
    int 0x10            ; INT 10H   - Video
    
    pop AX
    jmp AX

message: DB "Hello World! Sou um programa em asm!"
message_back: DB "Hello novamente!"
