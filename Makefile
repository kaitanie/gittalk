PACKAGE = INCL/ABLA status report

PDFGENERATOR = pdflatex
#DVIGENERATOR = latex
#PSGENERATOR = dvips

SOURCEFILE = gittalk
REMOTENAME = gittalk.pdf

all: pdf

upload: all
	scp inclabla-status.pdf kaitanie@melkki.cs.helsinki.fi:~/public_html/$(REMOTENAME)

pdf: $(SOURCEFILE).tex 
	$(PDFGENERATOR) $(SOURCEFILE)
	$(PDFGENERATOR) $(SOURCEFILE)

dvi: $(SOURCEFILE).tex filter
	$(DVIGENERATOR) $(SOURCEFILE)
	$(DVIGENERATOR) $(SOURCEFILE)
	$(DVIGENERATOR) $(FILTEREDFISRC)
	$(DVIGENERATOR) $(FILTEREDFISRC)

ps: dvi
	$(PSGENERATOR) $(SOURCEFILE).dvi -o $(SOURCEFILE).ps
	$(PSGENERATOR) $(FILTEREDFISRC).dvi -o $(FILTEREDFISRC).ps

filter: $(FISOURCEFILE).tex
	cat $(FISOURCEFILE).tex |sed "s/ä/\\\\\"a/g" | sed "s/Ä/\\\\\"A/g" | sed "s/ö/\\\\\"o/g" | sed "s/Ö/\\\\\"O/g" > $(FILTEREDFISRC).tex

.PHONY: clean
clean:
	rm -f *.aux
	rm -f *.out
	rm -f *.log

.PHONY: cleandocs
cleandocs: clean
	rm -f *.pdf
	rm -f *.dvi
	rm -f *.ps
	rm -f *.snm
	rm -f *.toc





