.PHONY: all demo template quickstart clean clean-demo clean-template clean-quickstart

all: demo template quickstart

demo:
	latexmk -xelatex -interaction=nonstopmode main.tex

template:
	cd templates/njfu-course-paper && latexmk -xelatex -interaction=nonstopmode main.tex

quickstart:
	cd templates/personal-quickstart && latexmk -xelatex -interaction=nonstopmode main.tex

clean: clean-demo clean-template clean-quickstart

clean-demo:
	latexmk -C
	rm -f main.bbl

clean-template:
	cd templates/njfu-course-paper && latexmk -C && rm -f main.bbl

clean-quickstart:
	cd templates/personal-quickstart && latexmk -C && rm -f main.bbl
