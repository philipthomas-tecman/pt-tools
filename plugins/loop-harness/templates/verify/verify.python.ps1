param([switch]$Fast)
$ErrorActionPreference = 'Stop'
function Stage($n,$b){ Write-Host "== $n =="; & $b; if($LASTEXITCODE -ne 0){ Write-Error "$n failed"; exit 1 } }
Stage 'lint' { ruff check . }
Stage 'test' { pytest -q }
Stage 'secrets' { if (Select-String -Path (Get-ChildItem -Recurse -Include *.py -ErrorAction SilentlyContinue) -Pattern 'AKIA|BEGIN PRIVATE KEY|password\s*=' -List) { Write-Error 'possible secret'; exit 1 } else { 'clean' } }
if(-not $Fast){ Write-Host '== full-only stages (evals) here ==' }
Write-Host 'verify OK'
