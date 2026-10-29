$ErrorActionPreference = "Stop"

# Equivalente ao: dd if=<src> of=<dst> bs=512 count=<count> seek=<seek> conv=notrunc
function Write-Sectors {
    param(
        [string]$Src,
        [string]$Dst,
        [int]$Seek = 0,
        [int]$Count = 1,
        [int]$BlockSize = 512
    )
    # Caminhos absolutos: o .NET não usa o diretório atual do PowerShell
    $srcPath = Join-Path $PWD $Src
    $dstPath = Join-Path $PWD $Dst

    $data = [System.IO.File]::ReadAllBytes($srcPath)
    $len  = [Math]::Min($data.Length, $BlockSize * $Count)   # count=1 -> no máx. 512 bytes

    # OpenOrCreate + Write = não trunca (conv=notrunc)
    $fs = [System.IO.File]::Open($dstPath, 'OpenOrCreate', 'Write')
    try {
        $fs.Seek([long]$Seek * $BlockSize, 'Begin') | Out-Null  # seek=N setores
        $fs.Write($data, 0, $len)
    } finally {
        $fs.Close()
    }
}

nasm -f bin -o boot boot.S
if ($LASTEXITCODE -ne 0) { throw "nasm falhou" }
Write-Host "nasm compilado"

Write-Sectors -Src "boot" -Dst "diskette" -Seek 0 -Count 1
Write-Host "salvo no diskette"

nasm -f bin -o hello "./old/hello.asm"

Write-Sectors -Src "hello" -Dst "diskette" -Seek 1 -Count 1
Write-Host "salvo o hello no diskette"

Write-Host "Rodando emulador"
& qemu-system-i386 -cpu pentium -m 32 -drive file=diskette,if=floppy,media=disk,format=raw,index=0
