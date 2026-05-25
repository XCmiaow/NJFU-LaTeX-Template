param()

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')

$templates = @{
  'templates/njfu-course-paper' = @(
    'main.tex',
    'NJFUReport.sty',
    'reference.bib',
    'README.md',
    'frontmatter/abstract.tex',
    'frontmatter/cover.tex',
    'sections/1-example.tex',
    'settings/commands.tex'
  )
  'templates/personal-quickstart' = @(
    'main.tex',
    'NJFUReport.sty',
    'reference.bib',
    'README.md',
    'frontmatter/abstract.tex',
    'frontmatter/cover.tex',
    'sections/1-introduction.tex',
    'sections/2-xxx.tex',
    'sections/3-xxx.tex',
    'sections/4-xxx.tex',
    'sections/5-conclusion.tex',
    'settings/commands.tex'
  )
}

$requiredDirs = @('frontmatter', 'sections', 'settings', 'figures')
$forbiddenDirs = @('.git', '.github', '.vscode', 'dist', '_stage', 'node_modules')
$generatedExtensions = @('.aux', '.bbl', '.blg', '.fdb_latexmk', '.fls', '.log', '.out', '.synctex.gz', '.toc', '.xdv')
$generatedNames = @('main.pdf')
$failed = $false

function Add-Failure {
  param([Parameter(Mandatory=$true)][string]$Message)
  Write-Error $Message -ErrorAction Continue
  $script:failed = $true
}

foreach ($template in $templates.Keys) {
  $templatePath = Join-Path $Root $template
  if (-not (Test-Path $templatePath -PathType Container)) {
    Add-Failure "Missing template directory: $template"
    continue
  }

  foreach ($dir in $requiredDirs) {
    $path = Join-Path $templatePath $dir
    if (-not (Test-Path $path -PathType Container)) {
      Add-Failure "Missing template directory: $template/$dir"
    }
  }

  foreach ($file in $templates[$template]) {
    $path = Join-Path $templatePath $file
    if (-not (Test-Path $path -PathType Leaf)) {
      Add-Failure "Missing template file: $template/$file"
    }
  }

  $figureFiles = @(Get-ChildItem (Join-Path $templatePath 'figures') -File -Filter '*.jpg' -ErrorAction SilentlyContinue)
  if ($figureFiles.Count -ne 1) {
    Add-Failure "Template must contain exactly one jpg logo in $template/figures"
  }

  $badDirs = @(Get-ChildItem $templatePath -Directory -Force -Recurse | Where-Object { $forbiddenDirs -contains $_.Name })
  foreach ($dir in $badDirs) {
    Add-Failure "Template contains internal directory: $($dir.FullName.Substring($Root.Path.Length + 1))"
  }

  $badFiles = @(Get-ChildItem $templatePath -File -Force -Recurse | Where-Object {
    $name = $_.Name
    ($generatedNames -contains $name) -or ($generatedExtensions | Where-Object { $name.EndsWith($_) })
  })
  foreach ($file in $badFiles) {
    Add-Failure "Template contains generated file: $($file.FullName.Substring($Root.Path.Length + 1))"
  }
}

$repoGenerated = @(Get-ChildItem $Root -File -Force -Recurse | Where-Object {
  $relative = $_.FullName.Substring($Root.Path.Length + 1)
  if ($relative.StartsWith('.git\') -or $relative.StartsWith('dist\')) {
    return $false
  }

  $name = $_.Name
  ($generatedNames -contains $name) -or ($generatedExtensions | Where-Object { $name.EndsWith($_) })
})

foreach ($file in $repoGenerated) {
  Add-Failure "Repository contains generated LaTeX output: $($file.FullName.Substring($Root.Path.Length + 1))"
}

if ($failed) {
  exit 1
}

Write-Host 'Template structure is complete and clean.'
