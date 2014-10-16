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

PROMPT='%{$fg[cyan]%}%m:%{$fg[yellow]%}%~%{$fg[cyan]%} $ %{$reset_color%}'
RPS1='%{$fg[cyan]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}'

PATH=$PATH:'/opt/boxen/heroku/bin:bin:/opt/boxen/rbenv/shims:/opt/boxen/rbenv/bin:/opt/boxen/ruby-build/bin:node_modules/.bin:/opt/boxen/nodenv/shims:/opt/boxen/nodenv/bin:/opt/boxen/bin:/opt/boxen/homebrew/bin:/opt/boxen/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/opt/boxen/nodenv/versions/v0.10/bin'
PATH=$PATH:$HOME/.rvm/bin:~/.bin:/opt/rubies/2.1.2/bin

alias center="sed  -e :a -e 's/^.\{1,'`expr $COLUMNS - 1`'\}$/ & /;ta'"

export EDITOR='vim'

alias POST='curl -X POST -H "Content-Type: application/json" '
alias GET='curl -X GET '
alias PUT='curl -X PUT -H "Content-Type: application/json" '
alias PATCH='curl -X PATCH -H "Content-Type: application/json" '
alias DELETE='curl -X DELETE '

source ~/.shypsetup
