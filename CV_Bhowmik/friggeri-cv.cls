\ProvidesClass{friggeri-cv}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage[dvipsnames]{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{brown}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage{unicode-math}

\newfontfamily\bodyfont[]{Helvetica Neue}
\newfontfamily\thinfont[]{Helvetica Neue UltraLight}
\newfontfamily\headingfont[]{Helvetica Neue Condensed Bold}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Helvetica Neue Light}

%\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        Goldenrod\else%
        Goldenrod\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt]{biblatex}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[incollection]{title}{#1\par}
%\DeclareFieldFormat[book]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
%\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\adddot\space}%
    \printfield{doi}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

%\DeclareBibliographyDriver{book}{%
  %\printfield{title}%
  %\par%
  %\newblock%
  %{%
  %\small\addfontfeature{Color=lightgray}
  %\printlist{publisher}%
  %\setunit{\addcomma\space}%
  %\printlist{location}%
  %\setunit*{\addcomma\space}%
  %\printfield{month}%
  %\setunit*{\addspace\space}%
  %\printfield{year}%
  %\newunit%
  %}
  %\par\vspace{0.3\baselineskip}
%}

\DeclareBibliographyDriver{incollection}{%
  \printfield{title}%
  \par%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}
    \printfield{series}%
    \setunit{\addspace\space}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printnames{editor}%
    \setunit*{\addspace\space}%
    \print{(Eds)}%
    \setunit*{\addcomma\space}%
    \printfield{number}%
    \setunit{\addcomma\space}%
    \printfield{pages}%
    \setunit{\addcomma\space}%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\adddot\space}%
    \printfield{isbn}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}


\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printnames{editor}%
    \setunit{\addcomma\space}%
    \printfield{pages}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \setunit{\adddot\space}%
    \printlist{isbn}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

%\DeclareBibliographyDriver{unpublished}{%
  %\printfield{title}%
  %\par%
  %\newblock%
  %\printnames{author}%
  %\par%
  %\newblock%
  %{%
    %\footnotesize\addfontfeature{Color=lightgray}%
    %\printfield{note}%
    %\setunit{\addcomma\space}%
    %\printfield{year}%
    %\setunit{\addcomma\space}%
    %\printlist{location}%
    %\setunit{\adddot\space}%
    %\printfield{type}%
    %\newunit%
  %}
  %\par\vspace{0.3\baselineskip}
%}

%\DeclareBibliographyDriver{misc}{%
  %\printfield{title}%
  %\par%
  %\newblock%
  %\printnames{author}%
  %\par%
  %\newblock%
  %{%
    %\footnotesize\addfontfeature{Color=lightgray}%
    %\printfield{note}%
    %\setunit{\addcomma\space}%
    %\printfield{year}%
    %\setunit{\addcomma\space}%
    %\printlist{location}%
    %\newunit%
  %}
  %\par\vspace{0.3\baselineskip}
%}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{type}%
    \setunit{\addcomma\space}%
    \printlist{institution}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareNameFormat{author}{%
  \small\addfontfeature{Color=lightgray}%
  \ifgiveninits
    {\usebibmacro{name:given-family}
      {\namepartfamily}
      {\namepartgiveni}
      {\namepartprefix}
      {\namepartsuffix}}
    {\usebibmacro{name:given-family}
      {\namepartfamily}
      {\namepartgiven}
      {\namepartprefix}
      {\namepartsuffix}}%
  \usebibmacro{name:andothers}}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \printbibliography[sorting=chronological, type={#1}, title={#2}, heading=subbibliography]
  \end{refsection}
}

\DeclareSortingScheme{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}

\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldsource=rights,
            match=Paper,
            final]
      \step[fieldset=keywords, fieldvalue=confpaper]
      }
    \map{
      \step[fieldsource=rights,
            match=invited,
            final]
      \step[fieldset=keywords, fieldvalue=invpres]
      }
    \map{
      \step[fieldsource=rights,
            match=Presentations,
            final]
      \step[fieldset=keywords, fieldvalue=presconf]
      }
    \map{\step[fieldsource=rights,
            match=Posters,
            final]
      \step[fieldset=keywords, fieldvalue=posconf]
    }
    \map{\step[fieldsource=rights,
            match=Work,
            final]
      \step[fieldset=keywords, fieldvalue=workpaper]
    }
  }
}


%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=false,       
    linkcolor=red,          
    citecolor=red,        
    filecolor=red,      
    urlcolor = red}
    
% A fix for \href{}{} colors not working with fontspec
\makeatletter
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=#1}}
\makeatother