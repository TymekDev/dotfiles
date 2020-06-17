:: This file should be invoked by the Command Line: cmd.exe /k aliases.bat.
@echo off

doskey cd=cd /d $*

doskey gf=git fetch $*
doskey gs=git status $*
doskey glb=git lb $*

doskey gd=git diff --color-words $*
doskey gd2=git diff $*
doskey gds=git diff --color-words --staged $*
doskey gds2=git diff --staged $*

doskey gg=git logg $*
doskey gg2=git logg2 $*
doskey ggs=git loggs $*
doskey ggs2=git loggs2 $*

set PROMPT=$E[1m$E[33m[$T$H$H$H]$S$E[32m$P$G$S$E[0m
