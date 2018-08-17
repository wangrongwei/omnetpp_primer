%% tstextbook.cls
%% Copyright 2016 Typesetters.se
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This is a free LaTeX text book template from Typesetters.se.
% See tstextbook.tex for an example of how to use this class.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tstextbook}[2017/02/19 Free LaTeX text book template from Typesetters.se]
\LoadClass[11pt,onecolumn,titlepage,twoside,openany,UTF8]{ctexbook}
%{book}

%\documentclass[nofonts]{ctexart}
%\setCJKmainfont[BoldFont=STHeiti, ItalicFont=STKaiti]{STSong}
%\setCJKsansfont[BoldFont=STHeiti]{STXihei}
%\setCJKmonofont{STFangsong}

% Language
%--------------------------------------------------------------------------
%\RequirePackage[nofonts]{ctex} %[swedish]{babel} [nofonts]{ctexart}
\RequirePackage[utf8]{inputenc}

% Geometry
%--------------------------------------------------------------------------
\RequirePackage[top=2.5cm,bottom=2.5cm,left=3cm,right=3cm,
                marginparwidth=1.1cm,marginparsep=2mm]{geometry}

% Fonts
%--------------------------------------------------------------------------
\RequirePackage{kpfonts}

% Colors
%--------------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{tssteelblue}{RGB}{70,130,180}
\definecolor{tsorange}{RGB}{255,138,88}
\definecolor{tsblue}{RGB}{23,74,117}
\definecolor{tsforestgreen}{RGB}{21,122,81}
\definecolor{tsyellow}{RGB}{255,185,88}
\definecolor{tsgrey}{RGB}{200,200,200}

% Graphics
%--------------------------------------------------------------------------
\RequirePackage{graphicx}
\graphicspath{{./images/}}
\RequirePackage{tikz}
\RequirePackage[pages=some]{background}
\backgroundsetup{scale=1,color=black,opacity=1.0,angle=0,
contents={\includegraphics[width=\paperwidth,height=\paperheight]{omnetppp-zh_cover}}}

% Header and footer styling
%--------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\setlength{\headheight}{15.0pt}
\fancyhf{}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\it\sf\nouppercase{\rightmark}}
\fancyhead[LO]{\it\sf\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Section styling
%--------------------------------------------------------------------------
\RequirePackage{sectsty}

\sectionfont{\sf\color{tssteelblue}\sectionrule{0ex}{0pt}{-1ex}{1pt}}

% Chapter styling
%--------------------------------------------------------------------------
\makeatletter

% Numbered chapters (with minitoc)
\renewcommand{\@makechapterhead}[1]{
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
  {
    \begin{tikzpicture}[remember picture,overlay]
      % Background image
      \node[anchor=north west,inner sep=0pt] at (0,0)
			{\includegraphics[width=\paperwidth]{./images/background}};
      % Chapter heading
      \draw[anchor=west, inner sep=0pt] (-0.1cm,-1.5cm) node
           [black,
            ultra thick,
            fill=tsorange!10,
            fill opacity=.6,
            inner sep=10pt]
           (0,0)
           {\parbox[t][1.6cm][t]{\paperwidth}
           {\huge\bfseries\sffamily\flushleft\thechapter. #1}};
      % Chapter contents
      \draw[anchor=west,inner sep=0pt] (8.8cm,-7cm) node
           [tssteelblue,
            ultra thick,
            fill=white,
            fill opacity=.8,
            draw=tssteelblue,
            draw opacity=1,
            line width=1.5pt,
            rounded corners,
            inner sep=0pt]
           (0,0)
           {\hspace{1cm}\parbox[t][7.1cm][t]{11cm}
           {\vspace{-1cm}\huge\bfseries\sffamily\flushleft
            \textcolor{black}{\sffamily\minitoc}}};
    \end{tikzpicture}
  };
\end{tikzpicture}
\vspace{7.5cm}
}

% Unnumbered chapters (without minitoc)
\renewcommand{\@makeschapterhead}[1]{
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
  {
    \begin{tikzpicture}[remember picture,overlay]
      % Background image
      \node[anchor=north west,inner sep=0pt] at (0,0)
           {\includegraphics[width=\paperwidth]{./images/background}};
      % Chapter heading
      \draw[anchor=west,inner sep=0pt] (-0.1cm,-1.5cm) node
           [black,
            ultra thick,
            fill=tsorange!10,
            fill opacity=.6,
            inner sep=10pt]
           (0,0)
           {\parbox[t][1.6cm][t]{\paperwidth}
           {\huge\bfseries\sffamily\flushleft #1}};
    \end{tikzpicture}
  };
\end{tikzpicture}
\vspace{8cm}
}

% Minitoc styling
%--------------------------------------------------------------------------
\RequirePackage{minitoc}
\setcounter{minitocdepth}{2}
\dominitoc[n]
\nomtcrule
\nomtcpagenumbers
\renewcommand{\mtifont}{\large\sffamily}
\renewcommand{\mtcfont}{\small\sffamily}
\renewcommand{\mtcSfont}{\small\sffamily}
\renewcommand{\mtcSSfont}{\small\sffamily}
\renewcommand{\mtcSSSfont}{\small\sffamily}

% 目录风格
%--------------------------------------------------------------------------
\RequirePackage{titletoc}
\setcounter{tocdepth}{2}

\titlecontents{chapter}[0cm]
{\addvspace{14pt}\large\sffamily\bfseries}
{\color{tssteelblue}\contentslabel[\Large\thecontentslabel]{2.25cm}}{}
{\color{tssteelblue}\normalsize\sffamily\bfseries
 \;\titlerule*[.5pc]{.}\;\thecontentspage}

\titlecontents{section}[0cm]
{\addvspace{6pt}\sffamily\bfseries}
{\contentslabel[\thecontentslabel]{1.25cm}}{}
{\sffamily\hfill\color{black}\thecontentspage}[]

% Front matter
%--------------------------------------------------------------------------
\newcommand{\tsbook}[9]{

\pagestyle{empty}

\def\@tstitle{#1}
\def\@tsauthor{#2}
\def\@tscoverdesign{#3}
\def\@tsyear{#4}
\def\@tsartno{#5}
\def\@tsisbn{#6}
\def\@tsedition{#7}
\def\@tspublished{#8}
\def\@tsprinted{#9}

% 封面页设计
\BgThispage
\begin{center}
  \null
  \smallskip

  \color{white}
  \sffamily

  \Huge
  \textsc{\@tstitle}

  \bigskip
  \smallskip

  \LARGE
  \textsc{\@tsauthor} \\[1em]
  \Large
  %\textsc{\@tspublished}
\end{center}

\pagebreak


% 版权页声明
\null
\vfill
\begin{flushleft}
  Copyright \copyright \ \@tsyear \ \@tsauthor \\
  \vspace{5mm}
  % \textbf{Copying prohibited} \\
  \vspace{5mm}
  该文档记录了作者从在设计一个无人机蜂群网络的时候，从初学OMNeT++软件开始
  遇到的各种问题，苦于当初无处找到答案，只能上google-group提问题，阅读大量的
  网络仿真程序，慢慢的才对这个软件的各种接口使用和设置才熟悉，特此，在该文档下记
  录各种OMNeT++的操作，来减少读者的开发和网络仿真的烦恼。\\
  \vspace{5mm}
  % Art. No \@tsartno \\
  % ISBN \@tsisbn \\
  % Edition \@tsedition \\
  \vspace{5mm}
  Cover design by \@tsauthor \\
  \vspace{5mm}
  % Published by \@tspublished \\
  % Printed in \@tsprinted
\end{flushleft}

% Table of contents
\tableofcontents

\cleardoublepage
\pagestyle{fancy}
\thispagestyle{empty}
}

% Boxes for theorems
%--------------------------------------------------------------------------
\newenvironment{boxtheorem}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=black!5,colframe=tsorange]}
{\end{tcolorbox}}

\newenvironment{boxdefinition}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=yellow!10!white,boxrule=0pt,frame hidden,
 borderline west={1.5mm}{-2mm}{tsforestgreen}]}
{\end{tcolorbox}}

\newenvironment{boxexercise}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=tsyellow!20,boxrule=0pt,frame hidden]}
{\end{tcolorbox}}

\newenvironment{boxproblem}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=tsorange!25,boxrule=0pt,frame hidden]}
{\end{tcolorbox}}

\newenvironment{boxprogramming}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=tsblue!10,boxrule=0pt,frame hidden]}
{\end{tcolorbox}}

\newenvironment{boxexample}
{\begin{tcolorbox}
[enhanced jigsaw,breakable,pad at break*=1mm,
 colback=tsgrey!20,boxrule=0pt,frame hidden]}
{\end{tcolorbox}}

% Styling of theorems
%--------------------------------------------------------------------------
\RequirePackage{amsthm}

\newtheoremstyle{styletheorem}
{0pt}{0pt}{\normalfont}{0pt}{\small\bf\sffamily\color{tsorange}}{\;}{0.25em}
{\small\sffamily\color{tsorange}\thmname{#1}
 \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
 \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styledefinition}
{0pt}{0pt}{\normalfont}{0pt}{\small\bf\sffamily\color{black}}{\;}{0.25em}
{\small\sffamily\color{tsforestgreen}\thmname{#1}
 \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
 \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\newtheoremstyle{styleexercise}
{0pt}{0pt}{\normalfont}{0pt}{\small\bf\sffamily\color{black}}{\;}{0.25em}
{\small\sffamily\color{black}\thmname{#1}
 \nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
 \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black} (#3)}}

\theoremstyle{styledefinition}
\newtheorem{envdefinition}{Definition}[chapter]
\theoremstyle{styletheorem}
\newtheorem{envtheorem}{Theorem}[chapter]
\newtheorem{envlemma}{Lemma}[chapter]
\theoremstyle{styleexercise}
\newtheorem{envexercise}{Exercise}[chapter]
\newtheorem{envproblem}{Problem}[chapter]
\newtheorem{envprogramming}{Computer exercise}[chapter]
\newtheorem{envexample}{Exempel}[chapter]

% Environments for theorems
%--------------------------------------------------------------------------
\newenvironment{definition}
               {\begin{boxdefinition}\begin{envdefinition}}
               {\end{envdefinition}\end{boxdefinition}}

\newenvironment{theorem}
               {\begin{boxtheorem}\begin{envtheorem}}
               {\end{envtheorem}\end{boxtheorem}}

\newenvironment{corollary}
               {\begin{boxtheorem}\begin{envtheorem}}
               {\end{envtheorem}\end{boxtheorem}}

\newenvironment{lemma}
               {\begin{boxtheorem}\begin{envlemma}}
               {\end{envlemma}\end{boxtheorem}}

\newenvironment{exercise}
               {\begin{boxexercise}\begin{envexercise}}
               {\end{envexercise}\end{boxexercise}}

\newenvironment{problem}
               {\begin{boxproblem}\begin{envproblem}}
               {\end{envproblem}\end{boxproblem}}

\newenvironment{programming}
               {\begin{boxprogramming}\begin{envprogramming}}
               {\end{envprogramming}\end{boxprogramming}}

\newenvironment{example}
               {\begin{boxexample}\begin{envexample}}
               {\end{envexample}\end{boxexample}}

% Other environments
%--------------------------------------------------------------------------
\newenvironment{summary}
{\hspace{10pt}\par\small\it
 \begin{list}{}{\leftmargin=35pt\rightmargin=25pt}
 \item\ignorespaces\advance\baselineskip -1pt}
{\end{list}\vspace{-0.5cm}}

\newenvironment{remark}
{\vspace{0.5cm}\noindent\small\it
 \marginpar{\vspace{-3mm}\includegraphics[width=1.0cm]{idea}}}
{\vspace{0.5cm}}

% Bibliography
%--------------------------------------------------------------------------
\RequirePackage[backend=biber]{biblatex}
\addbibresource{bibliography.bib}

% Index
%--------------------------------------------------------------------------
\RequirePackage{makeidx}
\makeindex

% Packages for mathematics and algorithms
%--------------------------------------------------------------------------
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{xfrac}
\RequirePackage{mathtools}
\RequirePackage{wasysym}
\RequirePackage{siunitx}
\newcommand\bmmax{2}
\RequirePackage{bm}

% Other useful packages
%--------------------------------------------------------------------------
\RequirePackage{blindtext}
\RequirePackage[most]{tcolorbox}
\RequirePackage{booktabs}
\RequirePackage{url}
