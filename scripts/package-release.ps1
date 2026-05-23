param(
  [Parameter(Mandatory=$true)]
  [ValidatePattern('^v\d+\.\d+\.\d+$')]
  [string]$Version
)

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$Dist = Join-Path $Root 'dist'
$FullDir = Join-Path $Dist "NJFU-LaTeX-Template-$Version"
$OverleafDir = Join-Path $Dist "njfu-course-paper-$Version-overleaf"

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Dist
New-Item -ItemType Directory -Force $FullDir, $OverleafDir | Out-Null

$exclude = @('.git', 'dist')
Get-ChildItem $Root -Force | Where-Object { $exclude -notcontains $_.Name } | ForEach-Object {
  Copy-Item $_.FullName -Destination $FullDir -Recurse -Force
}

Copy-Item (Join-Path $Root 'templates/njfu-course-paper/*') -Destination $OverleafDir -Recurse -Force

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

Compress-Archive -Path "$FullDir\*" -DestinationPath (Join-Path $Dist "NJFU-LaTeX-Template-$Version.zip") -Force
Compress-Archive -Path "$OverleafDir\*" -DestinationPath (Join-Path $Dist "njfu-course-paper-$Version-overleaf.zip") -Force

Copy-Item (Join-Path $FullDir 'main.pdf') (Join-Path $Dist "main-$Version.pdf") -Force
Copy-Item (Join-Path $OverleafDir 'main.pdf') (Join-Path $Dist "njfu-course-paper-$Version.pdf") -Force

Get-ChildItem $Dist -File | Select-Object Name,Length
