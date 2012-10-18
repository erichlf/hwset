% Originally taken from HMC Math dept HW class file
% v0.04 by Eric J. Malm, 10 Mar 2005
% v0.05 by Erich L Foster 10 September 2009
% v2.0 by Erich L Foster 06 May 2010
%%% IDENTIFICATION --------------------------------------------------------
%\NeedsTeXFormat{LaTeX2e}[01/01/10]
\ProvidesClass{hwset}
    [09/06/2010 v2.0 Mathematics Problem Set Class]

%%% INITIAL CODE ----------------------------------------------------------
%% Flag for compilation to PDF
%\newif\ifpdf
%\ifx\pdfoutput\undefined
%    \pdffalse
%\else
%    \pdfoutput = 1
%    \pdftrue
%\fi

%%% DECLARATION OF OPTIONS ------------------------------------------------
%% Font Options: palatino*, cm
\newif\ifhwset@palatino

% use palatino fonts
\DeclareOption{palatino}{%
    \hwset@palatinotrue%
}

% use compuer modern fonts
\DeclareOption{cm}{%
    \hwset@palatinofalse%
}

%% Problem Boxing: boxed*, unboxed
\newif\ifhwset@boxed

% box problem statements
\DeclareOption{boxed}{%
    \hwset@boxedtrue%
}
   
% don't box problem statements
\DeclareOption{unboxed}{%
    \hwset@boxedfalse%
}
   
% pass remaining options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
% loading mathpazo package for palatino fonts,
% boxing problem statements
\ExecuteOptions{palatino,boxed}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std article class
\LoadClass{article}

%% Font loading: Palatino text/math fonts
\ifhwset@palatino
    \RequirePackage{mathpazo}
\fi

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath, amsthm, amssymb}
\RequirePackage[normalem]{ulem}
\RequirePackage[left=1in,top=1in,right=1in]{geometry}
\RequirePackage{enumerate}
\RequirePackage{paralist}
\RequirePackage{cancel}
\RequirePackage{tikz}
\RequirePackage{gauss}
\RequirePackage[page]{appendix}

%% boxed minipage for boxed problem environment
\RequirePackage{boxedminipage}

%For including pdf images
\RequirePackage{graphicx}
\RequirePackage{float}

%MATLAB Code formatting
\RequirePackage{listings}
\RequirePackage{verbatim}

\lstset{% command to set programming language parameter(s)
frame=single,
	showstringspaces=false,
	showlines=false, %get rid of trailing white lines
	emptylines=1, %allow blank line 
	breaklines=true, %get rid of overflow lines and enter \n
	numbers=left, %line number
	numberstyle=\scriptsize, %make line numbers small
	stepnumber=1, %line number every line
	numbersep=5pt,
	tabsize=2, %set tabs to two spaces
	basicstyle=\small, % print whole listing small
	keywordstyle=\bfseries,% green keywords
	stringstyle=\ttfamily % typewriter type for strings
}


%%% MAIN CODE -------------------------------------------------------------
%% Tell dvips/pdflatex correct page size
%\ifpdf
%  \AtBeginDocument{%
%    \setlength{\pdfpageheight}{\paperheight}%
%    \setlength{\pdfpagewidth}{\paperwidth}%
%  }
%\else
%  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
%\fi

%New angle bracket command
\newcommand{\lrangle}[1]{
	\langle #1 \rangle
}

%shorter bold font
\newcommand{\mbf}[1]{
	\mathbf{#1}
}
\newcommand{\tbf}[1]{
	\textbf{#1}
}

%Math Operators
\DeclareMathOperator{\inv}{inv}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\id}{id}
\DeclareMathOperator{\Ran}{Ran}
\DeclareMathOperator{\Aut}{Aut}
\DeclareMathOperator{\Fun}{Fun}
\DeclareMathOperator{\End}{End}
\DeclareMathOperator{\Sym}{Sym}
\DeclareMathOperator{\lcm}{lcm}
\DeclareMathOperator{\Stab}{Stab}
\DeclareMathOperator{\Fix}{Fix}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\dist}{dist}
\DeclareMathOperator{\divergence}{div}
\DeclareMathOperator{\im}{im}

%Shorter mathbb
\newcommand{\C}{\mathbb{C}} 
\newcommand{\N}{\mathbb{N}} 
\newcommand{\Q}{\mathbb{Q}} 
\newcommand{\R}{\mathbb{R}} 
\newcommand{\Z}{\mathbb{Z}} 
\newcommand{\I}{\mathbb{I}} 
\newcommand{\qid}{\mathbf{1}}
\newcommand{\qi}{\mathbf{i}}
\newcommand{\qj}{\mathbf{j}}
\newcommand{\qk}{\mathbf{k}}
\newcommand{\Order}{\mathcal{O}}
\newcommand{\order}{\mathcal{o}}

%Change labeling for enumerate
\renewcommand{\theenumi}{(\alph{enumi})}
\renewcommand{\theenumii}{(\roman{enumii})}
\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\roman{enumii})}

%% Problem set environments
% boxed problem environment
\newenvironment{problem}[1][]{%
  \ifhwset@boxed\def\hwset@probenv{boxed}\else\def\hwset@probenv{}\fi%
  %\bigskip% put space before problem statement box %
  \noindent\begin{\hwset@probenv minipage}{\columnwidth}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty\else%
    \hwset@probformat{#1}\hspace{0.5em}%
  \fi%
}{%
  \end{\hwset@probenv minipage}%
}
% display optional argument to problem in bold
\let\hwset@probformat\textb140.4f

% solution environment with endmark and optional argument
\newenvironment{solution}[1][]{%
  \begin{trivlist}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty%
    \item[]%
  \else%
    \item[\hskip\labelsep\relax #1]%
  \fi%
}{%
  \mbox{}\penalty10000\hfill\hwset@endmark%
  \end{trivlist}%
}

% default endmark is small black square
\def\hwset@endmark{\ensuremath{\scriptscriptstyle\blacksquare}}

% internal state for headerblock
\def\hwset@name{}
\def\hwset@class{}
\def\hwset@assignment{}
\def\hwset@duedate{}
\def\hwset@extraline{}

% Setup the header and footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[L]{\hwset@name}
\fancyhead[C]{\hwset@class\\ \hwset@assignment}
\fancyhead[R]{\hwset@duedate}
\fancyfoot[C]{Page\ \thepage}
\fancyfoot[L,R]{}
\renewcommand\headrulewidth{0.4pt}
\renewcommand\footrulewidth{0.4pt}

% commands to set header block info
\newcommand{\name}[1]{\def\hwset@name{#1}}
\newcommand{\class}[1]{\def\hwset@class{#1}}
\newcommand{\assignment}[1]{\def\hwset@assignment{#1}}
\newcommand{\duedate}[1]{\def\hwset@duedate{#1}}
\newcommand{\extraline}[1]{\def\hwset@extraline{#1}}

%no paragraph indent
\setlength{\parindent}{0pt}
\setlength{\parskip}{2ex}
