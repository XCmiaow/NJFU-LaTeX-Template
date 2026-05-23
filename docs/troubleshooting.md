# Troubleshooting

## `algorithm2e.sty not found`

安装更完整的 TeX Live 组件。Ubuntu CI 使用 `texlive-science`。

## `pythonhighlight.sty not found`

安装 `texlive-latex-extra`，或删除正文中不需要的 Python 高亮示例。

## Overleaf 编译失败

确认 Menu 中的 Compiler 选择 XeLaTeX，并使用较新的 TeX Live 版本。

## 本地 PowerShell 看到中文乱码

文件本身使用 UTF-8。可在 PowerShell 中运行 `chcp 65001` 后再查看，或使用 VS Code 打开。
