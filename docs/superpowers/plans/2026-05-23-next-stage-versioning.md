# NJFU Course Paper Template Next Stage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the current NJFU course paper template into a clean v0.1.0 release baseline with reliable builds, clear versioning, and a practical roadmap toward v1.0.0.

**Architecture:** Keep the project focused on one product: a南京林业大学课程论文模板. Use the root project as the full demo and keep `templates/njfu-course-paper` as the user-facing starter template. Treat `templates/personal-quickstart` as optional and private-safe, or remove it before v1.0.0 if it stops adding value.

**Tech Stack:** LaTeX, XeLaTeX, BibTeX, latexmk, GitHub Actions, GitHub Releases, Markdown documentation.

---

## Version Strategy

- `v0.1.0`: first usable public baseline. Must have green CI, no private data, no non-course-paper positioning, working PDFs, corrected README links, and a changelog entry.
- `v0.2.0`: template packaging cleanup. Must reduce duplicated style files or document the duplication policy, add Makefile/Compile scripts, and make template copying simple.
- `v0.3.0`: user documentation release. Must add FAQ, troubleshooting, Overleaf upload package notes, and screenshot/PDF preview links.
- `v0.4.0`: NJFU format audit. Must compare against current course paper requirements from the school/course and record compliance decisions.
- `v1.0.0`: stable course paper template. Must have stable public API/macros, no known CI failures, release assets, and at least one full semester-style sample paper.

## Branching And Commit Rules

- Work on short branches: `fix/ci-fonts`, `docs/release-process`, `feat/package-template`, `docs/faq`.
- Keep `main` releasable. Only merge after local `latexmk` checks pass for root and templates.
- Use Conventional Commits:
  - `fix: remove experiment report wording`
  - `fix: make quickstart compile without bibtex`
  - `ci: install texlive dependencies from apt`
  - `docs: add release process`
  - `chore: release v0.1.0`
- Tag releases as annotated tags:
  - `git tag -a v0.1.0 -m "Release v0.1.0"`
  - `git push origin main --tags`

## Release Assets

For every release, attach:

- `NJFU-LaTeX-Template-vX.Y.Z.zip`: full source snapshot.
- `njfu-course-paper-vX.Y.Z-overleaf.zip`: minimal uploadable starter template.
- `main.pdf`: compiled full demo.
- `njfu-course-paper.pdf`: compiled starter template preview.
- Release notes copied from `CHANGELOG.md`.

---

## File Map

- `.github/workflows/build.yml`: CI build matrix and artifact upload.
- `README.md`: public landing page and quick start.
- `CHANGELOG.md`: release history.
- `NJFUReport.sty`: root demo style file.
- `templates/njfu-course-paper/NJFUReport.sty`: starter template style file.
- `templates/njfu-course-paper/README.md`: starter template usage guide.
- `templates/personal-quickstart/*`: optional quickstart template; must never contain private data.
- `docs/release.md`: release process to create.
- `docs/faq.md`: troubleshooting guide to create.
- `Makefile`: local build convenience to create.
- `scripts/package-release.ps1`: release asset packaging script to create.

---

### Task 1: Commit The v0.1.0 Stabilization Fixes

**Files:**
- Modify: `.github/workflows/build.yml`
- Modify: `README.md`
- Modify: `NJFUReport.sty`
- Modify: `templates/njfu-course-paper/NJFUReport.sty`
- Modify: `templates/njfu-course-paper/README.md`
- Modify: `templates/personal-quickstart/NJFUReport.sty`
- Modify: `templates/personal-quickstart/README.md`
- Modify: `templates/personal-quickstart/main.tex`
- Modify: `templates/personal-quickstart/reference.bib`
- Create: `CHANGELOG.md`

- [ ] **Step 1: Verify text safety**

Run:

```powershell
$failures=@()
$files=Get-ChildItem -Recurse -File -Include *.md,*.tex,*.sty,*.yml,*.bib | Where-Object { $_.FullName -notmatch '\\.git\\' }
foreach($f in $files){
  $text=Get-Content -Raw -Encoding UTF8 $f.FullName
  $forbidden = '实验' + '报告'
  if($text -match $forbidden){ $failures += "non-course-paper wording in $($f.FullName)" }
}
$readme=Get-Content -Raw -Encoding UTF8 README.md
if($readme -match 'yourname'){ $failures += 'README still uses yourname placeholder' }
$quickMain=Get-Content -Raw -Encoding UTF8 templates\personal-quickstart\main.tex
foreach($private in @('2410407105','方绪杰','程虎')){
  if($quickMain -match [regex]::Escape($private)){ $failures += "personal-quickstart exposes $private" }
}
if($failures.Count){ $failures; exit 1 }
'All text safety checks passed'
```

Expected: `All text safety checks passed`.

- [ ] **Step 2: Verify LaTeX builds**

Run:

```powershell
latexmk -xelatex -interaction=nonstopmode main.tex
Push-Location templates\njfu-course-paper
latexmk -xelatex -interaction=nonstopmode main.tex
Pop-Location
Push-Location templates\personal-quickstart
latexmk -xelatex -interaction=nonstopmode main.tex
Pop-Location
```

Expected: all three commands exit with code `0`.

- [ ] **Step 3: Clean build artifacts**

Run:

```powershell
latexmk -C
Push-Location templates\njfu-course-paper; latexmk -C; Pop-Location
Push-Location templates\personal-quickstart; latexmk -C; Pop-Location
Remove-Item -ErrorAction SilentlyContinue main.bbl, templates\njfu-course-paper\main.bbl, templates\personal-quickstart\main.bbl
```

Expected: `git status --short` shows only source/documentation changes.

- [ ] **Step 4: Commit**

Run:

```powershell
git add .github/workflows/build.yml README.md CHANGELOG.md NJFUReport.sty templates/njfu-course-paper/NJFUReport.sty templates/njfu-course-paper/README.md templates/personal-quickstart/NJFUReport.sty templates/personal-quickstart/README.md templates/personal-quickstart/main.tex templates/personal-quickstart/reference.bib
git commit -m "fix: stabilize course paper template baseline"
```

Expected: one new commit on `main`.

---

### Task 2: Add Local Build Commands

**Files:**
- Create: `Makefile`
- Create: `Compile.ps1`
- Modify: `README.md`
- Modify: `templates/njfu-course-paper/README.md`

- [ ] **Step 1: Create Makefile**

Create `Makefile`:

```makefile
.PHONY: all demo template quickstart clean clean-demo clean-template clean-quickstart

all: demo template quickstart

demo:
	latexmk -xelatex -interaction=nonstopmode main.tex

template:
	cd templates/njfu-course-paper && latexmk -xelatex -interaction=nonstopmode main.tex

quickstart:
	cd templates/personal-quickstart && latexmk -xelatex -interaction=nonstopmode main.tex

clean: clean-demo clean-template clean-quickstart

clean-demo:
	latexmk -C
	rm -f main.bbl

clean-template:
	cd templates/njfu-course-paper && latexmk -C && rm -f main.bbl

clean-quickstart:
	cd templates/personal-quickstart && latexmk -C && rm -f main.bbl
```

- [ ] **Step 2: Create Windows helper**

Create `Compile.ps1`:

```powershell
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
```

- [ ] **Step 3: Document local commands**

Add to `README.md` under local build:

```markdown
也可以使用仓库提供的快捷命令：

```bash
make all
make clean
```

Windows PowerShell:

```powershell
.\Compile.ps1 all
.\Compile.ps1 clean
```
```

- [ ] **Step 4: Verify**

Run:

```powershell
.\Compile.ps1 all
.\Compile.ps1 clean
```

Expected: all builds exit `0`, then artifacts are removed.

- [ ] **Step 5: Commit**

Run:

```powershell
git add Makefile Compile.ps1 README.md templates/njfu-course-paper/README.md
git commit -m "chore: add local build helpers"
```

---

### Task 3: Add Release Packaging

**Files:**
- Create: `scripts/package-release.ps1`
- Create: `docs/release.md`
- Modify: `.gitignore`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Add release artifact ignore rules**

Append to `.gitignore`:

```gitignore
## Release artifacts
dist/
*.zip
```

- [ ] **Step 2: Create packaging script**

Create `scripts/package-release.ps1`:

```powershell
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
latexmk -xelatex -interaction=nonstopmode main.tex
Pop-Location

Push-Location $OverleafDir
latexmk -xelatex -interaction=nonstopmode main.tex
Pop-Location

Compress-Archive -Path "$FullDir\*" -DestinationPath (Join-Path $Dist "NJFU-LaTeX-Template-$Version.zip") -Force
Compress-Archive -Path "$OverleafDir\*" -DestinationPath (Join-Path $Dist "njfu-course-paper-$Version-overleaf.zip") -Force

Copy-Item (Join-Path $FullDir 'main.pdf') (Join-Path $Dist "main-$Version.pdf") -Force
Copy-Item (Join-Path $OverleafDir 'main.pdf') (Join-Path $Dist "njfu-course-paper-$Version.pdf") -Force

Get-ChildItem $Dist -File | Select-Object Name,Length
```

- [ ] **Step 3: Create release process doc**

Create `docs/release.md`:

```markdown
# Release Process

This project uses semantic version tags while the template is maturing.

## Checklist

1. Update `CHANGELOG.md`.
2. Run `.\Compile.ps1 all`.
3. Run `.\Compile.ps1 clean`.
4. Commit all release changes.
5. Create release assets with `.\scripts\package-release.ps1 vX.Y.Z`.
6. Tag with `git tag -a vX.Y.Z -m "Release vX.Y.Z"`.
7. Push `main` and tags.
8. Create a GitHub Release and upload files from `dist/`.

## Version Rules

- Patch: documentation fixes, CI fixes, typo fixes, package metadata fixes.
- Minor: new template capability, new starter template, major documentation section.
- Major: stable public interface after v1.0.0.
```

- [ ] **Step 4: Verify packaging**

Run:

```powershell
.\scripts\package-release.ps1 v0.1.0
Get-ChildItem dist
```

Expected: two zip files and two PDF files exist in `dist/`.

- [ ] **Step 5: Clean and commit**

Run:

```powershell
Remove-Item -Recurse -Force dist
git add .gitignore scripts/package-release.ps1 docs/release.md CHANGELOG.md
git commit -m "chore: add release packaging workflow"
```

---

### Task 4: Add User Documentation

**Files:**
- Create: `docs/faq.md`
- Create: `docs/troubleshooting.md`
- Modify: `README.md`
- Modify: `templates/njfu-course-paper/README.md`

- [ ] **Step 1: Create FAQ**

Create `docs/faq.md`:

```markdown
# FAQ

## 必须用 XeLaTeX 吗？

是。模板依赖 `ctexart`、`fontspec` 和中文字体配置，推荐使用 `latexmk -xelatex main.tex`。

## 为什么参考文献不显示？

请确认正文里有 `\cite{key}`，并运行完整编译流程：`xelatex -> bibtex -> xelatex -> xelatex`。推荐直接使用 `latexmk -xelatex main.tex`。

## 为什么中文字体报错？

Windows 通常自带 SimSun、SimHei、KaiTi、FangSong。macOS/Linux 推荐安装 Noto CJK 字体。模板也会尝试使用 TeX Live 自带的 Fandol 字体。

## 可以用于毕业论文吗？

不建议。当前项目只面向南京林业大学课程论文。
```

- [ ] **Step 2: Create troubleshooting guide**

Create `docs/troubleshooting.md`:

```markdown
# Troubleshooting

## `algorithm2e.sty not found`

安装更完整的 TeX Live 组件。Ubuntu CI 使用 `texlive-science`。

## `pythonhighlight.sty not found`

安装 `texlive-latex-extra`，或删除正文中不需要的 Python 高亮示例。

## Overleaf 编译失败

确认 Menu 中的 Compiler 选择 XeLaTeX，并使用较新的 TeX Live 版本。

## 本地 PowerShell 看到中文乱码

文件本身使用 UTF-8。可在 PowerShell 中运行 `chcp 65001` 后再查看，或使用 VS Code 打开。
```

- [ ] **Step 3: Link docs from README**

Add to `README.md`:

```markdown
## 文档

- [FAQ](docs/faq.md)
- [故障排查](docs/troubleshooting.md)
- [发布流程](docs/release.md)
```

- [ ] **Step 4: Verify links**

Run:

```powershell
Test-Path docs/faq.md
Test-Path docs/troubleshooting.md
Test-Path docs/release.md
Select-String -Path README.md -Pattern 'docs/faq.md|docs/troubleshooting.md|docs/release.md'
```

Expected: all paths exist and README contains all three links.

- [ ] **Step 5: Commit**

Run:

```powershell
git add README.md templates/njfu-course-paper/README.md docs/faq.md docs/troubleshooting.md
git commit -m "docs: add user troubleshooting guides"
```

---

### Task 5: Decide Template Duplication Policy

**Files:**
- Modify: `README.md`
- Modify: `NJFUReport.sty`
- Modify: `templates/njfu-course-paper/NJFUReport.sty`
- Modify: `templates/personal-quickstart/NJFUReport.sty`

- [ ] **Step 1: Choose policy**

Pick one:

```text
Policy A: Keep duplicated `NJFUReport.sty` files so every template folder is self-contained.
Policy B: Keep only root `NJFUReport.sty`, and make templates reference it during development.
```

Recommended for v0.x: Policy A, because Overleaf users can upload a template folder directly.

- [ ] **Step 2: Document policy**

Add to `README.md`:

```markdown
## 维护说明

`templates/*/NJFUReport.sty` 会保留为独立副本，目的是让每个模板目录都能单独上传到 Overleaf。修改根目录 `NJFUReport.sty` 后，需要同步更新模板目录里的副本。
```

- [ ] **Step 3: Add version marker to style files**

Update all three `NJFUReport.sty` files:

```latex
\ProvidesPackage{NJFUReport}[2026/05/23 v0.1.0 NJFU Course Paper Template]
```

- [ ] **Step 4: Verify style versions match**

Run:

```powershell
Select-String -Path NJFUReport.sty,templates\njfu-course-paper\NJFUReport.sty,templates\personal-quickstart\NJFUReport.sty -Pattern 'ProvidesPackage'
```

Expected: all three lines include `v0.1.0`.

- [ ] **Step 5: Commit**

Run:

```powershell
git add README.md NJFUReport.sty templates/njfu-course-paper/NJFUReport.sty templates/personal-quickstart/NJFUReport.sty
git commit -m "docs: document template style duplication policy"
```

---

### Task 6: Publish v0.1.0

**Files:**
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Move changelog from Unreleased to v0.1.0**

Change:

```markdown
## Unreleased
```

to:

```markdown
## v0.1.0 - 2026-05-23
```

- [ ] **Step 2: Final local verification**

Run:

```powershell
.\Compile.ps1 all
.\Compile.ps1 clean
.\scripts\package-release.ps1 v0.1.0
```

Expected: builds pass and `dist/` contains release assets.

- [ ] **Step 3: Commit release metadata**

Run:

```powershell
git add CHANGELOG.md
git commit -m "chore: release v0.1.0"
```

- [ ] **Step 4: Tag release**

Run:

```powershell
git tag -a v0.1.0 -m "Release v0.1.0"
git status --short
```

Expected: tag exists and only ignored `dist/` artifacts remain.

- [ ] **Step 5: Push**

Run:

```powershell
git push origin main
git push origin v0.1.0
```

Expected: remote `main` and tag exist.

- [ ] **Step 6: Create GitHub Release**

Create a GitHub Release for `v0.1.0` and upload:

```text
dist/NJFU-LaTeX-Template-v0.1.0.zip
dist/njfu-course-paper-v0.1.0-overleaf.zip
dist/main-v0.1.0.pdf
dist/njfu-course-paper-v0.1.0.pdf
```

Expected: GitHub release page contains all four assets.

---

### Task 7: Plan v0.2.0 After Release

**Files:**
- Create: `docs/roadmap.md`
- Modify: `README.md`

- [ ] **Step 1: Create roadmap**

Create `docs/roadmap.md`:

```markdown
# Roadmap

## v0.2.0

- Add a single source-of-truth sync check for `NJFUReport.sty`.
- Improve starter template comments.
- Add one-page minimal sample and one full sample.
- Add release asset packaging to CI.

## v0.3.0

- Add FAQ screenshots or preview images.
- Add Overleaf-specific quick start.
- Add common course paper structure examples.

## v0.4.0

- Audit against current NJFU course paper requirements.
- Record format decisions in `docs/format-audit.md`.

## v1.0.0

- Freeze public macro names.
- Keep CI green across demo and starter templates.
- Publish stable release assets.
```

- [ ] **Step 2: Link roadmap**

Add to `README.md`:

```markdown
- [路线图](docs/roadmap.md)
```

- [ ] **Step 3: Commit**

Run:

```powershell
git add README.md docs/roadmap.md
git commit -m "docs: add project roadmap"
```

---

## Self-Review

- Spec coverage: the plan covers course-paper-only scope, v0.1.0 stabilization, build verification, release packaging, documentation, duplication policy, tagging, and future roadmap.
- Placeholder scan: no `TBD`, no unspecified tests, no hidden "add appropriate" steps.
- Type and command consistency: commands use PowerShell paths matching the current Windows workspace and `latexmk -xelatex` build flow.
