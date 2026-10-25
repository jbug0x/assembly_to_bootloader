ORG 0x7C00

mov word [0x1000], 35
mov AX, [0x1000]

mov AH, 0x13        ; AH = 13H  - write string
mov BP, m_hello     ; BP        - addrees message
mov CX, 0xB         ; CX        - character-only count
mov DX, 0x09F0      ; DX        - string possition (column - line)
mov BH, 0           ; BH        - page number
mov AL, 0x01        ; AL        - attribute mode
mov BL, 0x0f        ; Bl        - attribute (AL=0 or AL=1)

int 0x10            ; INT 10H   - Video

mov AH, 0x13        ; AH = 13H  - write string
mov BP, m_second    ; BP        - addrees message
mov CX, 0x10        ; CX        - character-only count
mov DH, 0x0A        ; DH        - Line possition
mov DL, 0xF0        ; DL        - Column possition
mov BH, 0           ; BH        - page number
mov AL, 0x01        ; AL        - attribute mode
mov BL, 0x0f        ; Bl        - attribute (AL=0 or AL=1)

int 0x10            ; INT 10H   - Video

m_hello: DB "Hello World!"
m_second: DB "It's bootloader?"

TIMES 510 - ($ - $$) DB 0x0

DW 0xAA55 ; magic number
