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
