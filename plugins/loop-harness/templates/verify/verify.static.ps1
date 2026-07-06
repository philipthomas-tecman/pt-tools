param([switch]$Fast)
$ErrorActionPreference = 'Stop'
function Stage($n,$b){ Write-Host "== $n =="; & $b; if($LASTEXITCODE -ne 0){ Write-Error "$n failed"; exit 1 } }
Stage 'build' { npm run build --if-present }
Stage 'links' { Write-Host 'run a link checker here (e.g. lychee)' }
if(-not $Fast){ Stage 'lighthouse' { Write-Host 'Lighthouse CI here' }; Stage 'a11y' { Write-Host 'accessibility check here (e.g. pa11y)' } }
Write-Host 'verify OK'
