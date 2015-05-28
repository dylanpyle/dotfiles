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
setopt inc_append_history
setopt share_history
alias ls='ls -1FG'
alias v='vim'
alias g='git'
alias o='open'
alias f='git grep -in'
alias fuck='sudo'
alias serve='python -m SimpleHTTPServer'

function tabname() {
  echo -ne "\033]0;"$@"\007"
}

function chpwd() {
  emulate -L zsh
  tabname `pwd | awk -F\/ '{print $(NF)}'`
}

chpwd

PROMPT='%{$fg[white]%}%~%{$fg[blue]%} λ %{$reset_color%}'
RPS1='%{$fg[blue]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null) %{$fg[black]%}%D{%H:%M}%{$reset_color%}'

TMOUT=1

TRAPALRM() {
  zle reset-prompt
}

export PATH=/opt/boxen/homebrew/bin:$PATH
export PATH=/opt/boxen/heroku/bin:bin:$PATH

alias center="sed  -e :a -e 's/^.\{1,'`expr $COLUMNS - 1`'\}$/ & /;ta'"

export EDITOR='vim'

alias POST='curl -X POST -H "Content-Type: application/json" '
alias GET='curl -X GET '
alias PUT='curl -X PUT -H "Content-Type: application/json" '
alias PATCH='curl -X PATCH -H "Content-Type: application/json" '
alias DELETE='curl -X DELETE '

bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

source ~/.shypsetup
