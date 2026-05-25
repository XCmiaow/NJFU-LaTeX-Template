# Beginner Usability Gaps Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the v2 course paper template easier for LaTeX beginners to continue writing after the first successful compile.

**Architecture:** Keep the template file structure stable and improve the guidance layer around it. Add repo-level docs for file mapping and reusable writing recipes, then mirror the most important recipes into the Overleaf package README.

**Tech Stack:** Markdown documentation, PowerShell validation scripts, XeLaTeX release packaging.

---

### Task 1: Add Beginner Reference Docs

**Files:**
- Create: `docs/template-map.md`
- Create: `docs/writing-recipes.md`
- Modify: `README.md`
- Modify: `docs/student-quickstart.md`
- Modify: `docs/manual.md`

- [ ] **Step 1: Add a file map**

Create `docs/template-map.md` with a table mapping common user goals to files, including metadata, abstract, body, references, images, blind review, and style customization.

- [ ] **Step 2: Add writing recipes**

Create `docs/writing-recipes.md` with copyable snippets for sections, citations, figures, tables, equations, code, appendices, and placeholders to delete before submission.

- [ ] **Step 3: Link docs from existing entry points**

Update root README, student quickstart, and manual so users can find the file map and recipes before troubleshooting.

### Task 2: Improve Overleaf Package README

**Files:**
- Modify: `templates/njfu-course-paper/README.md`

- [ ] **Step 1: Add a compact file map**

The package README should tell users exactly which file to open for each writing task.

- [ ] **Step 2: Add minimal recipes**

The package README should include small snippets for citation, figure, table, equation, and blind review.

- [ ] **Step 3: Add a pre-submit checklist**

The package README should list the most common leftover placeholders and compile settings to check before downloading the PDF.

### Task 3: Strengthen Validation

**Files:**
- Modify: `scripts/check-beginner-guidance.ps1`
- Modify: `scripts/check-release-assets.ps1`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Check new docs are present**

The beginner guidance check should require `docs/template-map.md` and `docs/writing-recipes.md`.

- [ ] **Step 2: Check package README includes recipes**

The beginner guidance check should require the Overleaf README to mention citation, figures, tables, equations, and blind review.

- [ ] **Step 3: Include docs in release validation**

The release asset check should require the new docs in the full source zip.

### Task 4: Verify

**Files:**
- No source edits.

- [ ] **Step 1: Run local checks**

Run:

```powershell
.\scripts\check-beginner-guidance.ps1
.\scripts\check-template-structure.ps1
.\scripts\check-style-sync.ps1
git diff --check
```

- [ ] **Step 2: Build release package**

Run:

```powershell
.\scripts\package-release.ps1 v2.1.0
.\scripts\check-release-assets.ps1 v2.1.0
```

- [ ] **Step 3: Commit and push**

Run:

```bash
git add .
git commit -m "docs: improve beginner writing usability"
git push origin main
```
