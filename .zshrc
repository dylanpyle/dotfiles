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
alias ls='ls -G'
alias ll='ls -aGl'
alias v='nvim'
alias vim='nvim'
alias g='git'
alias o='open'
alias h='heroku'
alias f='git grep -in'
alias serve='python -m SimpleHTTPServer'

function rb() {
  git rebase -i HEAD~$1
}

function tabname() {
  echo -ne "\033]0;"$@"\007"
}

function chpwd() {
  emulate -L zsh
  tabname `pwd | awk -F\/ '{print $(NF)}'`
}

# Print a newline before each prompt except the first one.
export cntr=1

function precmd() {
  if [[ $cntr -gt 1 ]]; then
    echo '';
  fi
  ((cntr = cntr + 1))
}

chpwd

function branchstatus() {
  if [[ $(git status --porcelain 2> /dev/null) != "" ]]; then
    echo '●'
  fi
}

function branchname() {
  local NAME=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ $NAME != '' ]]; then
    echo $NAME' '
  fi
}

local BRANCH='%{$fg[black]%}$(branchname)$(branchstatus)'
local TIME='%{$fg[black]%}%D{%H:%M}'
local CWD='%{$fg[white]%}%~'
PROMPT=$TIME' '$CWD' '$BRANCH'
%{$fg[blue]%}λ %{$reset_color%}'

TMOUT=20

TRAPALRM() {
  zle reset-prompt
}

export PATH=/opt/boxen/homebrew/bin:$PATH
export PATH=/opt/boxen/heroku/bin:bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

alias center="sed  -e :a -e 's/^.\{1,'`expr $COLUMNS - 1`'\}$/ & /;ta'"

export EDITOR='nvim'

alias POST='curl -sX POST -H "Content-Type: application/json" '
alias GET='curl -sX GET '
alias PUT='curl -sX PUT -H "Content-Type: application/json" '
alias PATCH='curl -sX PATCH -H "Content-Type: application/json" '
alias DELETE='curl -sX DELETE '

bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

source ~/.shypsetup

export NVM_DIR="/Users/dylan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Hacky nvm default. https://github.com/creationix/nvm/issues/860
export PATH=/Users/dylan/.nvm/versions/node/v4.1.2/bin/:$PATH
