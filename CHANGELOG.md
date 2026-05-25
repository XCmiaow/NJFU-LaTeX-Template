# Changelog

## Unreleased

## v1.2.0 - 2026-05-25

- Strengthen CI with template structure checks and updated GitHub Actions versions.
- Add release asset manifest validation so Overleaf zip files stay minimal and clean.
- Validate that full source release zip files contain the expected project files.
- Print a release manifest after asset validation for easier manual review.
- Add template structure validation to catch missing starter files and generated LaTeX outputs.
- Rewrite the release process as a maintainer runbook focused on beginner-safe Overleaf packages.
- Add a student quickstart and format scope guide for LaTeX beginners.
- Link beginner troubleshooting paths from the student quickstart.
- Make the course paper template `main.tex` start with a clearer "only edit here" information block.
- Rewrite the course paper example as a real starter paper structure instead of a feature showcase.
- Add a pre-submission format checklist and GitHub Release notes template.
- Rewrite the Overleaf package README as a beginner-first guide.

## v1.1.0 - 2026-05-24

- Refine the course paper cover and table of contents to match common NJFU course paper layout.
- Add CI validation for release packaging and asset cleanliness.
- Make release packaging paths more portable across PowerShell environments.

## v1.0.1 - 2026-05-24

- Rebuild clean release assets from the latest `main` branch.
- Fix release packaging to avoid embedding generated release assets in the full source zip.
- Add release asset content checks for generated LaTeX files and nested release artifacts.

## v1.0.0 - 2026-05-23

- Publish the first stable course paper release.
- Add project preview image and example PDF.
- Add issue and pull request templates.

## v0.1.1 - 2026-05-23

- Fix CJK font fallbacks for Linux CI environments without Windows KaiTi and FangSong fonts.
- Keep template style copies synchronized across the root example and starter templates.

## v0.1.0 - 2026-05-23

- Keep the project focused on NJFU course papers.
- Fix public repository links in the README.
- Remove personal information from the quickstart template.
- Make CI use TeX Live packages from apt instead of `tlmgr`.
- Add cross-platform font fallbacks for Windows, Noto CJK, and Fandol fonts.
