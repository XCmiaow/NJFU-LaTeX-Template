# 第一篇课程论文完整演示

这份演示假设你要写一篇题为“城市湿地生态修复路径分析”的课程论文。你可以照着这个例子把模板改成自己的论文。

## 目标文件

本教程只需要改 4 个文件：

| 文件 | 本教程会做什么 |
| --- | --- |
| `paper-info.tex` | 填封面信息 |
| `frontmatter/abstract.tex` | 写摘要和关键词 |
| `sections/paper.tex` | 写正文 |
| `reference.bib` | 加参考文献 |

## 第 1 步：填写封面信息

打开 `paper-info.tex`，把原来的占位文字改成下面这样：

```latex
\newcommand{\papertitle}{城市湿地生态修复路径分析}
\newcommand{\coursename}{湿地保护}
\newcommand{\collegename}{林学院}
\newcommand{\majorname}{生态学}
\newcommand{\studentid}{2026000001}
\newcommand{\authorname}{张三}
\newcommand{\teachername}{李四}
```

保留这一行：

```latex
\renewcommand{\reportheader}{\coursename}
```

改完后点击 **Recompile**，确认封面已经变成自己的信息。

## 第 2 步：填写摘要

打开 `frontmatter/abstract.tex`，改成：

```latex
\begin{abstract}
本文以城市湿地生态修复为研究对象，结合湿地保护课程中的生态系统恢复理论，分析城市湿地退化的主要原因，并从水文恢复、植被重建、污染控制和长期监测四个方面提出修复路径。研究认为，城市湿地修复不应只关注景观效果，还应重视生态过程恢复和后期维护机制。

\noindent\textbf{关键词：}城市湿地；生态修复；水文恢复；植被重建
\end{abstract}
```

摘要一般写 150 到 300 字即可。关键词之间用中文分号分隔。

## 第 3 步：替换正文

打开 `sections/paper.tex`。如果你不知道怎么删示例内容，可以先全选文件内容，再替换成下面这份最小论文骨架：

```latex
\section{引言}

城市湿地是城市生态系统的重要组成部分，具有调蓄洪水、净化水质、维持生物多样性和改善景观环境等功能。随着城市建设强度增加，一些湿地出现水文连通性下降、植被退化和污染累积等问题。因此，研究城市湿地生态修复路径具有一定现实意义。

本文围绕城市湿地生态修复展开，主要讨论湿地退化原因、修复措施及其实施过程中需要注意的问题。

\section{城市湿地退化的主要原因}

\subsection{水文过程受干扰}

城市道路、排水管网和硬质驳岸可能改变湿地原有的水文过程，导致湿地补水不足或水位波动异常。水文条件变化会进一步影响植物群落和水质净化功能。

\subsection{植被结构退化}

部分城市湿地存在乡土植物减少、外来植物扩张和群落结构单一等现象。植被退化会降低湿地对污染物的吸收能力，也会影响鸟类、昆虫等生物的栖息环境。

\section{生态修复路径}

\subsection{恢复水文连通}

湿地修复应优先分析水源、排水和水位变化情况，在条件允许时恢复河流、湖泊与湿地之间的水文联系。

\subsection{重建本土植被}

植被恢复应优先选择适合当地气候和水位条件的本土植物，并通过乔灌草和水生植物的组合提高群落稳定性。

\subsection{建立长期监测机制}

修复工程完成后，还需要持续监测水质、植物生长和生物多样性变化，避免工程完成后缺少维护。

\section{结论}

城市湿地生态修复是一项系统工程。本文认为，水文恢复、植被重建和长期监测是提升城市湿地生态功能的关键措施。实际修复过程中，应根据湿地退化原因选择合适方法，并兼顾生态效益和管理成本。
```

这份骨架能正常编译。后续你只需要把文字换成自己的课程内容。

## 第 4 步：加入一张图片

先把图片上传到 `figures/`，假设文件名是 `wetland-map.png`。

在正文合适位置加入：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.75\textwidth]{figures/wetland-map}
    \caption{城市湿地空间分布示意图}
    \label{fig:wetland-map}
\end{figure}

如图~\ref{fig:wetland-map} 所示，城市湿地通常与河流、湖泊或低洼地带关系密切。
```

如果图片不显示，先检查文件是否真的在 `figures/` 文件夹里。

## 第 5 步：加入一条参考文献

打开 `reference.bib`，加入：

```bibtex
@article{zhang2024wetland,
  title = {城市湿地生态修复研究进展},
  author = {张三 and 李四},
  journal = {生态学报},
  year = {2024}
}
```

然后在正文中加入引用：

```latex
已有研究指出，城市湿地修复应同时关注水文条件、植被结构和后期管理\cite{zhang2024wetland}。
```

正文里的 `zhang2024wetland` 必须和 `reference.bib` 里的 key 完全一致。

## 第 6 步：编译并检查

1. 点击 **Recompile**。
2. 如果参考文献没有出现，再点击一次 **Recompile**。
3. 检查 PDF 末尾是否有“参考文献”。
4. 检查正文里的图号、表号、公式号是否正常。

## 第 7 步：提交前清理

在 Overleaf 左侧依次打开这几个文件，搜索并删除占位内容：

- `paper-info.tex`
- `frontmatter/abstract.tex`
- `sections/paper.tex`
- `reference.bib`

重点确认没有这些字：

- `这里写`
- `示例`
- `你的论文主题`
- `课程论文题目`
- `sample2024`

如果你使用了自己的参考文献，可以删除模板自带的示例文献条目。

## 第 8 步：下载成品

PDF 确认无误后，点击 Overleaf PDF 预览窗口上方的下载按钮。下载后的 PDF 就是提交给老师的文件。
