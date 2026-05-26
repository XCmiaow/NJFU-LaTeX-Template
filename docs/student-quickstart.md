# 第一次使用完整流程

这份说明给第一次用 LaTeX 的同学。推荐使用 Overleaf，因为不需要本地安装 TeX Live。

如果你完全没有用过 Overleaf，先看 [Overleaf 手把手使用教程](overleaf-step-by-step.md)。如果你想看一篇论文从头改到能提交，先看 [第一篇课程论文完整演示](first-paper-walkthrough.md)。

## 先确认下载的是正确文件

1. 打开项目的 [最新 Release](https://github.com/XCmiaow/NJFU-LaTeX-Template/releases/latest) 页面。
2. 找到 **Assets**。
3. 下载 `njfu-course-paper-vX.Y.Z-overleaf.zip`。
4. 不要下载 `Source code.zip`，普通写论文不需要它。

## 上传到 Overleaf

1. 打开 [Overleaf](https://www.overleaf.com/) 并登录。
2. 点击 **New Project**。
3. 点击 **Upload Project**。
4. 选择刚下载的 `overleaf.zip`。
5. 等待项目打开。

## 设置编译器

1. 点击 Overleaf 左上角 **Menu**。
2. 找到 **Compiler**。
3. 选择 **XeLaTeX**。
4. 点击 **Recompile**。

如果右侧能看到 PDF，说明模板已经能正常编译。

## 只改这 4 个文件

| 文件 | 你要做什么 |
| --- | --- |
| `paper-info.tex` | 填题目、课程、学院、专业、学号、姓名、老师 |
| `frontmatter/abstract.tex` | 写摘要和关键词 |
| `sections/paper.tex` | 写正文 |
| `reference.bib` | 放参考文献 |

刚开始不要修改 `main.tex`、`frontmatter/cover.tex` 和 `NJFUReport.sty`。

## 第 1 步：改基本信息

打开 `paper-info.tex`，只改花括号里的文字。

```latex
\newcommand{\papertitle}{课程论文题目}
\newcommand{\coursename}{课程名称}
\newcommand{\collegename}{学院名称}
\newcommand{\majorname}{专业名称}
\newcommand{\studentid}{学号}
\newcommand{\authorname}{姓名}
\newcommand{\teachername}{授课教师姓名}
```

改成类似：

```latex
\newcommand{\papertitle}{城市湿地生态修复路径分析}
\newcommand{\coursename}{湿地保护}
\newcommand{\collegename}{林学院}
\newcommand{\majorname}{生态学}
\newcommand{\studentid}{2026000001}
\newcommand{\authorname}{张三}
\newcommand{\teachername}{李四}
```

改完点击 **Recompile**，检查封面是否正确。

## 第 2 步：写摘要

打开 `frontmatter/abstract.tex`，把摘要和关键词换成自己的。

```latex
\begin{abstract}
这里写 150 到 300 字摘要，说明论文写了什么、用了什么方法、得出什么结论。

\noindent\textbf{关键词：}关键词1；关键词2；关键词3
\end{abstract}
```

关键词之间建议使用中文分号。

## 第 3 步：写正文

打开 `sections/paper.tex`。你可以保留标题结构，把示例文字换成自己的。

最小结构如下：

```latex
\section{引言}

这里写研究背景和论文目的。

\section{分析}

这里写资料整理、案例分析、计算结果或课程知识应用。

\section{结论}

这里总结全文。
```

如果你不需要示例表格、公式、图片或代码块，可以直接删除对应代码。

## 第 4 步：加参考文献

正文里引用：

```latex
已有研究指出这一问题值得关注\cite{sample2024}。
```

然后打开 `reference.bib`，确保有同名 key：

```bibtex
@article{sample2024,
  title = {示例论文标题},
  author = {张三 and 李四},
  journal = {示例期刊},
  year = {2024}
}
```

如果参考文献不显示，点击 **Recompile** 两次。

## 第 5 步：插入图片

1. 把图片上传到 `figures/` 文件夹。
2. 图片文件名建议使用英文，例如 `wetland-map.png`。
3. 在 `sections/paper.tex` 中加入：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.75\textwidth]{figures/wetland-map}
    \caption{图片标题}
    \label{fig:wetland-map}
\end{figure}
```

正文引用图片：

```latex
如图~\ref{fig:wetland-map} 所示。
```

## 第 6 步：提交前检查

提交前确认：

- Overleaf Compiler 是 **XeLaTeX**。
- 封面信息已经替换成自己的。
- 摘要不是“摘要内容”。
- 正文没有“这里写”“示例”“你的论文主题”等占位文字。
- 图片能显示。
- PDF 末尾有参考文献。
- 老师给的特殊要求已经优先满足。

更多内容见 [模板文件地图](template-map.md)、[写作配方](writing-recipes.md)、[提交前格式检查](format-checklist.md) 和 [故障排查](troubleshooting.md)。
