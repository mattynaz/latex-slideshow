\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slideshow}


% Required packages
\LoadClass{article}
\RequirePackage[T1]{fontenc}
\RequirePackage[paperheight=6.25in,paperwidth=10in,margin=1in]{geometry}
\RequirePackage{times}
\RequirePackage{xcolor}
\RequirePackage[colorlinks=true, allcolors=magenta]{hyperref}
\RequirePackage{fancyhdr}
\RequirePackage{bookmark}
\RequirePackage{enumitem}


% Slide and subslide counters
% (added support for autoref command from hyperref)
\newcounter{slide}
\newcounter{subslide}[slide]
\newcommand*\subslideautorefname{slide}
\renewcommand*\theslide{\arabic{slide}\alph{subslide}}
\renewcommand*\thesubslide{\arabic{slide}\alph{subslide}}


% Fancy headers
\newcommand{\headerfont}{\color{gray}\footnotesize}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\newcommand{\@showtitlehdrs}
{%
  \lhead{}%
  \chead{}%
  \rhead{}%
  \lfoot{\headerfont \@conference}%
  \cfoot{}%
  \rfoot{\headerfont \@date}%
}
\newcommand{\@showhdrs}
{%
  \lhead{}%
  \chead{}%
  \rhead{\headerfont \theslide}%
  \lfoot{\headerfont \@conference}%
  \cfoot{\headerfont \@title}%
  \rfoot{\headerfont \@date}%
}


% Additional title information
\newcommand{\conference}[1]{\def\@conference{#1}}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}


% Logic helpers
\newcommand{\@ifdefined}[3]{%
  \ifcsname#1\endcsname%
    #2%
  \else%
    #3%
  \fi%
}

\newcommand{\@ifempty}[3]
{%
  \if\relax\detokenize{#1}\relax%
    #2%
  \else%
    #3%
  \fi%
}


% Slide commands
\newcommand{\slide}[1][]
{
  \clearpage
  \@ifempty{#1}
  {
    \ifnum\value{subslide}=0
      \refstepcounter{subslide}
      \refstepcounter{subslide}
    \else
      \refstepcounter{subslide}
    \fi
  }
  {
    \refstepcounter{slide}
    \pdfbookmark{#1}{#1}
    {\bfseries \huge #1}
    \par\vspace{0.2in}
  }
  \@showhdrs
}

\newcommand{\headerslide}[2][]
{
  \slide
  \refstepcounter{slide}
  \vspace*{\fill}
  \begin{center}
    \@ifempty{#1}{}
    {
      \pdfbookmark{#1}{#1}
    }
    {\bfseries\Huge #2}
  \end{center}
  \vspace*{\fill}
}


% Insert style and title slide at document beginning 
\AtBeginDocument
{
  % page style options
  \Large
  \setlength\parindent{0em}
  \setlength\parskip{1em}
  \setlist[itemize]{itemsep=0.5\parskip, topsep=-0.5\parskip}
  \setlist[enumerate]{itemsep=0.5\parskip, topsep=-0.5\parskip}

  % title slide
  \pdfbookmark{Title}{title}
  \@showtitlehdrs
  \vspace*{\fill}
  \begin{center}
    {\bfseries\Huge \@title}
    \@ifdefined{@subtitle}
    {
      \par\vspace{0.15in}
      {\LARGE \@subtitle}
    }{}
    \par\vspace{0.5in}
    {\large\begin{tabular}[t]{c}\@author\end{tabular}}
  \end{center}
  \vspace*{\fill}
  \clearpage
}
