param()

$ErrorActionPreference = 'Stop'
$Root = Resolve-Path (Join-Path $PSScriptRoot '..')
$failed = $false

function Add-Failure {
  param([Parameter(Mandatory=$true)][string]$Message)
  Write-Error $Message -ErrorAction Continue
  $script:failed = $true
}

function Get-Text {
  param([Parameter(Mandatory=$true)][string]$RelativePath)
  $path = Join-Path $Root $RelativePath
  if (-not (Test-Path $path -PathType Leaf)) {
    Add-Failure "Missing expected guidance file: $RelativePath"
    return ''
  }

  return Get-Content -Path $path -Raw -Encoding UTF8
}

function Test-Contains {
  param(
    [Parameter(Mandatory=$true)][string]$RelativePath,
    [Parameter(Mandatory=$true)][string]$Needle
  )

  $text = Get-Text $RelativePath
  if (-not $text.Contains($Needle)) {
    Add-Failure "$RelativePath must mention $Needle"
  }
}

function Test-DoesNotContain {
  param(
    [Parameter(Mandatory=$true)][string]$RelativePath,
    [Parameter(Mandatory=$true)][string]$Needle
  )

  $text = Get-Text $RelativePath
  if ($text.Contains($Needle)) {
    Add-Failure "$RelativePath still contains old beginner guidance: $Needle"
  }
}

$main = Get-Text 'templates/njfu-course-paper/main.tex'
if (-not $main.Contains('\input{paper-info}')) {
  Add-Failure 'Course paper main.tex must load paper-info.tex.'
}
if (-not $main.Contains('\input{sections/paper}')) {
  Add-Failure 'Course paper main.tex must load sections/paper.tex.'
}
foreach ($metadataCommand in @('\newcommand{\papertitle}', '\newcommand{\coursename}', '\newcommand{\authorname}')) {
  if ($main.Contains($metadataCommand)) {
    Add-Failure "Course paper main.tex must not define beginner metadata directly: $metadataCommand"
  }
}

$paperInfo = Get-Text 'templates/njfu-course-paper/paper-info.tex'
foreach ($metadataCommand in @(
  '\newcommand{\papertitle}',
  '\newcommand{\coursename}',
  '\newcommand{\collegename}',
  '\newcommand{\majorname}',
  '\newcommand{\studentid}',
  '\newcommand{\authorname}',
  '\newcommand{\teachername}',
  '\renewcommand{\reportheader}'
)) {
  if (-not $paperInfo.Contains($metadataCommand)) {
    Add-Failure "paper-info.tex is missing required metadata command: $metadataCommand"
  }
}

$beginnerDocs = @(
  'README.md',
  'docs/student-quickstart.md',
  'docs/manual.md',
  'docs/faq.md',
  'docs/troubleshooting.md',
  'docs/overleaf-step-by-step.md',
  'docs/first-paper-walkthrough.md',
  'docs/template-map.md',
  'docs/writing-recipes.md',
  'templates/njfu-course-paper/README.md'
)

foreach ($doc in $beginnerDocs) {
  Test-Contains $doc 'paper-info.tex'
  Test-Contains $doc 'sections/paper.tex'
  Test-DoesNotContain $doc 'sections/1-example.tex'
}

foreach ($doc in @('README.md', 'docs/student-quickstart.md', 'docs/manual.md', 'docs/troubleshooting.md')) {
  Test-Contains $doc 'template-map.md'
  Test-Contains $doc 'writing-recipes.md'
}

foreach ($doc in @('README.md', 'docs/student-quickstart.md', 'docs/manual.md', 'docs/troubleshooting.md')) {
  Test-Contains $doc 'overleaf-step-by-step.md'
  Test-Contains $doc 'first-paper-walkthrough.md'
}

$overleafReadme = 'templates/njfu-course-paper/README.md'
foreach ($requiredText in @(
  'paper-info.tex',
  'frontmatter/abstract.tex',
  'sections/paper.tex',
  'reference.bib',
  'cite',
  'includegraphics',
  'table',
  'equation',
  'blindreviewtrue',
  'XeLaTeX'
)) {
  Test-Contains $overleafReadme $requiredText
}

foreach ($requiredText in @(
  'paper-info.tex',
  'frontmatter/abstract.tex',
  'sections/paper.tex',
  'reference.bib',
  'figures/'
)) {
  Test-Contains 'docs/template-map.md' $requiredText
  Test-Contains 'docs/writing-recipes.md' $requiredText
}

if ($failed) {
  exit 1
}

Write-Host 'Beginner guidance points users to paper-info.tex, sections/paper.tex, and writing recipes.'
