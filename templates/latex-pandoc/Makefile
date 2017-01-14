SRC	:= $(wildcard src/*.rst)
TEX := $(SRC:.rst=.tex)

all: pdf

pdf: latex
	latexmk -pdfdvi -f || echo

latex: $(TEX)

%.tex: %.rst
	pandoc -r rst -w latex -o $@ $<

.PHONY: clean
clean:
	rm -rf build/ src/*.tex
