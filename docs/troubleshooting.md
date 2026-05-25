# 故障排查

先确认 Overleaf 的 Compiler 已选择 **XeLaTeX**。如果仍然失败，再按报错关键词往下找。

## `algorithm2e.sty not found`

安装更完整的 TeX Live 组件。Ubuntu CI 使用 `texlive-science`。

## `pythonhighlight.sty not found`

安装 `texlive-latex-extra`，或删除正文中不需要的 Python 高亮示例。

## Overleaf 编译失败

确认 Menu 中的 Compiler 选择 XeLaTeX，并使用较新的 TeX Live 版本。

## 参考文献不显示

确认正文中有 `\cite{sample2024}` 这样的引用命令，并且 `reference.bib` 里有同名条目。Overleaf 通常会自动多轮编译，本地编译推荐使用 `latexmk -xelatex main.tex`。

## 图片不显示

确认图片已经放进 `figures/` 目录，正文里的文件名和上传后的文件名一致。文件名尽量使用英文、数字和短横线。

## 本地 PowerShell 看到中文乱码

文件本身使用 UTF-8。可在 PowerShell 中运行 `chcp 65001` 后再查看，或使用 VS Code 打开。
