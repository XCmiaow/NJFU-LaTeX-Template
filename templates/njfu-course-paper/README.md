# NJFU 课程论文模板

这份模板给第一次使用 LaTeX 的同学。推荐直接在 Overleaf 使用。

## 先做这 3 步

1. 在 Overleaf 左上角 **Menu -> Compiler** 里选择 **XeLaTeX**。
2. 打开 `paper-info.tex`，填写题目、课程、姓名等信息。
3. 打开 `sections/paper.tex`，把示例内容替换成自己的正文。

## 你通常只需要改这些文件

| 文件 | 用途 |
| --- | --- |
| `paper-info.tex` | 改题目、课程、学院、专业、学号、姓名、老师 |
| `frontmatter/abstract.tex` | 改摘要和关键词 |
| `sections/paper.tex` | 写正文 |
| `reference.bib` | 添加参考文献 |

不熟悉 LaTeX 时，不建议修改 `main.tex` 和 `NJFUReport.sty`。

## 正文怎么写

章节标题：

```latex
\section{引言}
\subsection{研究背景}
这里写正文。
```

引用参考文献：

```latex
这里引用一篇文献\cite{sample2024}。
```

参考文献条目写在 `reference.bib` 里，正文中的 `sample2024` 要和 `reference.bib` 里的 key 一致。

## 图片怎么放

1. 把图片上传到 `figures/` 文件夹。
2. 在正文中使用下面的代码。
3. 把 `your-image` 改成你的图片文件名，不写扩展名也可以。

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.7\textwidth]{figures/your-image}
    \caption{图片标题}
    \label{fig:your-image}
\end{figure}
```

图片文件名尽量使用英文、数字、短横线，不要带空格。

## 编译失败先检查

- Compiler 是否选择 **XeLaTeX**。
- 是否误删了 `NJFUReport.sty`、`frontmatter/`、`sections/`、`settings/`。
- `\cite{...}` 里的 key 是否能在 `reference.bib` 找到。
- 图片是否真的在 `figures/` 文件夹里。

本项目不是学校官方模板。老师或学院有特殊格式要求时，以老师或学院要求为准。
