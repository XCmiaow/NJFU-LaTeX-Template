# Overleaf 手把手使用教程

这份教程给完全没用过 LaTeX 和 Overleaf 的同学。照着做即可，不需要本地安装软件。

## 第 1 步：下载正确的模板包

1. 打开项目的 [最新 Release](https://github.com/XCmiaow/NJFU-LaTeX-Template/releases/latest) 页面。
2. 在页面下方找到 **Assets**。
3. 下载文件名类似 `njfu-course-paper-vX.Y.Z-overleaf.zip` 的文件。
4. 不要下载 `Source code.zip`，也不要下载完整源码包，普通写论文只需要 `overleaf.zip`。

## 第 2 步：上传到 Overleaf

1. 打开 [Overleaf](https://www.overleaf.com/)。
2. 登录账号。如果没有账号，先注册一个免费账号。
3. 点击左上角或页面中的 **New Project**。
4. 选择 **Upload Project**。
5. 选择刚下载的 `njfu-course-paper-vX.Y.Z-overleaf.zip`。
6. 等待 Overleaf 解压完成。

上传完成后，左侧会看到这些文件：

```text
main.tex
paper-info.tex
frontmatter/
sections/
figures/
reference.bib
NJFUReport.sty
README.md
```

## 第 3 步：设置编译器

1. 在 Overleaf 左上角点击 **Menu**。
2. 找到 **Compiler**。
3. 选择 **XeLaTeX**。
4. 关闭 Menu。
5. 点击右上角 **Recompile**。

如果 PDF 能显示封面、目录、摘要和正文，说明模板上传成功。

## 第 4 步：填写基本信息

1. 在左侧文件列表点击 `paper-info.tex`。
2. 找到这些内容：

```latex
\newcommand{\papertitle}{课程论文题目}
\newcommand{\coursename}{课程名称}
\newcommand{\collegename}{学院名称}
\newcommand{\majorname}{专业名称}
\newcommand{\studentid}{学号}
\newcommand{\authorname}{姓名}
\newcommand{\teachername}{授课教师姓名}
```

3. 只改花括号里的文字，例如：

```latex
\newcommand{\papertitle}{城市湿地生态修复路径分析}
\newcommand{\coursename}{湿地保护}
\newcommand{\collegename}{林学院}
\newcommand{\majorname}{生态学}
\newcommand{\studentid}{2026000001}
\newcommand{\authorname}{张三}
\newcommand{\teachername}{李四}
```

4. 点击 **Recompile**，检查封面是否变成自己的信息。

## 第 5 步：写摘要

1. 打开 `frontmatter/abstract.tex`。
2. 把 `摘要内容。` 替换成自己的摘要。
3. 把 `关键词1；关键词2；关键词3` 替换成自己的关键词。

示例：

```latex
\begin{abstract}
本文以城市湿地生态修复为研究对象，结合课程相关理论，分析湿地退化原因、修复措施及其生态效益。研究认为，水文恢复、植被重建和长期监测是提升湿地生态功能的重要路径。

\noindent\textbf{关键词：}城市湿地；生态修复；植被重建
\end{abstract}
```

## 第 6 步：写正文

1. 打开 `sections/paper.tex`。
2. 保留 `\section{...}` 和 `\subsection{...}` 这种标题结构。
3. 把示例文字替换成自己的内容。
4. 不需要的公式、表格、图片、代码块可以直接删除。

最小正文可以这样写：

```latex
\section{引言}

这里写研究背景、课程要求和论文主题。

\section{分析}

这里写资料整理、案例分析或计算结果。

\section{结论}

这里总结全文。
```

## 第 7 步：添加图片

1. 在左侧文件列表中打开 `figures/` 文件夹。
2. 点击上传按钮，把图片上传进去。
3. 图片文件名建议改成英文，例如 `wetland-map.png`。
4. 在 `sections/paper.tex` 中插入：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.75\textwidth]{figures/wetland-map}
    \caption{湿地分布示意图}
    \label{fig:wetland-map}
\end{figure}

如图~\ref{fig:wetland-map} 所示，研究区湿地主要分布在河流两侧。
```

文件名可以不写扩展名。图片标题写在 `\caption{}` 里。

## 第 8 步：添加参考文献

1. 打开 `reference.bib`。
2. 添加 BibTeX 条目：

```bibtex
@article{zhang2024wetland,
  title = {城市湿地生态修复研究进展},
  author = {张三 and 李四},
  journal = {生态学报},
  year = {2024}
}
```

3. 在正文中引用这个 key：

```latex
已有研究指出，城市湿地修复需要兼顾水文过程和植被恢复\cite{zhang2024wetland}。
```

4. 点击 **Recompile**。如果参考文献没有立刻出现，再点击一次 **Recompile**。

## 第 9 步：下载 PDF

1. 确认右侧 PDF 没有报错。
2. 点击 PDF 预览窗口上方的下载按钮。
3. 下载得到的 PDF 就是可以提交的文件。

## 第 10 步：提交前检查

提交前搜索这些占位文字，确保都删掉或替换掉：

- `课程论文题目`
- `课程名称`
- `学院名称`
- `专业名称`
- `学号`
- `姓名`
- `授课教师姓名`
- `这里写`
- `示例`
- `你的论文主题`

再检查这几件事：

- Overleaf Compiler 是 **XeLaTeX**。
- 封面信息是自己的。
- 摘要和关键词已经填写。
- 正文没有残留示例内容。
- 图片能显示。
- PDF 末尾有参考文献。

## 遇到问题先看这里

- 不知道改哪个文件：看 [模板文件地图](template-map.md)。
- 不知道怎么插图表公式：看 [写作配方](writing-recipes.md)。
- 编译失败：看 [故障排查](troubleshooting.md)。
