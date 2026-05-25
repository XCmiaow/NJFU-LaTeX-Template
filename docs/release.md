# Release Runbook

本文档给维护者使用，目标是每次发布都生成小白可以直接上传 Overleaf 的干净模板包。

## 发布资产

每个版本只发布 4 个文件：

- `NJFU-LaTeX-Template-vX.Y.Z.zip`：完整源码包。
- `njfu-course-paper-vX.Y.Z-overleaf.zip`：给普通同学使用的 Overleaf 模板包。
- `main-vX.Y.Z.pdf`：根目录完整示例 PDF。
- `njfu-course-paper-vX.Y.Z.pdf`：课程论文模板预览 PDF。

普通用户优先下载 `njfu-course-paper-vX.Y.Z-overleaf.zip`，上传到 Overleaf 后把编译器设为 XeLaTeX。

## 版本规则

- Patch：文档、CI、打包脚本、错别字、兼容性修复。
- Minor：模板结构、发布可靠性、用户入口或主要文档体验升级。
- Major：目录结构、模板接口或发布流程出现不兼容变更时再考虑。

## 发布前检查

在仓库根目录运行：

```powershell
.\scripts\check-style-sync.ps1
.\scripts\check-template-structure.ps1
.\scripts\check-beginner-guidance.ps1
.\Compile.ps1 all
.\Compile.ps1 clean
```

检查 PDF 时只看 4 个位置：

- 封面信息是否显示正常。
- 目录页标题和页码是否正常。
- 正文第一页中文、图表、公式是否正常。
- 参考文献页是否出现且编号正常。

## 打包和校验

```powershell
.\scripts\package-release.ps1 vX.Y.Z
.\scripts\check-release-assets.ps1 vX.Y.Z
```

校验脚本会拦截这些问题：

- `dist/` 中不是 4 个发布资产。
- 完整源码包缺少 README、LICENSE、核心脚本、示例、模板目录等关键文件。
- zip 里夹带 `main.pdf`、`.aux`、`.log` 等编译产物。
- Overleaf zip 缺少 `main.tex`、`paper-info.tex`、`NJFUReport.sty`、`reference.bib`、`frontmatter/`、`sections/`、`settings/`、`figures/`。
- Overleaf zip 夹带 `.git`、`dist`、多余 PDF 或其他不该给普通用户看的文件。

校验通过后，脚本会打印 release manifest 和 Overleaf zip 文件列表。发布前人工确认一次：普通用户下载的 `*-overleaf.zip` 里只应该看到论文源码、摘要/封面、正文、设置和图片。

## GitHub 发布

```powershell
git status --short
git push origin main
```

确认 GitHub Actions 在 `main` 上通过后再打 tag：

```powershell
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z
```

然后在 GitHub Releases 创建同名版本，上传 `dist/` 下 4 个文件。

Release 说明建议包含：

- 这个版本解决了什么。
- 普通用户应该下载哪个文件。
- Overleaf 编译器必须选择 XeLaTeX。
- Major 版本需要写清楚不兼容变更和迁移方式。

可以直接复制 [Release 说明模板](release-notes-template.md) 再替换版本号和更新点。

## CI 失败处理

- 样式同步失败：把根目录 `NJFUReport.sty` 同步到 `templates/*/NJFUReport.sty`。
- 模板结构失败：检查模板目录是否缺少必要文件，或误提交了 `main.pdf`、`.aux`、`.log` 等产物。
- 编译失败：优先看缺少宏包、中文字体、参考文献三类问题。
- 发布资产失败：重新运行 `.\scripts\package-release.ps1 vX.Y.Z`，不要手工改 zip。

如果 tag 已推送但资产有问题，删除 GitHub Release，修复后重新打同一个 tag 前要先确认远端 tag 是否需要删除。不要让错误 zip 留在公开 Release 里。
