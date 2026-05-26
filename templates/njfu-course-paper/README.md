# NJFU 课程论文模板

这份模板给第一次使用 LaTeX 的同学。推荐直接在 Overleaf 使用。

## 先做这 5 步

1. 在 Overleaf 左上角点击 **Menu**。
2. 把 **Compiler** 改成 **XeLaTeX**。
3. 点击 **Recompile**，确认右侧能看到 PDF。
4. 打开 `paper-info.tex`，填写题目、课程、姓名等信息。
5. 打开 `sections/paper.tex`，把示例正文替换成自己的正文。

## 只需要改这 4 个文件

| 文件 | 用途 |
| --- | --- |
| `paper-info.tex` | 改题目、课程、学院、专业、学号、姓名、老师 |
| `frontmatter/abstract.tex` | 改摘要和关键词 |
| `sections/paper.tex` | 写正文 |
| `reference.bib` | 添加参考文献 |

不熟悉 LaTeX 时，不建议修改 `main.tex` 和 `NJFUReport.sty`。

## 第 1 步：填写封面信息

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

示例：

```latex
\newcommand{\papertitle}{城市湿地生态修复路径分析}
\newcommand{\coursename}{湿地保护}
\newcommand{\collegename}{林学院}
\newcommand{\majorname}{生态学}
\newcommand{\studentid}{2026000001}
\newcommand{\authorname}{张三}
\newcommand{\teachername}{李四}
```

改完点击 **Recompile**，检查封面信息是否正确。

## 第 2 步：写摘要

打开 `frontmatter/abstract.tex`，把摘要和关键词替换成自己的。

```latex
\begin{abstract}
这里写摘要。摘要一般说明论文主题、分析方法和主要结论。

\noindent\textbf{关键词：}关键词1；关键词2；关键词3
\end{abstract}
```

关键词之间建议使用中文分号。

## 第 3 步：写正文

打开 `sections/paper.tex`。保留 `\section{}` 这种标题，替换下面的正文。

```latex
\section{引言}

这里写研究背景和论文目的。

\section{分析}

这里写资料整理、案例分析或课程知识应用。

\section{结论}

这里总结全文。
```

不需要的示例图、表示例、公式和代码块可以直接删除。

## 第 4 步：引用参考文献

正文里这样引用：

```latex
已有研究指出这一问题值得关注\cite{sample2024}。
```

`reference.bib` 里要有同名 key：

```bibtex
@article{sample2024,
  title = {示例论文标题},
  author = {张三 and 李四},
  journal = {示例期刊},
  year = {2024}
}
```

如果参考文献没有出现，点击 **Recompile** 两次。

## 第 5 步：插入图片

1. 把图片上传到 `figures/` 文件夹。
2. 图片文件名建议使用英文、数字和短横线，例如 `wetland-map.png`。
3. 在 `sections/paper.tex` 中加入：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.75\textwidth]{figures/wetland-map}
    \caption{图片标题}
    \label{fig:wetland-map}
\end{figure}

如图~\ref{fig:wetland-map} 所示。
```

文件名可以不写扩展名。

## 第 6 步：插入表格

```latex
\begin{table}[htbp]
    \centering
    \caption{表格标题}
    \label{tab:result}
    \begin{tabularx}{0.8\textwidth}{CCC}
        \toprule
        指标 & 方法 A & 方法 B \\
        \midrule
        数值 & 1.23 & 4.56 \\
        \bottomrule
    \end{tabularx}
\end{table}

结果见表~\ref{tab:result}。
```

## 第 7 步：插入公式

```latex
\begin{equation}
    S = \frac{x_1 + x_2 + x_3}{3}
    \label{eq:score}
\end{equation}

式~\ref{eq:score} 中，$S$ 表示综合得分。
```

## 第 8 步：开启盲审

如果老师要求匿名或盲审，在 `paper-info.tex` 里把：

```latex
% % \blindreviewtrue
```

改成：

```latex
\blindreviewtrue
```

## 提交前检查

- `paper-info.tex` 里没有保留“课程论文题目”“姓名”“学号”等占位文字。
- `frontmatter/abstract.tex` 里没有保留“摘要内容”。
- `sections/paper.tex` 里没有保留“这里写”“示例”“你的论文主题”等占位文字。
- 图片文件都在 `figures/` 文件夹里。
- 正文中的 `\cite{...}` 能在 `reference.bib` 中找到同名 key。
- Overleaf Compiler 是 **XeLaTeX**。
- PDF 封面、目录、正文第一页和参考文献页都正常。

## 编译失败先检查

- Compiler 是否选择 **XeLaTeX**。
- 是否误删了 `NJFUReport.sty`、`frontmatter/`、`sections/`、`settings/`。
- `\cite{...}` 里的 key 是否能在 `reference.bib` 找到。
- 图片是否真的在 `figures/` 文件夹里。
- 图片文件名是否用了英文、数字或短横线。

本项目不是学校官方模板。老师或学院有特殊格式要求时，以老师或学院要求为准。
