% !TEX TS-program = arara
% arara: lualatex: { shell: yes }
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hwk}[2024/06/01 v1 homework typesetting]

\RequirePackage{etoolbox}
\DeclareOption{insecs}{\def\insecs}
\ProcessOptions\relax


\LoadClass{article}
\RequirePackage{minted, fancyhdr, titling}
\RequirePackage[margin=1in,headheight=24pt]{geometry}
\RequirePackage[lastexercise]{exercise}
\RequirePackage{newcomputermodern}



\newcommand{\coursenum}[1]{\def\thecoursenum{#1}}
\newcommand{\coursetitle}[1]{\def\thecoursetitle{#1}}
\newcommand{\@course}{
    \ifboolexpr{
        (test {\ifdef{\thecoursenum}} 
            or test {\ifdef{\thecoursetitle}}
        )}
        {
            \large 
            \ifdef{\thecoursenum}{\thecoursenum}
                {} 
            \ifboolexpr{
                        test {\ifdef{\thecoursenum}} 
                        and test {\ifdef{\thecoursetitle}}
                }
                {--}
                {}
            \ifdef{\thecoursetitle}{\thecoursetitle}{} \par
        }
        {}
        }
    
        

\renewcommand{\@maketitle}{
    \newpage
    \thispagestyle{plain}
        \begin{center}%
            {\LARGE \@title \par}%
            \vskip .5em%
            {\large
            \lineskip .5em%
            \begin{tabular}[t]{c}%
                \@author
            \end{tabular}\par}%
            \vskip 1em%
            \@course
            {\large \@date}%
            \end{center}%
            \par
            \vskip 1.5em
}

\newcommand{\makeheader}{
    \pagestyle{fancy}
    \fancyhead[L]{\ifdef{\thecoursenum}{\thecoursenum\\}{}\thetitle}
    \fancyhead[R]{\theauthor}
    \fancyfoot{}
    \fancyfoot[C]{\thepage}
}
\renewcommand{\footrulewidth}{0.4pt}% default is 0pt
\fancypagestyle{plain}
{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}%
    \fancyfoot[C]{\thepage}
}


\setminted{autogobble,breaklines,frame=single, xleftmargin=1em, xrightmargin=1em}
\setminted[text]{linenos=false}
\usemintedstyle{bw}

\renewcommand{\AtBeginExercise}{\itshape}
\renewcommand{\ExerciseHeader}{\scshape\bfseries\noindent
\ExerciseHeaderDifficulty\ExerciseName\ %
    \ExerciseHeaderNB\ExerciseHeaderTitle\ExerciseHeaderOrigin.}
\renewcommand{\AnswerHeader}{\bigskip %
    \noindent\scshape\bfseries\AnswerName~\ExerciseHeaderNB.}
\renewcommand{\AnswerName}{Solution}
\ifdef{\insecs}
{
    \counterwithin{Exercise}{section}
    \renewcommand{\theExercise}{\thesection-\arabic{Exercise}}
} 
{}