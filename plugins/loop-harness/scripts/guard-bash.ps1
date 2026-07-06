# PreToolUse(Bash): block deploy/destroy. Exit 2 blocks the tool call and shows stderr to Claude.
$raw = [Console]::In.ReadToEnd()
$cmd = ''
try { $cmd = ($raw | ConvertFrom-Json).tool_input.command } catch { $cmd = '' }
$deny = 'az\s+deployment|az\s+group\s+(create|delete)|func\s+azure.*publish|git\s+push.*(--force|-f\b)|rm\s+-rf\s+/|Remove-Item\s+-Recurse\s+-Force\s+[\\/]|terraform\s+apply|kubectl\s+(apply|delete)|helm\s+(install|upgrade)'
if ($cmd -match $deny) {
  [Console]::Error.WriteLine("Deployment or destructive command blocked by loop-harness. Deployment is pipeline-only with a human approval gate; author the change and stop. If this is a false positive, run it yourself.")
  exit 2
}
exit 0
