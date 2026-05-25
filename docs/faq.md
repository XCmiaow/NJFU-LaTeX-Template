# FAQ

## 必须用 XeLaTeX 吗？

是。模板依赖 `ctexart`、`fontspec` 和中文字体配置，推荐使用 `latexmk -xelatex main.tex`。

## 第一次使用应该改哪个文件？

优先改 `paper-info.tex`、`frontmatter/abstract.tex`、`sections/paper.tex` 和 `reference.bib`。不熟悉 LaTeX 时，不建议改 `main.tex` 和 `NJFUReport.sty`。

## 为什么参考文献不显示？

请确认正文里有 `\cite{key}`，并运行完整编译流程：`xelatex -> bibtex -> xelatex -> xelatex`。推荐直接使用 `latexmk -xelatex main.tex`。

## 为什么中文字体报错？

Windows 通常自带 SimSun、SimHei、KaiTi、FangSong。macOS/Linux 推荐安装 Noto CJK 字体。模板也会尝试使用 TeX Live 自带的 Fandol 字体。

## 可以用于毕业论文吗？

不建议。当前项目只面向南京林业大学课程论文。
