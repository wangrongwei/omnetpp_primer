BUILD = build
BOOKNAME = omnetpp-zh
METADATA = ebook/metadata.xml
TOC = --toc --toc-depth=2 --epub-chapter-level=2
COVER_IMAGE = docs/cover.png
LATEX_CLASS = book
PANDOC_TEX = pandoc --from="markdown_mmd+link_attributes+backtick_code_blocks+fenced_code_attributes+raw_tex+latex_macros" $(TOC) --pdf-engine=xelatex -V documentclass=book
TEMPLATE=./pdf

CHAPTERS =	chapter_1.md \
			chapter_2.md  \
			chapter_3.md \
			chapter_4.md  \
			chapter_5.md  \
			chapter_6.md  \
			chapter_7.md  \
			chapter_TODO.md  \
CHAPTERS_PDF = $(shell echo $(CHAPTERS) | sed 's/.md/_pdf.md/g')
#APPENDIXS =	appendix-a.md \
#			appendix-b.md \
#			appendix-c.md
#APPENDIXS_PDF = $(shell echo $(APPENDIXS) | sed 's/.md/_pdf.md/g')
#PDF_IMG = category.pdf code-zh.pdf song-book-jutta-scrunch-crop-zh.pdf
#SVG_IMG = docs/fs-translations/ar-libre.svg docs/fs-translations/be-libre.svg docs/fs-translations/bg-gratis.svg docs/fs-translations/bg-libre.svg docs/fs-translations/bn-libre.svg docs/fs-translations/el-gratis.svg docs/fs-translations/el-libre.svg docs/fs-translations/fa-gratis.svg docs/fs-translations/fa-libre.svg docs/fs-translations/he-gratis.svg docs/fs-translations/he-libre.svg docs/fs-translations/hi-gratis.svg docs/fs-translations/hi-libre.svg docs/fs-translations/hy-libre.svg docs/fs-translations/ja-kanji-gratis.svg docs/fs-translations/ja-kanji-libre.svg docs/fs-translations/ja-libre.svg docs/fs-translations/ka-gratis.svg docs/fs-translations/ka-libre.svg docs/fs-translations/ko-libre.svg docs/fs-translations/mk-gratis.svg docs/fs-translations/mk-libre.svg docs/fs-translations/ml-gratis.svg docs/fs-translations/ml-libre.svg docs/fs-translations/ru-gratis.svg docs/fs-translations/ru-libre.svg docs/fs-translations/si-libre.svg docs/fs-translations/sr-gratis.svg docs/fs-translations/sr-libre.svg docs/fs-translations/ta-gratis.svg docs/fs-translations/ta-libre.svg docs/fs-translations/th-libre.svg docs/fs-translations/uk-libre.svg docs/fs-translations/ur-gratis.svg docs/fs-translations/ur-libre.svg docs/fs-translations/vi-libre.svg docs/fs-translations/zh-cn-free.svg docs/fs-translations/zh-cn-gratis.svg docs/fs-translations/zh-cn-libre.svg docs/fs-translations/zh-tw-free.svg docs/fs-translations/zh-tw-gratis.svg docs/fs-translations/zh-tw-libre.svg

all: book html

book: epub pdf odf

clean:
		-rm *.tex *.aux *.fot *.toc *.log *.out
		-rm -r site
		-rm $(BOOKNAME).*
		-rm $(CHAPTERS_PDF)


pdf: $(BOOKNAME).pdf


%.pdf: %.svg
	rsvg-convert -f pdf -o $@ $<

$(CHAPTERS_PDF) : %.md
	cp $< $@
#	编译时把<!--(pdf)和(pdf)-->去掉，把<!--(pdf-newline)--><br>替换成\newline{}，将svg替换成pdf
	sed -i 's/<!--(pdf)//g;s/(pdf)-->//g;s/.svg)/.pdf)/g;s/<!--(pdf-newline)--><br>/\\newline{}/g' $@


$(BOOKNAME).pdf: $(CHAPTERS_PDF)
	$(PANDOC_TEX) ${CHAPTERS_PDF} -o chapters.tex
#	sed -i 's/\(\\includegraphics.*\)\.svg\}/\1.pdf}/g' chapters.tex appendix.tex
	${call pdfgen}

define pdfgen
	xelatex omnetpp-zh.tex
	xelatex omnetpp-zh.tex
	xelatex omnetpp-zh.tex

	@echo "PDF Compiled!"

	@echo
	@echo "Done!"
endef




.PHONY: all book clean epub html
