param()

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Canonical = Join-Path $Root 'NJFUReport.sty'
$Copies = @(
  'templates/njfu-course-paper/NJFUReport.sty',
  'templates/personal-quickstart/NJFUReport.sty'
)

$canonicalHash = (Get-FileHash $Canonical -Algorithm SHA256).Hash
$failed = $false

foreach ($copy in $Copies) {
  $path = Join-Path $Root $copy
  if (-not (Test-Path $path)) {
    Write-Error "Missing style copy: $copy"
    $failed = $true
    continue
  }

  $copyHash = (Get-FileHash $path -Algorithm SHA256).Hash
  if ($copyHash -ne $canonicalHash) {
    Write-Error "Style copy is out of sync: $copy"
    $failed = $true
  }
}

if ($failed) {
  exit 1
}

Write-Host 'All template style copies are synchronized.'
