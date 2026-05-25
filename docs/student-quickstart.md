# 5 分钟开始写作

这份说明给第一次用 LaTeX 的同学。推荐用 Overleaf，不需要本地安装 LaTeX。

## 5 分钟开始

1. 打开项目的 [最新 Release](https://github.com/XCmiaow/NJFU-LaTeX-Template/releases/latest) 页面。
2. 下载文件名类似 `njfu-course-paper-*-overleaf.zip` 的模板包。
3. 打开 [Overleaf](https://www.overleaf.com/)，选择 **New Project -> Upload Project**。
4. 上传刚下载的 zip。
5. 在 Overleaf 左上角 **Menu -> Compiler** 里选择 **XeLaTeX**。
6. 先看项目里的 `README.md`，再打开 `paper-info.tex`。
7. 只修改 `paper-info.tex` 里的题目、课程、姓名等信息。
8. 打开 `sections/paper.tex`，把示例文字替换成自己的正文。

## 你通常只需要改这些文件

| 文件 | 用途 |
| --- | --- |
| `paper-info.tex` | 改题目、课程、学院、姓名、学号、老师 |
| `frontmatter/abstract.tex` | 改摘要和关键词 |
| `sections/paper.tex` | 写正文 |
| `reference.bib` | 放参考文献 |

不要修改 `main.tex` 和 `NJFUReport.sty`，除非老师明确要求改结构、页边距、字体或标题格式。

## 插入常用内容

正文分节：

```latex
\section{引言}
\subsection{研究背景}
这里写正文。
```

引用参考文献：

```latex
这里引用一篇文献\cite{sample2024}。
```

插入图片：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.7\textwidth]{figures/your-image}
    \caption{图片标题}
    \label{fig:your-image}
\end{figure}
```

插入三线表：

```latex
\begin{table}[htbp]
    \centering
    \caption{表格标题}
    \begin{tabular}{ccc}
        \toprule
        指标 & 方法 A & 方法 B \\
        \midrule
        数值 & 1.23 & 4.56 \\
        \bottomrule
    \end{tabular}
\end{table}
```

## 常见问题

- 编译器必须选 **XeLaTeX**。
- 参考文献不显示时，先确认正文里有 `\cite{}`，再点 Recompile。
- 图片不显示时，确认图片放在 `figures/` 目录，文件名不要带空格。
- 老师给了特殊格式要求时，以老师要求为准。

更多问题见 [FAQ](faq.md) 和 [故障排查](troubleshooting.md)。
