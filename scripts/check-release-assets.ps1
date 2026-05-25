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

$distDirs = @(Get-ChildItem $Dist -Directory -ErrorAction SilentlyContinue)
if ($distDirs.Count -gt 0) {
  $names = ($distDirs | Select-Object -ExpandProperty Name) -join ', '
  Write-Error "Release dist contains unexpected directories: $names"
  exit 1
}

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

$actual = @(Get-ChildItem $Dist -File | Select-Object -ExpandProperty Name)
$unexpected = @($actual | Where-Object { $expected -notcontains $_ })
if ($unexpected.Count -gt 0) {
  $names = $unexpected -join ', '
  Write-Error "Release dist contains unexpected assets: $names"
  exit 1
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

function Get-ZipEntryNames {
  param(
    [Parameter(Mandatory=$true)]
    [string]$ZipPath
  )

  $zip = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
  try {
    return @($zip.Entries | Where-Object { $_.FullName -and -not $_.FullName.EndsWith('/') } | ForEach-Object { $_.FullName -replace '\\', '/' })
  } finally {
    $zip.Dispose()
  }
}

function Test-ZipHasEntries {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$Entries,
    [Parameter(Mandatory=$true)]
    [string[]]$Required,
    [Parameter(Mandatory=$true)]
    [string]$ZipLabel
  )

  $missing = @($Required | Where-Object { $Entries -notcontains $_ })
  if ($missing.Count -gt 0) {
    $names = $missing -join ', '
    Write-Error "$ZipLabel is missing required files: $names"
    exit 1
  }
}

function Test-ZipExactEntries {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$Entries,
    [Parameter(Mandatory=$true)]
    [string[]]$Allowed,
    [Parameter(Mandatory=$true)]
    [string]$ZipLabel
  )

  $extra = @($Entries | Where-Object { $Allowed -notcontains $_ })
  if ($extra.Count -gt 0) {
    $names = $extra -join ', '
    Write-Error "$ZipLabel contains files that should not ship: $names"
    exit 1
  }
}

function Get-ZipEntryText {
  param(
    [Parameter(Mandatory=$true)]
    [string]$ZipPath,
    [Parameter(Mandatory=$true)]
    [string]$EntryName
  )

  $zip = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
  try {
    $entry = $zip.Entries | Where-Object { ($_.FullName -replace '\\', '/') -eq $EntryName } | Select-Object -First 1
    if (-not $entry) {
      return $null
    }

    $reader = New-Object System.IO.StreamReader($entry.Open(), [System.Text.Encoding]::UTF8)
    try {
      return $reader.ReadToEnd()
    } finally {
      $reader.Dispose()
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
$generatedNames = @('main.pdf')
$forbiddenDirs = @('.git/', 'dist/', '_stage/')
$fullSourceFiles = @(
  'README.md',
  'CHANGELOG.md',
  'LICENSE',
  'Compile.ps1',
  'Makefile',
  'latexmkrc',
  'main.tex',
  'NJFUReport.sty',
  'reference.bib',
  '.github/workflows/build.yml',
  'docs/format-checklist.md',
  'docs/format-scope.md',
  'docs/migration-v2.md',
  'docs/release.md',
  'docs/release-notes-template.md',
  'docs/release-notes-v2.0.0.md',
  'docs/release-notes-v2.1.0.md',
  'docs/roadmap.md',
  'docs/student-quickstart.md',
  'docs/template-map.md',
  'docs/writing-recipes.md',
  'frontmatter/abstract.tex',
  'frontmatter/cover.tex',
  'sections/1-introduction.tex',
  'settings/commands.tex',
  'scripts/check-beginner-guidance.ps1',
  'scripts/check-release-assets.ps1',
  'scripts/check-style-sync.ps1',
  'scripts/check-template-structure.ps1',
  'scripts/package-release.ps1',
  'templates/njfu-course-paper/main.tex',
  'templates/njfu-course-paper/paper-info.tex',
  'templates/njfu-course-paper/NJFUReport.sty',
  'templates/njfu-course-paper/reference.bib',
  'templates/njfu-course-paper/README.md',
  'templates/personal-quickstart/main.tex',
  'templates/personal-quickstart/NJFUReport.sty',
  'templates/personal-quickstart/reference.bib',
  'templates/personal-quickstart/README.md'
)
$overleafFiles = @(
  'main.tex',
  'paper-info.tex',
  'NJFUReport.sty',
  'reference.bib',
  'README.md',
  'frontmatter/abstract.tex',
  'frontmatter/cover.tex',
  'sections/paper.tex',
  'settings/commands.tex'
)

Test-ZipEntries -ZipPath $fullZip -Predicate {
  $entry = $_
  $assetNames | Where-Object { $entry.FullName -eq $_ -or $entry.FullName.EndsWith("/$_") }
} -ErrorMessage 'Full source zip contains release assets:'

foreach ($zipPath in @($fullZip, $overleafZip)) {
  Test-ZipEntries -ZipPath $zipPath -Predicate {
    $entry = $_
    $generatedExtensions | Where-Object { $entry.FullName.EndsWith($_) }
  } -ErrorMessage "Zip contains generated LaTeX files:"

  Test-ZipEntries -ZipPath $zipPath -Predicate {
    $entry = $_
    $generatedNames | Where-Object { ($entry.FullName -replace '\\', '/') -eq $_ -or ($entry.FullName -replace '\\', '/').EndsWith("/$_") }
  } -ErrorMessage "Zip contains generated PDF files:"
}

Test-ZipEntries -ZipPath $fullZip -Predicate {
  $entry = $_
  $name = $entry.FullName -replace '\\', '/'
  $forbiddenDirs | Where-Object { $name -eq $_ -or $name.StartsWith($_) }
} -ErrorMessage 'Full source zip contains internal directories:'

$fullSourceEntries = Get-ZipEntryNames $fullZip
Test-ZipHasEntries -Entries $fullSourceEntries -Required $fullSourceFiles -ZipLabel 'Full source zip'

$overleafEntries = Get-ZipEntryNames $overleafZip
Test-ZipHasEntries -Entries $overleafEntries -Required $overleafFiles -ZipLabel 'Overleaf zip'

$overleafFigureEntries = @($overleafEntries | Where-Object { $_ -like 'figures/*.jpg' })
if ($overleafFigureEntries.Count -ne 1) {
  Write-Error "Overleaf zip must contain exactly one jpg logo under figures/: $($overleafFigureEntries -join ', ')"
  exit 1
}

$overleafAllowedEntries = @($overleafFiles + $overleafFigureEntries)
Test-ZipExactEntries -Entries $overleafEntries -Allowed $overleafAllowedEntries -ZipLabel 'Overleaf zip'

$overleafReadme = Get-ZipEntryText -ZipPath $overleafZip -EntryName 'README.md'
foreach ($requiredText in @('XeLaTeX', 'paper-info.tex', 'sections/paper.tex', 'reference.bib')) {
  if (-not $overleafReadme -or -not $overleafReadme.Contains($requiredText)) {
    Write-Error "Overleaf README is missing beginner guidance text: $requiredText"
    exit 1
  }
}

Write-Host 'Release manifest:'
Get-ChildItem $Dist -File |
  Sort-Object Name |
  ForEach-Object { Write-Host ("- {0} ({1} bytes)" -f $_.Name, $_.Length) }

Write-Host 'Overleaf zip files:'
$overleafEntries |
  Sort-Object |
  ForEach-Object { Write-Host "- $_" }

Write-Host "Release assets are present and clean for $Version."
