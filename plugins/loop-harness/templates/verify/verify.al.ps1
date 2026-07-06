param([switch]$Fast)
$ErrorActionPreference = "Stop"
function Stage($n,$b){ Write-Host "== $n ==" ; & $b ; if($LASTEXITCODE -ne 0){ Write-Error "$n failed"; exit 1 } }
# Business Central / AL. Wire to your AL-Go / alc compiler and test toolchain:
Stage "compile" { Write-Host "run: alc.exe or AL-Go build here"; }
Stage "test"    { Write-Host "run: BC test toolkit here"; }
Stage "secrets" { if (Select-String -Path (Get-ChildItem -Recurse -Include *.al,*.json) -Pattern 'BEGIN PRIVATE KEY|password\s*=' -List) { Write-Error "possible secret"; exit 1 } else { "clean" } }
if(-not $Fast){ Write-Host "== full-only stages here ==" }
Write-Host "verify OK"
