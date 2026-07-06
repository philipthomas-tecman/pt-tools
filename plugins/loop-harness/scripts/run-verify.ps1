# Stop: run the project's build/verify.ps1 -Fast. On failure, emit {decision:block,reason} so Claude
# cannot finish; on pass (or when no verify script exists), print nothing and exit 0.
if (Test-Path 'build/verify.ps1') {
  $out = & pwsh -NoProfile -File 'build/verify.ps1' -Fast 2>&1 | Out-String
  $rc = $LASTEXITCODE
  if ($rc -ne 0) {
    $tail = (($out -split "`n") | Select-Object -Last 25) -join "`n"
    (@{ decision = 'block'; reason = "verify gate FAILED (exit $rc). Do not finish. Fix and re-run build/verify.ps1. Tail:`n$tail" }) | ConvertTo-Json -Compress
  }
}
exit 0
