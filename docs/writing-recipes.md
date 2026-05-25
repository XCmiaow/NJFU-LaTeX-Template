# 写作配方

这份文件收集课程论文里最常用的 LaTeX 写法。复制后替换标题、文字、文件名和引用 key 即可。

正文配方通常复制到 `sections/paper.tex`。摘要写在 `frontmatter/abstract.tex`，基本信息写在 `paper-info.tex`。

## 章节

```latex
\section{引言}

这里写正文。

\subsection{研究背景}

这里写二级标题下的正文。
```

## 引用参考文献

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

## 插入图片

先把图片上传到 `figures/`，文件名建议使用英文、数字和短横线。

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.75\textwidth]{figures/your-image}
    \caption{图片标题}
    \label{fig:your-image}
\end{figure}

如图~\ref{fig:your-image} 所示。
```

## 插入三线表

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

## 插入公式

```latex
\begin{equation}
    S = \frac{x_1 + x_2 + x_3}{3}
    \label{eq:score}
\end{equation}

式~\ref{eq:score} 中，$S$ 表示综合得分。
```

## 插入代码

```latex
\begin{lstlisting}[language=Python, caption=示例代码]
scores = [82.5, 91.0, 76.5]
average = sum(scores) / len(scores)
print(average)
\end{lstlisting}
```

不需要展示代码时，直接删除示例代码块。

## 开启盲审

在 `paper-info.tex` 里找到这一行：

```latex
% % \blindreviewtrue
```

改成：

```latex
\blindreviewtrue
```

## 提交前删除占位文字

提交前搜索并删除这些文字：

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
