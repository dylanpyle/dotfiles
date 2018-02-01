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
  alias ls='ls -G'
  alias ll='ls -aGlh'
else
  alias ls='ls --color'
  alias ll='ls --color -alh'
fi

alias v='vim'
alias g='git'
alias m='make'
alias o='open'
alias h='heroku'
alias f='git grep -Iin'
alias serve='python -m SimpleHTTPServer'
alias tmux='TERM=screen-256color-bce tmux'
alias uuid='node -e "console.log(require(\"node-uuid\").v4())"'
alias whereami='pwd'
alias note='(echo && date && cat) >> ~/notes.txt'
alias bell="echo -ne '\007'"
alias pg='pgcli --less-chatty'

alias cpost='curl -sX POST -H "Content-Type: application/json" '
alias cget='curl -sX GET '
alias cput='curl -sX PUT -H "Content-Type: application/json" '
alias cpatch='curl -sX PATCH -H "Content-Type: application/json" '
alias cdelete='curl -sX DELETE '

grb() {
  git rebase -i HEAD~$1
}

# Stage only all pending deletions
stagerm() {
  git ls-files --deleted -z | xargs -0 git rm
}

miracle() {
  git fsck --unreachable | grep commit | cut -d ' ' -f3 | xargs git show
}

# Create a new branch off the latest master changes
gnb() (
  set -e
  git co master
  git pull
  git co -b $1
)

alias gpull='git pull --ff-only'
alias gpush='git push -u'

# Merge in latest master changes
gup() (
  set -e
  git co master
  gpull
  git co -
  git merge master
)

gpr() {
  gpush
  hub pull-request -b master -o
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
    echo '●'
  fi
}

get_branch_name() {
  local name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ $name != '' ]]; then
    echo $name' '
  fi
}

replace() {
  git grep -l $1 | xargs sed -i '' -e "s/$1/$2/g"
}

local cwd='%{$fg[white]%}%~'
local current_branch='%{$fg[black]%}$(get_branch_name)$(get_branch_status)'
local current_host='%{$fg[black]%}$HOST:'
local prompt_color='%(?.%{$fg[blue]%}.%{$fg[red]%})'
PROMPT=$current_host' '$cwd' '$current_branch'
'$prompt_color'▸ '%{$reset_color%}

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH=~/Library/Python/3.6/bin:$PATH

export EDITOR='vim'

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export GPG_TTY=$(tty)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
