%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my-resume.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A class to do stuff.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-resume}[2020/11/17 my-resume v0.1, my own resume/CV class.]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% option to have a single sided document, i.e. the highlight bar is always left
% or have a two sided document where the highlight bar is alternating, i.e. always on the same edge of the paper
\RequirePackage{ifthen}
\newboolean{@singleordouble}
\setboolean{@singleordouble}{true}
\DeclareOption{singlesided}{\setboolean{@singleordouble}{true}}
\DeclareOption{doublesided}{\setboolean{@singleordouble}{false}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions*

\ifthenelse{\boolean{@singleordouble}}
    {\PassOptionsToClass{oneside}{scrartcl}}
    {\PassOptionsToClass{twoside}{scrartcl}}

\LoadClass{scrartcl}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REQUIRED PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}       % somehow required for tikz to work at all
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{fontawesome}
\RequirePackage{academicons}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILTER IRRELEVANT WARNINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{silence}

% The page header is deliberately disabled in my-resume, so the warning by scrlayer-scrpage is invalid. 
\WarningFilter{scrlayer-scrpage}{Very small head height detected!}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength\highlightwidth
\newlength\headerheight
\newlength\marginleft
\newlength\marginright
\newlength\margintop
\newlength\marginbottom

% default sizes, margins, ...
\setlength\highlightwidth{8cm}
\setlength\headerheight{6cm}
\setlength\marginleft{1cm}
\setlength\marginright{\marginleft}
\setlength\margintop{1cm}
\setlength\marginbottom{1cm}

\RequirePackage[bindingoffset=0cm,nomarginpar,noheadfoot]{geometry}
\geometry{left=\marginleft,right=\marginright,top=\margintop,bottom=\marginbottom}

% \setlength{\voffset}{\dimexpr -1in+\margintop}
% \setlength{\topmargin}{0cm}

% minipage has an annoying af indent that must be removed
\setlength{\parindent}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xcolor}

% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{mediumgray}{HTML}{444444}
\definecolor{gray}{HTML}{5D5D5D}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COLORED BARS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xpatch}
\RequirePackage{scrlayer-scrpage}

% declare new page style using layers
\DeclareNewPageStyleByLayers{headerhighlightmain}{%
  highlightbar.even,%
  highlightbar.odd,%
  header.bg
}
\DeclareNewPageStyleByLayers{highlightmain}{%
  highlightbar.even,%
  highlightbar.odd
}
\DeclareNewPageStyleByLayers{headermain}{%
  header.bg
}

% define the layer for the highlight bar on odd pages
\DeclareNewLayer[
  background,
  oddpage,
  innermargin,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.odd}

% clone highlight bar form odd pages to even pages
% on same side for digital format
\newcommand*\highlightbarsingle{%
\DeclareNewLayer[
  background,
  evenpage,
  outermargin,
  width=\highlightwidth,
  contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
]{highlightbar.even}
}

% clone highlight bar from odd pages to even pages
% on opposite sides for prints
\newcommand*\highlightbardouble{%
\DeclareNewLayer[
    clone=highlightbar.odd,
    evenpage,
    align=r,
    hoffset=\paperwidth
  ]{highlightbar.even}
 }

% use the correct version of the highlight bar on even pages
% single for single, double for double
\ifthenelse{
    \boolean{@singleordouble}
}{%
    \DeclareNewLayer[
      background,
      evenpage,
      outermargin,
      width=\highlightwidth,
      contents={\color{highlightbarcolor}\rule{\layerwidth}{\layerheight}}
    ]{highlightbar.even}
}{%
    \DeclareNewLayer[
        clone=highlightbar.odd,
        evenpage,
        align=r,
        hoffset=\paperwidth
      ]{highlightbar.even}
}

% define the layer for the header 
\DeclareNewLayer[
  background,
  topmargin,
  addheight=\headerheight,
  contents={\color{headerbarcolor}\rule{\layerwidth}{\layerheight}}
]{header.bg}

% % add the layers to page style plain
% \ForEachLayerOfPageStyle*{headerhighlightmain}{%
%   \AddLayersToPageStyle{plain.scrheadings}{#1}%
% }

% remove anything that might be there (page number) from header and footer
\lehead[]{}
\cehead[]{}
\rehead[]{}
\lohead[]{}
\cohead[]{}
\rohead[]{}
\lefoot[]{}
\cefoot[]{}
\refoot[]{}
\lofoot[]{}
\cofoot[]{}
\rofoot[]{}

% convenience functions to enable/disable header or highlightbar
% TBD


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% variables for name, tag line and photo setup
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[3][]{\def\@photo{#2}\def\@photodiameter{#3}\def\@photoformat{#1}}

% try to align the top of the written out name with the top of the photo
% it is impossible to get the actual height of a line to determine the offset between line top and charachter top
% therefore use a bad workaround by setting the line height to 1.5 times the character height
\newlength{\@namefontheight}
\newlength{\@namelineheight}
\settoheight{\@namefontheight}{\Huge\bfseries\MakeUppercase{A}}
\setlength\@namelineheight{1.5\@namefontheight}

% assemble the header
\newcommand{\makeheader}{% header bar is a minipage
    \begin{minipage}[t][\headerheight]{\textwidth}%
        % \vspace{-1em}
        \vspace{\dimexpr \@namefontheight-\@namelineheight}                     % align top of name and photo
        % create two minipages for header text and photo if photo is given
        \ifdef{\@photodiameter}{
            \begin{minipage}[t]{\dimexpr \textwidth-\@photodiameter}        % to top align name and photo add [t] here
                \vspace{0cm}%
            }{}
            % print the header text
                \begin{minipage}[t][2em]{\linewidth}
                    {\Huge\bfseries\color{headerfontcolor}\MakeUppercase{\@name}\par}
                \end{minipage}%
                \vfill%
                \begin{minipage}[b][\dimexpr \headerheight-2em-\marginbottom]{\linewidth}%
                    {\large\bfseries\color{headerfontcolor}\@tagline\par}
                \end{minipage}%
        % finish the minipages for text and photo if photo is given
        \ifdef{\@photodiameter}{%
            \end{minipage}\hfil%
            \begin{minipage}[t]{\@photodiameter}                                % to top align name and photo add [t] here
                \vspace{0cm}
    			% format as square or round
    			\ifthenelse{\equal{\@photoformat}{square}}{%
    			    \includegraphics[width=\linewidth]{\@photo}%
    			}{%
    			    \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    			}
    		\end{minipage}%
            }{}
	\end{minipage}%
}

\newcommand{\emptyheader}{%
    \vspace*{\dimexpr \headerheight+0.5em}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% contact info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\infofield}[2]{\mbox{\makebox[5mm]{\textcolor{accent}{\normalsize #1}}\hspace{0.5em}#2}\vspace{0.2em}\newline}
\newcommand{\email}[1]{\infofield{\faEnvelope}{\href{mailto:#1}{#1}}}
\newcommand{\address}[1]{\infofield{\faAt}{#1}}
\newcommand{\location}[1]{\infofield{\faMapMarker}{#1}}
\newcommand{\phone}[1]{\infofield{\faPhone}{#1}}
\newcommand{\homepage}[2]{\infofield{\faHome}{\href{#2}{#1}}}
\newcommand{\linkedin}[2]{\infofield{\faLinkedin}{\href{#2}{#1}}}
\newcommand{\github}[2]{\infofield{\faGithub}{\href{#2}{#1}}}
\newcommand{\orcid}[2]{\infofield{\aiOrcid}{\href{#2}{#1}}}
\newcommand{\ads}[2]{\infofield{\aiADS}{\href{#2}{#1}}}


% highlight bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\highlightbar}[1]{%
    \def\@highlightbar{%
        \begin{minipage}[t]{\dimexpr \highlightwidth-\marginleft-\marginright}%
            #1%
        \end{minipage}%
    }
}

% main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mainbar}[1]{%
    \def\@mainbar{%
        \begin{minipage}[t]{\dimexpr \textwidth-\highlightwidth}%
            #1%
        \end{minipage}%
    }
}

% make body with highlight bar and main bar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makebody}{%
    \ifthenelse{\boolean{@singleordouble}}
        {% if single layout, the highlight bar is always left
            \@highlightbar
            \hspace{\dimexpr \marginleft+\marginright}%
            \@mainbar
        }{% if double layout, the highlight bar alternates
            \Ifthispageodd{% if the page is odd, the highlight bar is on the left (as is for single layout)
                \@highlightbar
                \hspace{\dimexpr \marginleft+\marginright}%
                \@mainbar
            }{%  if the page is even, the highlight bar is on the right
                \@mainbar
                \hspace{\dimexpr \marginleft+\marginright}%
                \@highlightbar
            }   
        }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTIONS, SUBSECTIONS, AND MORE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% redefine section in caps, bold and with rule below
\renewcommand{\section}[2][]{%
    \bigskip%
    % \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr 1pt-\baselineskip}\raggedright\input{#1}}}%
    \ifstrequal{#1}{}{}{\large \makebox[5mm][c]{#1}\hspace{0.5em}}
    {\color{heading}\Large\bfseries\MakeUppercase{#2}}\\[-1ex]%
    {\color{heading}\rule{\linewidth}{1.0pt}\par}\smallskip
}

% redefine subsection as bold
\renewcommand{\subsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\bfseries{#1}\par}\medskip
}

% format job/school list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set length of date/place column versus position column in fraction of linewidth before linewidth gets redefined in minipages
\newlength{\jobdateplacelength}
\newlength{\jobpositionlength}
\setlength{\jobdateplacelength}{0.4\linewidth}
\setlength{\jobpositionlength}{0.6\linewidth}
\newcommand{\job}[4]{%
    \begin{minipage}[t]{\jobdateplacelength}% minipage for left column with date/place
        \footnotesize
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line dates
            \makebox[3mm][c]{\faCalendar}
        \end{minipage}%
        \hspace{0.5em}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap date in minipage to allow multi-line dates
            #1
        \end{minipage}%
        \par
        \vspace{0.1em}
        \begin{minipage}[t]{3mm}% wrap marker in minipage to allow multi-line places
            \makebox[3mm][c]{\faMapMarker}
        \end{minipage}%
        \hspace{0.5em}%
        \begin{minipage}[t]{\dimexpr \jobdateplacelength-3mm-0.5em}% wrap place in minipage to allow multi-line places
            #2
        \end{minipage}%
    \end{minipage}%
    \begin{minipage}[t]{\jobpositionlength}% minipage for position
        {\large \color{emphasis} #3}
    \end{minipage}%
    \ifstrequal{#4}{}{}{\par \vspace{0.1em} \footnotesize #4}
    \par\normalsize
    \vspace{0.5em}
}


% skill with 5 dot bar chart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\skill}[2]{%
    \textcolor{emphasis}{\textbf{#1}}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\color{gray}}{\color{accent}}\faCircle}}\par%
}

% skill without any charts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\simpleskill}[1]{%
    \textcolor{emphasis}{\textbf{#1}}\par%
}

% sectioning of skills
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\skillsection}[1]{%
    \textit{\color{accent}#1}\par
}

% tag (framed word or phrase)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% adapted from AltaCV: https://github.com/liantze/AltaCV
\newcommand{\tag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

% wheel chart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% adapted from AltaCV: https://github.com/liantze/AltaCV
\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}

      % Rotate so we start from the top
      \begin{scope}[rotate=\totalrot]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\name};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}

% publication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand*{\ADS}[1]{\textcolor{awesome-skyblue}{\href{#1}{ADS}}}
\newcommand*{\arXiv}[1]{\textcolor{awesome-skyblue}{\href{#1}{arXiv}}}

\newlength{\pubdatelength}
\newlength{\pubjournallength}
\newlength{\publinklength}

% Spacings work erratically. Setting a highlight bar or not redefines \linewidth in a weird way which breaks the spacing and introduces line breaks. I have no idea what exactly causes this problem.

% helper function to set spacings that work empirically
\newcommand{\pubdefaultspacing}{%
    \setlength{\pubdatelength}{0.15\linewidth}
    \setlength{\pubjournallength}{0.65\linewidth}
    \setlength{\publinklength}{0.20\linewidth}
}

% helper function to force the publication to use the full width in normal page styles without highlight bar or header
\newcommand{\pubforcefullwidth}{%
    \setlength{\pubdatelength}{0.1\textwidth}
    \setlength{\pubjournallength}{0.8\textwidth}
    \setlength{\publinklength}{0.1\textwidth}
}

% \pubforcefullwidth
\pubdefaultspacing

\newcommand{\publication}[5]{%
    {\normalsize \color{emphasis}#1\par}
    \vspace{0.1em}%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faGroup}
    \end{minipage}%
    \hspace{0.5em}%
    \begin{minipage}[t]{\dimexpr \linewidth-3mm-0.5em}%
        {\footnotesize #2\par}
    \end{minipage}%
    \par%
    \vspace{0.25em}%
    \ifstrequal{#4}{}{%
        \begin{minipage}[t]{\dimexpr \pubdatelength+\pubjournallength-1.0em}%
            \footnotesize \makebox[3mm][c]{\faCalendar} \hspace{0.25em} #3
        \end{minipage}%
    }{%
        \begin{minipage}[t]{\dimexpr \pubdatelength-1.0em}%
            \footnotesize \makebox[3mm][c]{\faCalendar} \hspace{0.25em} #3
        \end{minipage}%
    }%
    \hspace{1.0em}
    \begin{minipage}[t]{\dimexpr \pubjournallength-1.0em}%
        \ifstrequal{#4}{}{}{%
            \begin{minipage}[t]{3mm}%
                \makebox[3mm][c]{\footnotesize \faBook}
            \end{minipage}%
            \hspace{0.5em}%
            \begin{minipage}[t]{\dimexpr \linewidth-3mm-0.25em}%
                {\footnotesize #4\par}
            \end{minipage}%
        }%
    \end{minipage}%
    \hspace{1.0em}
    \begin{minipage}[t]{\publinklength}%
        \ifstrequal{#5}{}{}{%
            \footnotesize \makebox[3mm][c]{\faChain} \hspace{0.25em} #5\par
        }%
    \end{minipage}%
    \par\normalsize
    \vspace{1.0em}
}

% achievement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\achievement}[1]{%
    \begin{minipage}[t]{3mm}%
        \makebox[3mm][c]{\footnotesize \faTrophy}
    \end{minipage}%
    \hspace{0.5em}%
    \begin{minipage}[t]{\dimexpr \textwidth-0.5em-3mm}%
        {\normalsize #1\par}
    \end{minipage}%
    \par
    \vspace{0.5em}
}

% lists
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=1em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FINAL FORMATTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\pagestyle{headerhighlightmain}
\RequirePackage{hyperref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  THE END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
