## Introduction ##

As open source books, ebooks and pdf format should be created on fly, the following sections describe those solution in detail.

 * Markdownbook/*.md : all source chapters
 * template/template.tex : book style

## Making Pdf books ##
PDF format is used to read/print in nice way like real book, [MultiMarkdown](http://fletcherpenney.net/multimarkdown/) is good at this and it is used instead to generate latex from multimarkdown, and latex tool `xelatex` (is part of [TexLive][texlive] now) is used to convert pdf from latex.

Please check [ctax](http://www.ctan.org/) and [TexLive][texlive] for more background for latex, which is quite complicated and elegant if you have never touched before.

### Ubuntu Platform ###

Ubuntu Platform Precise (18.04) is used mainly and it is continuously verified by travis-ci.org as well. 

    $ sudo apt-get install texlive-xetex
    $ sudo apt-get install texlive-latex-recommended # main packages
    $ sudo apt-get install texlive-latex-extra # package titlesec
	
You need to install related fonts for Chinese, fortunately they exist in ubuntu source also.
    
    $ sudo apt-get install fonts-arphic-gbsn00lp fonts-arphic-ukai # from arphic 
    $ sudo apt-get install fonts-wqy-microhei fonts-wqy-zenhei # from WenQuanYi


### Generate PDF ###

`multimarkdown` shall be compiled from git source，if not, maybe you can run "scripts/install.multimarkdown.sh".

Then it should work perfectly

	$ make

### Latex template ###

the latex template is `template/template.tex`, it contains the style and include the `preface`,`chapters`,`appendix` latex files, which are generated from source chapters.

    
[texlive]: http://www.tug.org/texlive/
