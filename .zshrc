autoload -U colors && colors
autoload -U compinit && compinit

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

setopt nocorrectall # Don't correct *everything*
setopt correct # Do correct commands, but not arguments
setopt autocd
setopt auto_resume
setopt prompt_subst
setopt nobeep
alias ls='ls -lGh'

function tabname() {
  echo -ne "\033]0;"$@"\007"
}

function chpwd() {
  emulate -L zsh
  tabname `pwd | awk -F\/ '{print $(NF)}'`
}

chpwd

PROMPT='
%{$fg[cyan]%}%m:%{$fg[yellow]%}%~%{$fg[cyan]%} $ %{$reset_color%}'

PATH=$PATH:$HOME/.rvm/bin

alias center="sed  -e :a -e 's/^.\{1,'`expr $COLUMNS - 1`'\}$/ & /;ta'"
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
