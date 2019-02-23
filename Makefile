BUILD = build
BOOKNAME = omnetpp_primer-zh

#APPENDIXS_PDF = $(shell echo $(APPENDIXS) | sed 's/.md/_pdf.md/g')

all: book

book: $(BOOKNAME).pdf

clean:
	$(MAKE) -C latex clean


$(BOOKNAME).pdf:
	$(MAKE) -C latex all

	@echo "omnetpp_primer-zh.pdf Compiled!"
	@echo
	@echo "Done!"


.PHONY: all book clean

