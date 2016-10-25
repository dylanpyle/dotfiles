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

if [[ $(uname) == 'Darwin' ]]; then
  alias ls='ls -G'
  alias ll='ls -aGlh'
else
  alias ls='ls --color'
  alias ll='ls --color -alh'
fi

alias v='nvim'
alias vim='nvim'
alias g='git'
alias o='open'
alias h='heroku'
alias f='git grep -in'
alias serve='python -m SimpleHTTPServer'
alias tmux='TERM=screen-256color-bce tmux'

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

# Create a new branch off the latest master changes
gnb() (
  set -e
  git co master
  git pull
  git co -b $1
)

alias gpull='git pull'
alias sp='git pull'
alias gpush='git push -u'

gup() (
  set -e
  git co master
  gpull
  git co -
  git merge master
)

function gpr() {
  hub pull-request -b master -o
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

local CWD='%{$fg[white]%}%~'
local BRANCH='%{$fg[black]%}$(branchname)$(branchstatus)'
local CURRENTHOST='%{$fg[black]%}$HOST'
local TIME='%{$fg[black]%}%D{%H:%M}'
local COLOREDPROMPT='%(?.%{$fg[blue]%}.%{$fg[red]%})'
PROMPT=$TIME' '$CURRENTHOST' '$CWD' '$BRANCH'
'$COLOREDPROMPT'▲ '%{$reset_color%}

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

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi
export PATH=~/.themekit:$PATH
