param(
  [Parameter(Mandatory=$true)]
  [ValidatePattern('^v\d+\.\d+\.\d+$')]
  [string]$Version
)

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Dist = Join-Path $Root 'dist'

$expected = @(
  "NJFU-LaTeX-Template-$Version.zip",
  "njfu-course-paper-$Version-overleaf.zip",
  "main-$Version.pdf",
  "njfu-course-paper-$Version.pdf"
)

foreach ($name in $expected) {
  $path = Join-Path $Dist $name
  if (-not (Test-Path $path)) {
    Write-Error "Missing release asset: $name"
    exit 1
  }

  if ((Get-Item $path).Length -le 0) {
    Write-Error "Release asset is empty: $name"
    exit 1
  }
}

Write-Host "Release assets are present for $Version."
