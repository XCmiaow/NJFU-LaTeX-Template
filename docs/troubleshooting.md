# 故障排查

先确认 Overleaf 的 Compiler 已选择 **XeLaTeX**。如果仍然失败，再按报错关键词往下找。

如果不是报错，而是不知道怎么插图、表格、公式或参考文献，先看 [写作配方](writing-recipes.md)。如果不知道该改哪个文件，先看 [模板文件地图](template-map.md)。

## `algorithm2e.sty not found`

安装更完整的 TeX Live 组件。Ubuntu CI 使用 `texlive-science`。

## `pythonhighlight.sty not found`

安装 `texlive-latex-extra`，或删除正文中不需要的 Python 高亮示例。

## Overleaf 编译失败

确认 Menu 中的 Compiler 选择 XeLaTeX，并使用较新的 TeX Live 版本。

## 找不到要改的文件

v2.0.0 之后，题目、课程、姓名等信息在 `paper-info.tex`，正文在 `sections/paper.tex`。如果你的项目仍使用旧版正文文件名，说明你使用的是 v1.x 模板包，可继续使用旧结构，也可以按 [v2 迁移指南](migration-v2.md) 迁移。

## 参考文献不显示

确认正文中有 `\cite{sample2024}` 这样的引用命令，并且 `reference.bib` 里有同名条目。Overleaf 通常会自动多轮编译，本地编译推荐使用 `latexmk -xelatex main.tex`。

如果刚添加参考文献，先连续点击 Overleaf 的 Recompile 两次。仍不显示时，检查 `\cite{}` 里的 key 是否和 `reference.bib` 完全一致，包括大小写。

## 图片不显示

确认图片已经放进 `figures/` 目录，正文里的文件名和上传后的文件名一致。文件名尽量使用英文、数字和短横线。

如果图片文件名是中文或带空格，先改成类似 `wetland-map.png` 的英文名，再修改正文中的文件名。

## 本地 PowerShell 看到中文乱码

文件本身使用 UTF-8。可在 PowerShell 中运行 `chcp 65001` 后再查看，或使用 VS Code 打开。
