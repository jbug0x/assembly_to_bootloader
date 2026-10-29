%define BUFFER 0x1000

ORG 0x7C00

mov [driverNumber], DL

mov word [0x1000], 35
mov AX, [0x1000]

mov AH, 0x02            ; AH = 02H  - read desired sectors into memory
mov DL, [driverNumber]  ; DL        - number drive disc to read
mov DH, 0               ; DH        - head
mov CH, 0               ; CH        - cylinder
mov CL, 2               ; CL        - sector
mov BX, BUFFER          ; BX        - buffer memory
mov AL, 1               ; AL        - Count sector to read

int 0x13                ; INT 13H Diskette

jmp BUFFER

;===== Print String ======= 
;mov AH, 0x13            ; AH = 13H  - write string
;mov BP, BUFFER          ; BP        - addrees message
;mov CX, 50              ; CX        - character-only count
;mov DH, 0x0A            ; DH        - Line possition
;mov DL, 0x0             ; DL        - Column possition
;mov BH, 0               ; BH        - page number
;mov AL, 0x01            ; AL        - attribute mode
;mov BL, 0x0f            ; Bl        - attribute (AL=0 or AL=1)

;int 0x10                ; INT 10H   - Video
;=============================

driverNumber: DB 0;

TIMES 510 - ($ - $$) DB 0x0

DW 0xAA55               ; magic number
