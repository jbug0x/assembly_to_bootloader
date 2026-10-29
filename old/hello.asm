ORG 0x1000

mov AH, 0x13    ; AH = 13H  - write string
mov BP, message ; BP        - addrees message
mov CX, 11      ; CX        - character-only count
mov DX, 0       ; DX        - string possition
mov BH, 0       ; BH        - page number
mov AL, 0x01    ; AL        - attribute mode
mov BL, 0x0f    ; Bl        - attribute (AL=0 or AL=1)

int 0x10        ; INT 10H   - Video

message: DB "Hello World"
