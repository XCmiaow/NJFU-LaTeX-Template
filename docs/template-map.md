# 模板文件地图

这份文件告诉你“想改什么，就打开哪个文件”。

## 最常用文件

| 你想做什么 | 打开哪个文件 | 怎么改 |
| --- | --- | --- |
| 改论文题目、课程、学院、姓名、学号、老师 | `paper-info.tex` | 修改花括号里的文字 |
| 写摘要和关键词 | `frontmatter/abstract.tex` | 替换摘要内容和关键词 |
| 写正文 | `sections/paper.tex` | 替换示例正文 |
| 添加参考文献 | `reference.bib` | 添加 BibTeX 条目 |
| 插入图片 | `figures/` 和 `sections/paper.tex` | 先上传图片，再在正文中引用 |
| 开启盲审 | `paper-info.tex` | 取消 `\blindreviewtrue` 前面的注释 |
| 改页眉文字 | `paper-info.tex` | 修改 `\reportheader` |

## 一般不用改的文件

| 文件 | 说明 |
| --- | --- |
| `main.tex` | 编译入口，负责把封面、目录、摘要、正文和参考文献连起来 |
| `frontmatter/cover.tex` | 封面结构，普通课程论文一般不用改 |
| `NJFUReport.sty` | 样式文件，控制字体、页边距、标题、表格等 |
| `settings/commands.tex` | 自定义命令，只有熟悉 LaTeX 后才需要改 |

## 推荐写作顺序

1. 在 `paper-info.tex` 填好基本信息。
2. 在 `frontmatter/abstract.tex` 写摘要和关键词。
3. 在 `sections/paper.tex` 写正文。
4. 把图片放进 `figures/`。
5. 在 `reference.bib` 添加参考文献。
6. 编译，检查 PDF。
7. 按 [提交前格式检查](format-checklist.md) 删除占位文字。
