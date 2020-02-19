
 DOCUMENT = README

all:  html pdf
pdf:  $(DOCUMENT).pdf
html: $(DOCUMENT).html


$(DOCUMENT).pdf: $(DOCUMENT).tex
	export TEXINPUTS=./images:${TEXINPUTS}; \
	latex $(DOCUMENT); \
	latex $(DOCUMENT); \
	latex $(DOCUMENT); \
	dvipdfm $(DOCUMENT)

$(DOCUMENT).tex: $(DOCUMENT).rst CheckToolkit.rst socstyle.tex
	rst2latex --stylesheet=socstyle.tex \
	          --graphicx-option=pdftex  \
	          $(DOCUMENT).rst > $(DOCUMENT).tex

$(DOCUMENT).html: $(DOCUMENT).rst SoC.css
	rst2html --stylesheet=./SoC.css $(DOCUMENT).rst > $(DOCUMENT).html

clean:
	rm -f $(DOCUMENT).html \
	      $(DOCUMENT).tex  \
	      $(DOCUMENT).pdf  \
	      *.log            \
	      *.out            \
	      *.aux            \
	      *.toc            \
	      *.dvi
