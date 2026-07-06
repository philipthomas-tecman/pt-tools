param([switch]$Fast)
$ErrorActionPreference = 'Stop'
function Stage($n,$b){ Write-Host "== $n =="; & $b; if($LASTEXITCODE -ne 0){ Write-Error "$n failed"; exit 1 } }
Stage 'build' { npm run build --if-present }
Stage 'test'  { npm test --silent }
Stage 'lint'  { npm run lint --if-present }
# Stage 'contract' { npx spectral lint contract/openapi.yaml }
Stage 'secrets' { if (Select-String -Path (Get-ChildItem -Recurse -Include *.ts,*.js,*.json -ErrorAction SilentlyContinue) -Pattern 'AKIA|BEGIN PRIVATE KEY|password\s*=' -List) { Write-Error 'possible secret'; exit 1 } else { 'clean' } }
if(-not $Fast){ Write-Host '== full-only stages (e2e, evals) here ==' }
Write-Host 'verify OK'
