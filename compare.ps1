# Solicitar ao usu�rio os caminhos das pastas
$dir1 = Read-Host "Digite o caminho da primeira pasta"
$dir2 = Read-Host "Digite o caminho da segunda pasta"

# Verificar se os diret�rios foram fornecidos e existem
if (-not (Test-Path -Path $dir1)) {
    Write-Host "O diret�rio 1 n�o foi fornecido ou n�o existe: $dir1" -ForegroundColor Red
    exit
}
if (-not (Test-Path -Path $dir2)) {
    Write-Host "O diret�rio 2 n�o foi fornecido ou n�o existe: $dir2" -ForegroundColor Red
    exit
}

function Compare-Files {
    param (
        [string]$file1,
        [string]$file2
    )
 
    # Ler o conte�do dos arquivos, ignorando as primeiras duas linhas
    $file1Content = Get-Content $file1 | Select-Object -Skip 2
    $file2Content = Get-Content $file2 | Select-Object -Skip 2
 
    # Unir o conte�do em strings para compara��o
    $file1ContentString = $file1Content -join "`n"
    $file2ContentString = $file2Content -join "`n"
 
    # Comparar o conte�do e, se diferente, logar e copiar o arquivo modificado
    if ($file1ContentString -ne $file2ContentString) {
        Write-Output (Get-Item $file2).Name
        
        # Log das diferen�as
        Add-Content -Path $logfile -Value "Diferen�a encontrada em $file1 e $file2"
        Add-Content -Path $logfile -Value "Diferen�as:"
        $diff = Compare-Object -ReferenceObject $file1Content -DifferenceObject $file2Content -IncludeEqual
        $diff | ForEach-Object {
            Add-Content -Path $logfile -Value "Linha: $($_.SideIndicator) $($_.InputObject)"
        }

        # Copiar os arquivos diferentes para a pasta de sa�da
        Copy-Item -Path $file2 -Destination $output -Force
    } else {
        Add-Content -Path $logfile -Value "Arquivos $file1 e $file2 s�o iguais"
    }
}

# Extrair o nome das pastas para criar o nome da pasta de sa�da
$dir2Name = Split-Path -Path $dir2 -Leaf

$output = Join-Path -Path $PSScriptRoot -ChildPath "${dir2Name}_output"

# Criar a pasta de sa�da na raiz onde o script est� sendo executado
New-Item -ItemType Directory -Path $output -Force | Out-Null

# Criar arquivo de log
$logfile = Join-Path -Path $PSScriptRoot -ChildPath "comparison_log.txt"
"Log de compara��o - $(Get-Date)" > $logfile

# Feedback visual para o usu�rio
Write-Host "Iniciando a compara��o dos arquivos..." -ForegroundColor Green

# Obter a lista de arquivos no primeiro diret�rio
$files1 = Get-ChildItem -Path $dir1 -File -Recurse
 
foreach ($file in $files1) {
    $relativePath = $file.FullName.Substring($dir1.Length + 1)
    $filePath2 = Join-Path -Path $dir2 -ChildPath $relativePath
 
    # Verificar se o arquivo existe no segundo diret�rio
    if (Test-Path $filePath2) {
        Write-Host "Comparando $($file.FullName) com $filePath2"
        Compare-Files -file1 $file.FullName -file2 $filePath2
    } else {
        Add-Content -Path $logfile -Value "Arquivo $filePath2 n�o encontrado"
    }
}

Write-Host "Compara��o completa. Verifique $output para arquivos alterados." -ForegroundColor Green
Write-Host "Verifique o arquivo de log para mais detalhes: $logfile" -ForegroundColor Green
pause
