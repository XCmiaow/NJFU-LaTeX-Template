param(
  [ValidateSet('all','demo','template','quickstart','clean')]
  [string]$Target = 'all'
)

$ErrorActionPreference = 'Stop'

function Build-Doc($Path) {
  Push-Location $Path
  try {
    latexmk -xelatex -interaction=nonstopmode main.tex
  } finally {
    Pop-Location
  }
}

function Clean-Doc($Path) {
  Push-Location $Path
  try {
    latexmk -C
    Remove-Item -ErrorAction SilentlyContinue main.bbl
  } finally {
    Pop-Location
  }
}

switch ($Target) {
  'demo' { Build-Doc '.' }
  'template' { Build-Doc 'templates/njfu-course-paper' }
  'quickstart' { Build-Doc 'templates/personal-quickstart' }
  'clean' {
    Clean-Doc '.'
    Clean-Doc 'templates/njfu-course-paper'
    Clean-Doc 'templates/personal-quickstart'
  }
  'all' {
    Build-Doc '.'
    Build-Doc 'templates/njfu-course-paper'
    Build-Doc 'templates/personal-quickstart'
  }
}
