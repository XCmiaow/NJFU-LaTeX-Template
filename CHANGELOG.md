# Changelog

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
