param([switch]$Fast)
$ErrorActionPreference = "Stop"
function Stage($n,$b){ Write-Host "== $n ==" ; & $b ; if($LASTEXITCODE -ne 0){ Write-Error "$n failed"; exit 1 } }
Stage "build"  { dotnet build -warnaserror }
Stage "test"   { dotnet test --nologo }
# Wire the remaining stages to your project:
# Stage "contract" { spectral lint (Get-ChildItem -Recurse contract/openapi.yaml) }
# Stage "gate"     { pwsh ./build/human-gate-check.ps1 }
Stage "secrets"{ if (Select-String -Path (Get-ChildItem -Recurse -Include *.cs,*.json,*.yaml,*.yml) -Pattern 'AKIA|BEGIN PRIVATE KEY|password\s*=' -List) { Write-Error "possible secret"; exit 1 } else { "clean" } }
if(-not $Fast){ Write-Host "== full-only stages (eval, bicep) go here ==" }
Write-Host "verify OK"
