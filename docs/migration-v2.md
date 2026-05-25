# v2.0.0 迁移指南

v2.0.0 把普通用户要改的内容从 `main.tex` 移到了独立文件，目的是减少误删编译结构的概率。

## 文件变化

| v1.x | v2.0.0 |
| --- | --- |
| `main.tex` 顶部基本信息区 | `paper-info.tex` |
| `sections/1-example.tex` | `sections/paper.tex` |

## 从 v1.x 迁移

1. 下载 v2.0.0 的 `njfu-course-paper-*-overleaf.zip`。
2. 打开旧项目的 `main.tex`，复制题目、课程、学院、专业、学号、姓名、教师等信息。
3. 粘贴到新项目的 `paper-info.tex`。
4. 打开旧项目的 `sections/1-example.tex`，复制正文内容。
5. 粘贴到新项目的 `sections/paper.tex`。
6. 复制旧项目的 `frontmatter/abstract.tex`、`reference.bib` 和自己的图片。
7. 在 Overleaf 中选择 **XeLaTeX** 后重新编译。

## 不建议直接改名

不建议只把旧文件手动改名后继续使用，因为 v2.0.0 也同步更新了 `main.tex` 的入口结构和发布包校验清单。
