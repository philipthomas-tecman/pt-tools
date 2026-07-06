# SessionStart: print the standing spec and current state as plain text.
# For SessionStart, stdout is added to Claude's context. This is the anti-drift brake.
$parts = @()
$vision = if (Test-Path 'docs/VISION.md') { 'docs/VISION.md' } elseif (Test-Path 'VISION.md') { 'VISION.md' } else { $null }
if ($vision) { $parts += "===== $vision (standing spec, reread every session) =====`n" + (Get-Content -Raw $vision) }
$state = Get-ChildItem -Path 'STATE.md','*/STATE.md','tools/*/STATE.md','agents/*/STATE.md' -File -ErrorAction SilentlyContinue | Select-Object -First 1
if ($state) { $parts += "===== $($state.FullName) (where we are) =====`n" + (Get-Content -Raw $state.FullName) }
if (Test-Path 'openwiki') { $parts += "When you need codebase context, read openwiki/ first (index.md, architecture.md) before searching the tree." }
if ($parts.Count -gt 0) { Write-Output ($parts -join "`n`n") }
exit 0
