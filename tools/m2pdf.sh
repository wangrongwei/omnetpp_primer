#!/bin/bash

pandoc ../chapter_1.md -o ../pdf/chapter_1.pdf --latex-engine=xelatex --template=pm-template.latex
pandoc ../chapter_2.md -o ../pdf/chapter_2.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_3.md -o ../pdf/chapter_3.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_4.md -o ../pdf/chapter_4.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_5.md -o ../pdf/chapter_5.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_6.md -o ../pdf/chapter_6.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_7.md -o ../pdf/chapter_7.pdf --latex-engine=xelatex --template=pm-template.latex

pandoc ../chapter_8.md -o ../pdf/chapter_8.pdf --latex-engine=xelatex --template=pm-template.latex


python3 merge2pdf.py -p "D:\git\omnetppp_primer\pdf" -o "omnetpp_primer-zh.pdf" -b True'

