SOURCE = thesis
# LATEX = platex-sjis
LATEX = platex
# BIBTEX = bibtex
BIBTEX = jbibtex
DVIPDFMX = dvipdfmx

all:
	$(LATEX) -halt-on-error $(SOURCE).tex | nkf --ic=e --oc=w
	$(BIBTEX) main | nkf --ic=e --oc=w
	$(LATEX) $(SOURCE).tex | nkf --ic=e --oc=w
	$(LATEX) $(SOURCE).tex | nkf --ic=e --oc=w
	$(DVIPDFMX) $(SOURCE).dvi | nkf --ic=e --oc=w

pdf:
	$(DVIPDFMX) $(SOURCE).dvi

open:
	open $(SOURCE).pdf

clean:
	rm -f *~ $(SOURCE).dvi $(SOURCE).idx *.aux *.log *.lot *.lof *.toc *.bbl *.blg 
