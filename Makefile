BUILD = build
BOOKNAME = omnetpp_primer-zh
TITLE = ebook/title.txt
METADATA = ebook/metadata.xml
TOC = --toc --toc-depth=2 --epub-chapter-level=2 
COVER_IMAGE = docs/cover.png
LATEX_CLASS = book
TOOL_TEX = multimarkdown
FLAG = -t latex meta.txt
TEMPLATE=./pdf
PREFACES =  ./chapter_1.md \
			./chapter_1.md  \
			./chapter_1.md  \
			./chapter_1.md  
PREFACES_PDF = $(shell echo $(PREFACES) | sed 's/.md/_pdf.md/g')
CHAPTERS =	./chapter_1.md \
			./chapter_2.md  \
			./chapter_3.md \
			./chapter_4.md  \
			./chapter_5.md  \
			./chapter_6.md  \
			./chapter_7.md  \
			./chapter_8.md
CHAPTERS_PDF = $(shell echo $(CHAPTERS) | sed 's/.md/_pdf.md/g')
APPENDIXS =	./appendix.md
APPENDIXS_PDF = $(shell echo $(APPENDIXS) | sed 's/.md/_pdf.md/g')

PDF_IMG = xxx.pdf xxx.pdf

all: book

book: pdf

clean:
		-rm *.tex *.aux *.fot *.toc *.log *.out
		-rm $(PDF_IMG)
		-rm -r site
		-rm $(BOOKNAME).*
		-rm $(PREFACES_PDF) $(CHAPTERS_PDF) $(APPENDIXS_PDF) 


pdf: $(BOOKNAME).pdf



%.pdf: docs/%.svg
	rsvg-convert -f pdf -o $@ $<

$(PREFACES_PDF) $(CHAPTERS_PDF) $(APPENDIXS_PDF): ./%_pdf.md : ./%.md
	cp $< $@
#	编译时把<!--(pdf)和(pdf)-->去掉，把<!--(pdf-newline)--><br>替换成\newline{}，将svg替换成pdf
	sed -i 's/<!--(pdf)//g;s/(pdf)-->//g;s/.svg)/.pdf)/g;s/<!--(pdf-newline)--><br>/\\newline{}/g' $@

# multimarkdown -t latex meta.txt ../Markdownbook/cover.md -o preface.tex
# multimarkdown -t latex meta.txt ../Markdownbook/chapter_*.md -o chapters.tex
# multimarkdown -t latex meta.txt ../Markdownbook/appendix.md -o appendix.tex
$(BOOKNAME).pdf: $(TITLE)  $(PREFACES_PDF) $(CHAPTERS_PDF) $(APPENDIXS_PDF) $(PDF_IMG)
	$(TOOL_TEX) ${FLAG} $(PREFACES_PDF) -o preface.tex
	$(TOOL_TEX) ${FLAG} ${CHAPTERS_PDF} -o chapters.tex
	$(TOOL_TEX) ${FLAG} ${APPENDIXS_PDF} -o appendix.tex

	${call pdfgen}

define pdfgen	
	cp docs/*.png .
	cp ${TEMPLATE}/template.tex omnetpp_primer-zh.tex

	# add cover to this ompz
	xelatex omnetpp_primer-zh.tex
	xelatex omnetpp_primer-zh.tex
	xelatex omnetpp_primer-zh.tex
	
	@echo "omnetpp_primer-zh.pdf Compiled!"
	
	@echo
	@echo "Done!"
endef



.PHONY: all book clean





