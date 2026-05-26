# 使用手册

本手册面向第一次使用 LaTeX 写南京林业大学课程论文的用户。目标是让你能下载模板、改基本信息、写正文、插图表、管理参考文献，并在编译失败时知道先查哪里。

## 适用边界

本模板用于课程论文和课程作业类文档。它不是学校官方模板，也不保证符合毕业论文、学位论文、开题报告或学院专项材料要求。

提交前请按任课教师或学院给出的格式要求检查标题、封面字段、页边距、字号、参考文献样式和提交文件格式。

## 推荐使用方式

新手优先使用 Overleaf：

1. 打开项目的 [Releases](https://github.com/XCmiaow/NJFU-LaTeX-Template/releases) 页面。
2. 下载最新版本中的 `njfu-course-paper-*-overleaf.zip`。
3. 在 Overleaf 选择 **New Project -> Upload Project** 上传 zip。
4. 在 **Menu -> Compiler** 中选择 **XeLaTeX**。
5. 修改 `paper-info.tex` 中的基本信息。

熟悉本地环境的用户可以使用 TeX Live 或 MiKTeX：

```bash
latexmk -xelatex main.tex
```

Windows PowerShell 可在仓库根目录运行：

```powershell
.\Compile.ps1 all
```

## 文件怎么改

常用文件如下：

| 文件 | 用途 |
| --- | --- |
| `paper-info.tex` | 设置论文题目、课程名、姓名、学号等基本信息 |
| `main.tex` | 组织全文结构，普通用户一般不用修改 |
| `frontmatter/abstract.tex` | 修改中文摘要和英文摘要 |
| `sections/*.tex` | 撰写正文 |
| `reference.bib` | 管理参考文献 |
| `settings/commands.tex` | 放自定义命令 |
| `NJFUReport.sty` | 样式文件，普通用户不建议直接改 |

建议先从 `templates/njfu-course-paper` 开始写。这个目录是面向实际使用的最小模板，比根目录示例更干净。

如果完全没用过 Overleaf，先看 [Overleaf 手把手使用教程](overleaf-step-by-step.md)。如果想看一篇课程论文从模板改到成稿，见 [第一篇课程论文完整演示](first-paper-walkthrough.md)。如果只想知道“某个任务该改哪个文件”，见 [模板文件地图](template-map.md)。如果需要复制插图、表格、公式、参考文献等常用写法，见 [写作配方](writing-recipes.md)。

## 封面和目录

封面样式参考南京林业大学课程论文常见版式：上方居中放校徽校名图，中部放论文题目，下方用横线表格填写课程名称、学院、专业、学号、姓名和授课教师，页脚放学校名和日期。

目录默认使用居中标题、点线引导和右对齐页码。一级标题会加粗显示，二级和三级标题按层级缩进。

普通用户通常只需要修改 `paper-info.tex` 中的基本信息和 `sections/paper.tex` 中的正文内容，不需要直接修改 `main.tex`、`frontmatter/cover.tex` 或 `NJFUReport.sty`。

## 正文结构

标准课程论文模板默认把正文放在 `sections/paper.tex`。如果你熟悉 LaTeX，也可以把正文按章节拆分到 `sections/` 目录，并在 `main.tex` 中引入：

```latex
\input{sections/1-introduction}
\input{sections/2-method}
\input{sections/3-result}
\input{sections/4-conclusion}
```

如果新增章节，只需要新建对应 `.tex` 文件，再在 `main.tex` 中添加一行 `\input{...}`。

## 插入图片

把图片放入 `figures/` 或 `img/`，再用 `figure` 环境插入：

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.75\textwidth]{figures/example.png}
  \caption{示例图片}
  \label{fig:example}
\end{figure}
```

正文引用图片：

```latex
如图~\ref{fig:example} 所示。
```

## 插入表格

模板预置了 `booktabs` 和 `tabularx`，推荐使用三线表：

```latex
\begin{table}[htbp]
  \centering
  \caption{示例表格}
  \label{tab:example}
  \begin{tabularx}{0.8\textwidth}{CCC}
    \toprule
    指标 & 数值 & 说明 \\
    \midrule
    A & 1.00 & 示例 \\
    B & 2.00 & 示例 \\
    \bottomrule
  \end{tabularx}
\end{table}
```

## 参考文献

在 `reference.bib` 中维护 BibTeX 条目：

```bibtex
@article{sample2024,
  title = {示例论文标题},
  author = {张三 and 李四},
  journal = {示例期刊},
  year = {2024}
}
```

正文引用：

```latex
已有研究指出这一问题值得关注~\cite{sample2024}。
```

如果参考文献没有显示，优先使用完整编译流程：

```bash
latexmk -xelatex main.tex
```

## 盲审模式

如需隐藏姓名、学号、授课教师，可在 `paper-info.tex` 中取消注释：

```latex
\blindreviewtrue
```

## 常见问题入口

- 编译器请选择 XeLaTeX。
- 中文字体问题优先安装 Noto CJK。
- 参考文献问题优先检查 `\cite{...}` 和 `reference.bib` key 是否一致。
- 具体报错可查 [故障排查](troubleshooting.md)。
- 项目边界和常见问答可查 [FAQ](faq.md)。
