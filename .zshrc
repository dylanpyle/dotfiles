autoload -U colors && colors
autoload -U compinit && compinit

HISTSIZE=100000
SAVEHIST=100000
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
  alias ls='ls -G1'
  alias ll='ls -aGlh'
else
  alias ls='ls --color'
  alias ll='ls --color -alh'
fi

alias v='nvim'
alias vim='nvim'
alias g='git'
alias o='open'
alias f='git grep -Iin'
alias ff="ggrep -IER --color --exclude-dir 'node_modules' --exclude-dir '.*'"
alias fff='mdfind -onlyin .'
alias serve='python -m SimpleHTTPServer'
alias tmux='TERM=screen-256color-bce tmux'
alias note='(echo && date && cat) >> ~/notes.txt'
alias bell="echo -ne '\007'"
alias pg='pgcli --less-chatty'

alias pg_stg='pg $(security find-generic-password -a $USER -s staging-db-string -w)'
alias pg_prod='pg $(security find-generic-password -a $USER -s production-readonly-db-string -w)'
alias pg_dangerous_production='pg $(security find-generic-password -a $USER -s production-db-string -w)'

alias cpost='curl -sX POST -H "Content-Type: application/json" '
alias cget='curl -sX GET '
alias cput='curl -sX PUT -H "Content-Type: application/json" '
alias cpatch='curl -sX PATCH -H "Content-Type: application/json" '
alias cdelete='curl -sX DELETE '

grb() {
  git rebase -i HEAD~$1
}

# Create a new branch off the latest main changes
gnb() (
  set -e
  git co main
  git pull
  git co -b $1
)

alias gpull='git pull --ff-only'
alias gpush='git push -u'

# Merge in latest main changes
gup() (
  set -e
  git co main
  gpull
  git co -
  git merge main
)

gpullo() {
  git pull origin $(get_branch_name) --set-upstream
}

gpr() {
  if [[ $(get_branch_name) == "main " ]]; then
    echo 'Cannot PR from main branch'
    exit 1
  fi

  gpush
  hub pull-request -o "$@" -b main
}

tabname() {
  echo -ne "\033]0;"$@"\007"
}

chpwd() {
  emulate -L zsh
  tabname `pwd | awk -F\/ '{print $(NF)}'`
}

chpwd

# Print a newline before each prompt except the first one.
cntr=1

precmd() {
  if [[ $cntr -gt 1 ]]; then
    echo '';
  fi
  ((cntr = cntr + 1))
}

get_branch_status() {
  if [[ $(git status --porcelain 2> /dev/null) != "" ]]; then
    echo '•'
  fi
}

get_branch_name() {
  local name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ $name != '' ]]; then
    echo '@'$name' '
  fi
}

replace() {
  git grep -l $1 | xargs sed -i '' -e "s/$1/$2/g"
}

local cwd='%{$fg[black]%}%~'
local current_branch='%{$fg[black]%}$(get_branch_name)$(get_branch_status)'
local prompt_color='%(?.%{$fg[green]%}.%{$fg[red]%})'
PROMPT=$cwd' '$current_branch'
'$prompt_color'→ '%{$reset_color%}

export DENO_INSTALL="/Users/dylan/.deno"

export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export PATH=~/.fastlane/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH
export PATH=/usr/local/texlive/2017basic/bin/x86_64-darwin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/Users/dylan/n/bin:$PATH"

export EDITOR='nvim'

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

export GPG_TTY=$(tty)

source ~/.env.private

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -e /Users/dylan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/dylan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export N_PREFIX='/Users/dylan/n'
