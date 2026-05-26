# Beginner Tutorial Depth Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the beginner documentation from quick reference notes into a complete click-by-click path from download to final PDF.

**Architecture:** Keep the v2 template interface unchanged. Add two long-form guides, rewrite the quickstart as a full first-use flow, mirror the critical instructions into the Overleaf package README, and extend validation so the guides remain part of future releases.

**Tech Stack:** Markdown documentation, PowerShell validation scripts, XeLaTeX release packaging.

---

### Task 1: Add Long-Form Guides

**Files:**
- Create: `docs/overleaf-step-by-step.md`
- Create: `docs/first-paper-walkthrough.md`

- [ ] **Step 1: Add Overleaf step-by-step guide**

Write a guide that covers opening the latest release, choosing the Overleaf zip, uploading it to Overleaf, setting XeLaTeX, compiling, editing files, checking output, and downloading PDF.

- [ ] **Step 2: Add first paper walkthrough**

Write a complete fake-paper walkthrough that shows how to fill `paper-info.tex`, write `frontmatter/abstract.tex`, replace `sections/paper.tex`, add a BibTeX reference, and clean placeholders.

### Task 2: Rewrite Beginner Entry Points

**Files:**
- Modify: `docs/student-quickstart.md`
- Modify: `templates/njfu-course-paper/README.md`
- Modify: `README.md`
- Modify: `docs/manual.md`

- [ ] **Step 1: Rewrite student quickstart**

Replace the short quickstart with a first-use checklist that explains each click and each file in order.

- [ ] **Step 2: Expand Overleaf package README**

Make the package README self-contained for users who only download the zip and never open the GitHub docs.

- [ ] **Step 3: Link the new guides**

Add the long-form guides to root README and manual.

### Task 3: Strengthen Validation And Release Notes

**Files:**
- Modify: `scripts/check-beginner-guidance.ps1`
- Modify: `scripts/check-release-assets.ps1`
- Modify: `CHANGELOG.md`
- Create: `docs/release-notes-v2.2.0.md`

- [ ] **Step 1: Validate new docs**

Require the two new docs and their links from entry-point docs.

- [ ] **Step 2: Include new docs in source release validation**

Add the two new docs and v2.2.0 release notes to the full source zip manifest.

- [ ] **Step 3: Write v2.2.0 release notes**

Explain that v2.2.0 is a documentation and beginner usability release with no breaking changes.

### Task 4: Verify And Release

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
.\scripts\package-release.ps1 v2.2.0
.\scripts\check-release-assets.ps1 v2.2.0
```

- [ ] **Step 3: Commit, push, wait for CI, tag, and release**

Use commit message:

```bash
docs: expand beginner tutorial depth
```
