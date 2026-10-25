nasm -o boot boot.S
echo "nasm compilado"

dd if=boot of=diskette bs=512 count=1 conv=notrunc
echo "salvo no diskette"

dd if=test.txt of=diskette bs=512 count=1 conv=notrunc seek=2
echo "salvo o test.txt no diskette"

echo "Rodando emulador"
qemu-system-i386 -cpu pentium -m 32 -drive file=diskette,if=floppy,media=disk,format=raw,index=0

