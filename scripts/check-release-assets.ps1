param(
  [Parameter(Mandatory=$true)]
  [ValidatePattern('^v\d+\.\d+\.\d+$')]
  [string]$Version
)

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Dist = Join-Path $Root 'dist'
Add-Type -AssemblyName System.IO.Compression.FileSystem

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

function Test-ZipEntries {
  param(
    [Parameter(Mandatory=$true)]
    [string]$ZipPath,
    [Parameter(Mandatory=$true)]
    [scriptblock]$Predicate,
    [Parameter(Mandatory=$true)]
    [string]$ErrorMessage
  )

  $zip = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
  try {
    $matches = $zip.Entries | Where-Object $Predicate
    if ($matches) {
      $names = ($matches | Select-Object -ExpandProperty FullName) -join ', '
      Write-Error "$ErrorMessage $names"
      exit 1
    }
  } finally {
    $zip.Dispose()
  }
}

$fullZip = Join-Path $Dist "NJFU-LaTeX-Template-$Version.zip"
$overleafZip = Join-Path $Dist "njfu-course-paper-$Version-overleaf.zip"
$assetNames = @(
  "NJFU-LaTeX-Template-$Version.zip",
  "njfu-course-paper-$Version-overleaf.zip",
  "main-$Version.pdf",
  "njfu-course-paper-$Version.pdf"
)
$generatedExtensions = @('.aux', '.bbl', '.blg', '.fdb_latexmk', '.fls', '.log', '.out', '.synctex.gz', '.toc', '.xdv')

Test-ZipEntries -ZipPath $fullZip -Predicate {
  $entry = $_
  $assetNames | Where-Object { $entry.FullName -eq $_ -or $entry.FullName.EndsWith("/$_") }
} -ErrorMessage 'Full source zip contains release assets:'

foreach ($zipPath in @($fullZip, $overleafZip)) {
  Test-ZipEntries -ZipPath $zipPath -Predicate {
    $entry = $_
    $generatedExtensions | Where-Object { $entry.FullName.EndsWith($_) }
  } -ErrorMessage "Zip contains generated LaTeX files:"
}

Write-Host "Release assets are present and clean for $Version."
