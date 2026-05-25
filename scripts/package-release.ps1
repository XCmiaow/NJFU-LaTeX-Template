param(
  [Parameter(Mandatory=$true)]
  [ValidatePattern('^v\d+\.\d+\.\d+$')]
  [string]$Version
)

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Dist = Join-Path $Root 'dist'
$Stage = Join-Path $Dist '_stage'
$FullDir = Join-Path $Stage "NJFU-LaTeX-Template-$Version"
$OverleafDir = Join-Path $Stage "njfu-course-paper-$Version-overleaf"

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Dist
New-Item -ItemType Directory -Force $FullDir, $OverleafDir | Out-Null

function New-ZipFromDirectory {
  param(
    [Parameter(Mandatory=$true)]
    [string]$SourceDir,
    [Parameter(Mandatory=$true)]
    [string]$DestinationPath
  )

  Add-Type -AssemblyName System.IO.Compression
  Add-Type -AssemblyName System.IO.Compression.FileSystem

  Remove-Item -Force -ErrorAction SilentlyContinue $DestinationPath
  $sourceRoot = (Resolve-Path $SourceDir).Path
  $zip = [System.IO.Compression.ZipFile]::Open($DestinationPath, [System.IO.Compression.ZipArchiveMode]::Create)
  try {
    Get-ChildItem $sourceRoot -Force -Recurse -File | ForEach-Object {
      $relative = $_.FullName.Substring($sourceRoot.Length).TrimStart([char[]]@(
        [System.IO.Path]::DirectorySeparatorChar,
        [System.IO.Path]::AltDirectorySeparatorChar
      ))
      $entryName = $relative -replace '\\', '/'
      [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $zip,
        $_.FullName,
        $entryName,
        [System.IO.Compression.CompressionLevel]::Optimal
      ) | Out-Null
    }
  } finally {
    $zip.Dispose()
  }
}

$exclude = @('.git', 'dist')
Get-ChildItem $Root -Force | Where-Object { $exclude -notcontains $_.Name } | ForEach-Object {
  Copy-Item $_.FullName -Destination $FullDir -Recurse -Force
}

Get-ChildItem (Join-Path $Root 'templates/njfu-course-paper') -Force |
  Where-Object { $_.Name -ne '.gitignore' } |
  ForEach-Object { Copy-Item $_.FullName -Destination $OverleafDir -Recurse -Force }

Push-Location $FullDir
try {
  latexmk -xelatex -interaction=nonstopmode main.tex
} finally {
  Pop-Location
}

Push-Location $OverleafDir
try {
  latexmk -xelatex -interaction=nonstopmode main.tex
} finally {
  Pop-Location
}

Copy-Item (Join-Path $FullDir 'main.pdf') (Join-Path $Dist "main-$Version.pdf") -Force
Copy-Item (Join-Path $OverleafDir 'main.pdf') (Join-Path $Dist "njfu-course-paper-$Version.pdf") -Force

foreach ($dir in @($FullDir, $OverleafDir)) {
  Push-Location $dir
  try {
    latexmk -C main.tex
    Remove-Item -Force -ErrorAction SilentlyContinue 'main.pdf'
  } finally {
    Pop-Location
  }

  foreach ($name in @('main.aux', 'main.bbl', 'main.blg', 'main.fdb_latexmk', 'main.fls', 'main.log', 'main.out', 'main.synctex.gz', 'main.toc', 'main.xdv')) {
    Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $dir $name)
  }
}

New-ZipFromDirectory -SourceDir $FullDir -DestinationPath (Join-Path $Dist "NJFU-LaTeX-Template-$Version.zip")
New-ZipFromDirectory -SourceDir $OverleafDir -DestinationPath (Join-Path $Dist "njfu-course-paper-$Version-overleaf.zip")

Remove-Item -Recurse -Force $Stage

Get-ChildItem $Dist -File | Select-Object Name,Length
