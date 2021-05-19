%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Gabriel Gress (while math procrastinating homework) %
%                          March 29, 2020                        %
%                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Required for TeX classes
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hwtemplate}[03-29-20 Commands and Packages for Basic Homework Template]

% Based off of the `article' class
\LoadClass{article}

\def\R{\mathbb{R}}
\def\N{\mathbb{N}}
\def\Q{\mathbb{Q}}
\def\Z{\mathbb{Z}}
\def\C{\mathbb{C}}
\RequirePackage{xkeyval}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{import}
\RequirePackage{xifthen}
\RequirePackage{pdfpages}
\RequirePackage{transparent}
\RequirePackage{xcolor}
\RequirePackage[english]{babel}
\RequirePackage[protrusion=true,expansion=true]{microtype}
\RequirePackage{fancyhdr}
\RequirePackage{extramarks}
\RequirePackage{amsfonts}
\RequirePackage{listings}
\RequirePackage{titling}
\RequirePackage[letterpaper]{geometry}
\RequirePackage{microtype}
\RequirePackage{enumerate}
\RequirePackage{multicol}
\RequirePackage[osf]{mathpazo}

\graphicspath{{./figures/}} % ensures that figures are found for inkscape svgs

\def\changeformat#1{\xchangeformat#1\relax}
\def\xchangeformat#1-#2-#3\relax{%
\ifcase#1 \or
January\or February\or March\or April\or May\or June\or July\or
August\or September\or October\or November\or December\fi
\ #2, 20#3}

% Take key=val options from the \documentclass declaration
\DeclareOptionX{num}[]{\newcommand{\hwnum}{#1}}
\DeclareOptionX{course}[]{\newcommand{\course}{#1}}
\DeclareOptionX{proflastname}[]{\newcommand{\profname}{#1}}
\DeclareOptionX{duedate}[]{\newcommand{\due}{\changeformat{#1}}}
\DeclareOptionX{type}[Homework]{\newcommand{\assignmenttype}{#1}}
\DeclareOptionX{studentid}[]{\newcommand{\studentid}{#1}}
\DeclareOptionX{name}[]{\newcommand{\name}{#1}}
\DeclareOptionX{emaildomain}[rice.edu]{\newcommand{\emaildomain}{#1}}

\ProcessOptionsX\relax

% Raise errors if any of the options are undefined
\@ifundefined{hwnum}{ \ClassError{homework}{hwnum option required}{} }{}
\@ifundefined{course}{ \ClassError{homework}{course option required}{} }{}
\@ifundefined{profname}{ \ClassError{homework}{professor last name option required}{} }{}

% Set default values if optional options are undefined
\@ifundefined{due}{ \newcommand{\due}{\today}}{}
\@ifundefined{assignmenttype}{ \newcommand{\assignmenttype}{Homework} }{}
\@ifundefined{studentid}{ \newcommand{\studentid}{gjg3}}{}
\@ifundefined{name}{\newcommand{\name}{Gabriel Gress}}{}
\@ifundefined{emaildomain}{ \newcommand{\emaildomain}{rice.edu} }{}

% Define commands depending on components passed as key/values or default options
\newcommand{\assignmentname}{\assignmenttype{} \hwnum}
\newcommand{\email}{\studentid @\emaildomain}

% Set PDF metadata based on the global variables
\RequirePackage[pdftex,
    pdfauthor={\name},
    pdftitle={\course{} -- \assignmentname}]{hyperref}

\newtheorem{defn}{Definition}
\newtheorem{prop}{Proposition}
\newtheorem{lemma}{Lemma}
\newtheorem{thm}{Theorem}
\newtheorem{exmp}{Example}

\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}

\newcommand{\incfig}[1]{%
    \def\svgwidth{\columnwidth}
    \import{./figures/}{#1.pdf_tex}
}
\pdfsuppresswarningpagegroup=1

\topmargin=-0.45in
\evensidemargin=0in
\oddsidemargin=0in
\textwidth=6.5in
\textheight=9.0in
\headsep=0.25in

\linespread{1.1}

\pagestyle{fancyplain}
\lhead{\name \\ \textit{\email}}
\chead{\course : \assignmentname}
\rhead{\due \\ \firstxmark}
\lfoot{\lastxmark}
\cfoot{\thepage}


\renewcommand\headrulewidth{0.4pt}
\renewcommand\footrulewidth{0.4pt}

\setlength\parindent{0em}
\setlength{\parskip}{1em}

\RequirePackage{titlesec}
\titleformat{\section}{\large\sc}{}{0em}{}
\titlespacing{\section}{0em}{0em}{1em}

%
% Create Problem Sections
%

\newcommand{\enterProblemHeader}[1]{
    \nobreak\extramarks{}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
    \nobreak\extramarks{Problem \arabic{#1} (continued)}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
}

\newcommand{\exitProblemHeader}[1]{
    \nobreak\extramarks{Problem \arabic{#1} (continued)}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
    \stepcounter{#1}
    \nobreak\extramarks{Problem \arabic{#1}}{}\nobreak{}
}

\setcounter{secnumdepth}{0}
\newcounter{partCounter}
\newcounter{homeworkProblemCounter}
\setcounter{homeworkProblemCounter}{1}
\nobreak\extramarks{Problem \arabic{homeworkProblemCounter}}{}\nobreak{}

%
% Homework Problem Environment
%
% This environment takes an optional argument. When given, it will adjust the
% problem counter. This is useful for when the problems given for your
% assignment aren't sequential. See the last 3 problems of this template for an
% example.
%
\newenvironment{problem}[1][-1]{
    \ifnum#1>0
        \setcounter{homeworkProblemCounter}{#1}
    \fi
    \section{Problem \arabic{homeworkProblemCounter}}
    \setcounter{partCounter}{1}
    \enterProblemHeader{homeworkProblemCounter}
}{
    \exitProblemHeader{homeworkProblemCounter}
}

% Boxed ``to-do'' statements to make incomplete problems clear
\newcommand{\todo}{\fbox{TO-DO}\ \ }

% 75% measure rules to split problems into sections
\newcommand{\separator}{\vfill \begin{center} \rule{0.75\linewidth}{0.5pt} \\ \end{center} \vfill}

% Environment for consistently-formatted claim statements
\newenvironment{claim}{\textit{Claim.}}{\vspace{-1em}}

% Redefine the ampersand to use the italic version by default - as-per Elements of Typographic Style
% See: https://tex.stackexchange.com/a/47353/150811
\let\textand\&
\renewcommand{\&}{\textit{\textand}}

% Redefine the maketitle command to format properly, and not have a header on the page
\let\origtitle\maketitle
\renewcommand{\maketitle}{
    \setlength{\parskip}{0em}
    \origtitle
    \thispagestyle{empty}
    \setlength{\parskip}{1em}
}

% Redefine epsilon and empty set commands to use better-looking versions
\renewcommand{\epsilon}{\ensuremath{\varepsilon}}
\renewcommand{\emptyset}{\varnothing}

% Redefine the bar and vec commands to use larger overlines and bold-faced vectors
\renewcommand{\bar}{\overline}
\renewcommand{\vec}{\mathbf}

\title{
    \vspace{2in}
    \textmd{\textbf{\course:\ \assignmentname}} \\\\
    \normalsize\vspace{0.1in}\small{Due\ on\ \due}\\\\
    \vspace{0.1in}\large{\textit{Professor \profname}}
    \vspace{3in}
}

\author{\name}
\date{Last edited \today}

