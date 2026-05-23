#!/usr/bin/env perl
# latexmkrc — 自动多轮编译配置
# 使用: latexmk -xelatex main.tex

$pdf_mode = 5;                  # xelatex
$xelatex = 'xelatex -interaction=nonstopmode %O %S';
$bibtex = 'bibtex %O %B';
$max_repeat = 5;
$clean_ext = 'aux bbl blg log out toc synctex.gz fls fdb_latexmk xdv';
