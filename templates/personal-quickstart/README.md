# 个人极速开写模板

个人信息已预填，改标题 → 写正文 → 编译出 PDF。

## 使用步骤

1. **改标题**：编辑 `main.tex` 中的 `\papertitle`
2. **写正文**：在 `sections/` 目录下各 `.tex` 文件中撰写
3. **加文献**：在 `reference.bib` 中添加 BibTeX 条目
4. **编译**：

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

## 预填信息

| 字段 | 内容 |
|------|------|
| 姓名 | 方绪杰 |
| 学号 | 2410407105 |
| 学院 | 化学工程学院 |
| 专业 | 林产化工 |
| 授课教师 | 程虎 |

如需修改，编辑 `main.tex` 顶部「基本信息」区块。
