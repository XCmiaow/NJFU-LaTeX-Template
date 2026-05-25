# v2.0.0 Zero-Beginner Interface Plan

## Goal

Ship v2.0.0 as a deliberate beginner-facing breaking release for the course paper template.

The release should make the Overleaf package safer for LaTeX beginners by separating user-editable metadata from the LaTeX entrypoint.

## Scope

1. Move course paper metadata out of `main.tex` into `paper-info.tex`.
   - Verify: `templates/njfu-course-paper/main.tex` contains only document setup, inputs, and document order.
   - Verify: `templates/njfu-course-paper/paper-info.tex` contains title, course, college, major, student id, author, teacher, blind review, and header settings.

2. Rename the beginner body file from `sections/1-example.tex` to `sections/paper.tex`.
   - Verify: `templates/njfu-course-paper/main.tex` inputs `sections/paper`.
   - Verify: no docs or scripts still point beginners to `sections/1-example.tex`.

3. Update release validation for the new v2 package manifest.
   - Verify: `scripts/check-template-structure.ps1` requires `paper-info.tex` and `sections/paper.tex`.
   - Verify: `scripts/check-release-assets.ps1` expects the same Overleaf zip layout.

4. Add migration guidance for v1.x users.
   - Verify: `docs/migration-v2.md` explains what moved and how to copy old content.
   - Verify: root README links the migration guide.

5. Keep the change focused.
   - Verify: no formatting behavior in `NJFUReport.sty` changes in this step.
   - Verify: both template builds still pass.

## Out of Scope

- Do not change NJFU formatting defaults in this step.
- Do not introduce Docker, PDF visual diffing, or a new build system in this step.
- Do not remove the personal quickstart template unless a later v2 decision replaces it.

## Release Notes Draft

Breaking changes:

- Course paper metadata now lives in `paper-info.tex`.
- The beginner body file is now `sections/paper.tex`.

Upgrade path:

- Copy v1.x metadata from `main.tex` into `paper-info.tex`.
- Copy v1.x body text from `sections/1-example.tex` into `sections/paper.tex`.
