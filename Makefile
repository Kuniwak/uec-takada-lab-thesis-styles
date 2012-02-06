SOURCE = thesis
# LATEX = platex-sjis
LATEX = platex
# BIBTEX = bibtex
BIBTEX = jbibtex
DVIPDFMX = dvipdfmx

all:
	$(LATEX) -halt-on-error $(SOURCE).tex
	$(BIBTEX) main
	$(LATEX) $(SOURCE).tex
	$(LATEX) $(SOURCE).tex
	$(DVIPDFMX) $(SOURCE).dvi

pdf:
	$(DVIPDFMX) $(SOURCE).dvi

open:
	open $(SOURCE).pdf

clean:
	rm -f *~ $(SOURCE).dvi $(SOURCE).idx *.aux *.log *.lot *.lof *.toc *.bbl *.blg 
