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

# Useful aliases
alias ls='ls -G'
alias ll='ls -aGlh'
alias v='nvim'
alias vim='nvim'
alias g='git'
alias o='open'
alias h='heroku'
alias f='git grep -in'
alias serve='python -m SimpleHTTPServer'

alias POST='curl -sX POST -H "Content-Type: application/json" '
alias GET='curl -sX GET '
alias PUT='curl -sX PUT -H "Content-Type: application/json" '
alias PATCH='curl -sX PATCH -H "Content-Type: application/json" '
alias DELETE='curl -sX DELETE '

function rb() {
  git rebase -i HEAD~$1
}

# Stage only all pending deletions
function stagerm() {
  git ls-files --deleted -z | xargs -0 git rm 
}

function miracle() {
  git fsck --unreachable | grep commit | cut -d ' ' -f3 | xargs git show
}

function gpull() {
  local BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
  git pull origin $BRANCH
}
alias gp='pull'

function gpush() {
  local BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
  git push origin $BRANCH
}

function gup() {
  git co develop
  gpull
  git co -
  git merge develop
}

function gpr() {
  hub pull-request -b develop
}

function tabname() {
  echo -ne "\033]0;"$@"\007"
}

function chpwd() {
  emulate -L zsh
  tabname `pwd | awk -F\/ '{print $(NF)}'`
}
chpwd

# Print a newline before each prompt except the first one.
export cntr=1

function precmd() {
  if [[ $cntr -gt 1 ]]; then
    echo '';
  fi
  ((cntr = cntr + 1))
}

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
local COLOREDPROMPT='%(?.%{$fg[blue]%}.%{$fg[red]%})'
PROMPT=$TIME' '$CWD' '$BRANCH'
'$COLOREDPROMPT'λ '%{$reset_color%}

TMOUT=20

TRAPALRM() {
  zle reset-prompt
}

export PATH=/opt/boxen/homebrew/bin:$PATH
export PATH=/opt/boxen/heroku/bin:bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=./bin:~/bin:$PATH
export GOPATH=~/golang

export EDITOR='nvim'

bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

source ~/.shypsetup 2> /dev/null

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
