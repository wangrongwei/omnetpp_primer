BUILD = build
BOOKNAME = omnetpp_primer-zh
TITLE = ebook/title.txt

COVER_IMAGE = docs/cover.png

TOOL_TEX = multimarkdown
FLAG = -t latex meta.txt

TEMPLATE = ../template

PREFACES =  ../Markdownbook/preface*.md

CHAPTERS =	../Markdownbook/chapter_*.md

APPENDIXS =	../Markdownbook/appendix.md
#APPENDIXS_PDF = $(shell echo $(APPENDIXS) | sed 's/.md/_pdf.md/g')


all: book

book: $(BOOKNAME).pdf

clean:
	-rm *.tex *.aux *.fot *.toc *.log *.out
	-rm -r img
	-rm $(BOOKNAME).*

$(BOOKNAME).pdf:
	cp -rf ../template/* .
	cp -rf ../img .
	$(TOOL_TEX) ${FLAG} $(PREFACES) -o preface.tex
	$(TOOL_TEX) ${FLAG} ${CHAPTERS} -o chapters.tex
	$(TOOL_TEX) ${FLAG} ${APPENDIXS} -o appendix.tex

	${call pdfgen}

define pdfgen	
	#cp docs/*.png .
	mv template.tex omnetpp_primer-zh.tex

	# add cover to this ompz
	xelatex omnetpp_primer-zh.tex
	xelatex omnetpp_primer-zh.tex
	xelatex omnetpp_primer-zh.tex

	mv ./omnetpp_primer-zh.pdf ../pdf/
endef



.PHONY: all book clean



