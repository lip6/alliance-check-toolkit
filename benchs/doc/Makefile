
 DOCUMENT = README

all:  html pdf
pdf:  $(DOCUMENT).pdf
html: $(DOCUMENT).html


$(DOCUMENT).pdf: $(DOCUMENT).tex
	pdflatex $(DOCUMENT)
	pdflatex $(DOCUMENT)

$(DOCUMENT).tex: $(DOCUMENT).rst socstyle.tex
	rst2latex --stylesheet=socstyle.tex $(DOCUMENT).rst > $(DOCUMENT).tex

$(DOCUMENT).html: $(DOCUMENT).rst SoC.css
	rst2html --stylesheet=./SoC.css $(DOCUMENT).rst > $(DOCUMENT).html
