# NJFU 课程论文 LaTeX 模板

南京林业大学课程论文 LaTeX 模板，基于 ctexart + XeLaTeX。

## 特性

- **模块化结构**：主控文件仅 ~30 行，正文按章节拆分
- **格式与内容分离**：样式（NJFUReport.sty）独立，自定义命令集中管理
- **封面自动生成**：修改 `main.tex` 中基本信息即可
- **中文适配**：Windows 默认宋体/黑体，其他系统自动尝试 Noto CJK / Fandol
- **参考文献**：BibTeX 管理

## 目录结构

```text
├── main.tex                 主控文件
├── NJFUReport.sty           模板样式（宏包、字体、页眉）
├── reference.bib            参考文献
├── settings/
│   └── commands.tex         自定义命令
├── frontmatter/
│   ├── cover.tex            封面
│   └── abstract.tex         摘要
├── sections/                正文章节
└── figures/                 图片
```

## 前置条件

- TeX Live 2024+ 或 MiKTeX
- 中文字体：Windows 可直接使用，macOS/Linux 推荐安装 Noto CJK

## 快速开始

### 1. 修改个人信息

编辑 `main.tex` 顶部「基本信息」区块。

### 2. 撰写正文

- 在 `sections/` 下创建 `.tex` 文件
- 在 `main.tex` 中用 `\input{sections/你的文件名}` 引入
- 在 `reference.bib` 中添加参考文献

### 3. 编译

```bash
latexmk -xelatex main.tex
```

如果从完整仓库根目录使用，也可以运行：

```bash
make template
```

Windows PowerShell：

```powershell
.\Compile.ps1 template
```

或手动四步：

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

## VSCode 配置

安装 [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) 扩展后，创建 `.vscode/settings.json`：

```json
{
    "latex-workshop.latex.recipe": [
        {
            "name": "xelatex -> bibtex -> xelatex * 2",
            "tools": ["xelatex", "bibtex", "xelatex", "xelatex"]
        }
    ]
}
```

## License

MIT
