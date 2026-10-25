# Compilando o boot
 
## Compilando bootloader:
nasm -o boot boot.S 

## Criando o diskette falso:
Criando um arquivo de 1.44MB de bytes nulos
```bash
dd if=/dev/zero of=diskette bs=1474560 count=1 conv=notrunc
```

Transferir o bootloader
```bash
dd if=boot of=diskette bs=512 count=1 conv=notrunc
```

Trasnferir outros arquivos
```bash
dd if=test.txt of=diskette bs=512 seek=1 count=1 conv=notrunc
```
## Rodando o QEMU
```bash
qemu-system-i386 -cpu pentium -m 32 -drive file=diskette,if=floppy,media=disk,format=raw,index=0
```
