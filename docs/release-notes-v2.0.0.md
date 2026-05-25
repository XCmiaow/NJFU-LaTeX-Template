# NJFU-LaTeX-Template v2.0.0 Release Notes Draft

这是南京林业大学课程论文 LaTeX 模板的 v2.0.0 版本。

## 普通同学下载哪个文件

如果你只是想写课程论文，请下载：

- `njfu-course-paper-v2.0.0-overleaf.zip`

上传到 Overleaf 后，在 **Menu -> Compiler** 中选择 **XeLaTeX**。

## 这个版本更新了什么

- 新增 `paper-info.tex`，题目、课程、学院、专业、学号、姓名、教师和盲审开关都在这里填写。
- `main.tex` 改为稳定编译入口，普通用户一般不需要修改。
- 正文入口从 `sections/1-example.tex` 改为 `sections/paper.tex`，文件名更贴近真实写作。
- 新增 v2 迁移指南，说明如何从 v1.x 项目复制旧内容。
- 新增 CI 检查，防止新手文档重新指向旧入口。

## 不兼容变更

- v1.x 中 `main.tex` 顶部的基本信息区已经移动到 `paper-info.tex`。
- v1.x 中的 `sections/1-example.tex` 已改为 `sections/paper.tex`。

从旧项目迁移时，请先下载新的 Overleaf zip，再按 [v2 迁移指南](migration-v2.md) 复制旧信息和正文。

## 发布资产

- `njfu-course-paper-v2.0.0-overleaf.zip`：Overleaf 模板包，普通用户优先下载。
- `njfu-course-paper-v2.0.0.pdf`：课程论文模板预览 PDF。
- `NJFU-LaTeX-Template-v2.0.0.zip`：完整源码包，适合本地使用或二次开发。
- `main-v2.0.0.pdf`：完整示例 PDF。

## 使用前请注意

- 本项目不是学校官方模板。
- 本项目适合课程论文、课程作业、课程设计说明文档等轻量场景。
- 毕业论文、学位论文、开题报告请以学院或学校官方要求为准。
