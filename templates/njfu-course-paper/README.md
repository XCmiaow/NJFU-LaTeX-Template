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

## 文件地图

| 你想做什么 | 打开哪里 |
| --- | --- |
| 改题目、课程、姓名、学号 | `paper-info.tex` |
| 写摘要和关键词 | `frontmatter/abstract.tex` |
| 写正文 | `sections/paper.tex` |
| 上传图片 | `figures/` |
| 添加参考文献 | `reference.bib` |
| 开启盲审 | `paper-info.tex` |

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

`reference.bib` 示例：

```bibtex
@article{sample2024,
  title = {示例论文标题},
  author = {张三 and 李四},
  journal = {示例期刊},
  year = {2024}
}
```

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

## 表格怎么放

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
```

## 公式怎么放

```latex
\begin{equation}
    S = \frac{x_1 + x_2 + x_3}{3}
    \label{eq:score}
\end{equation}
```

## 盲审怎么开

在 `paper-info.tex` 里把：

```latex
% % \blindreviewtrue
```

改成：

```latex
\blindreviewtrue
```

## 提交前检查

- `paper-info.tex` 里没有保留“课程论文题目”“姓名”“学号”等占位文字。
- `sections/paper.tex` 里没有保留“这里写”“示例”“你的论文主题”等占位文字。
- 图片文件都在 `figures/` 文件夹里。
- 正文中的 `\cite{...}` 能在 `reference.bib` 中找到同名 key。
- Overleaf Compiler 是 **XeLaTeX**。

## 编译失败先检查

- Compiler 是否选择 **XeLaTeX**。
- 是否误删了 `NJFUReport.sty`、`frontmatter/`、`sections/`、`settings/`。
- `\cite{...}` 里的 key 是否能在 `reference.bib` 找到。
- 图片是否真的在 `figures/` 文件夹里。

本项目不是学校官方模板。老师或学院有特殊格式要求时，以老师或学院要求为准。
