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
alias f='git grep -Iin --color=auto'
alias ff="ggrep -IER --color --exclude-dir 'node_modules' --exclude-dir '.*'"
alias fff='mdfind -onlyin .'
alias serve='python3 -m http.server'
alias tmux='TERM=screen-256color-bce tmux'
alias note='(echo && date && cat) >> ~/notes.txt'
alias bell="echo -ne '\007'"
alias pg='pgcli --less-chatty'


alias cpost='curl -sX POST -H "Content-Type: application/json" '
alias cget='curl -sX GET '
alias cput='curl -sX PUT -H "Content-Type: application/json" '
alias cpatch='curl -sX PATCH -H "Content-Type: application/json" '
alias cdelete='curl -sX DELETE '

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
  git pull origin $(get_branch_name)
}

gpr() {
  if [[ $(get_branch_name) == "main " ]]; then
    echo 'Cannot PR from main branch'
    exit 1
  fi

  gpush
  gh pr create
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

print_branch_status() {
  if [[ $(git status --porcelain 2> /dev/null) != "" ]]; then
    echo '•'
  fi
}

get_branch_name() {
  local name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  echo $name
}

print_branch_name() {
  local name=$(get_branch_name)
  if [[ $name != '' ]]; then
    echo '@'$name' '
  fi
}

get_nix_status() {
  if [[ $IN_NIX_SHELL != '' ]]; then
    echo 'nix'
  fi
}

replace() {
  git grep -l $1 | xargs sed -i '' -e "s/$1/$2/g"
}

local cwd='%{$fg[black]%}%~'
local current_branch='%{$fg[black]%}$(print_branch_name)$(print_branch_status)'
local prompt_color='%(?.%{$fg[green]%}.%{$fg[red]%})'
PROMPT=$cwd' '$current_branch'
'$prompt_color'$(get_nix_status)→ '%{$reset_color%}

export DENO_INSTALL="/Users/dylan/.deno"

if [[ $IN_NIX_SHELL == '' ]]; then
  # If we're inside a nix shell, don't set certain paths that we expect that to
  # provide (e.g. findutils, node, homebrew)
  export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=/opt/homebrew/bin:$PATH
  export PATH="/Users/dylan/n/bin:$PATH"
  export PATH=~/bin:$PATH
  export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH
fi

export PATH=~/.fastlane/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH
export PATH=/usr/local/texlive/2017basic/bin/x86_64-darwin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/nix/var/nix/profiles/default/bin:$PATH"

export EDITOR='nvim'

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

export GPG_TTY=$(tty)

source ~/.env.private

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export N_PREFIX='/Users/dylan/n'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dylan/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dylan/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dylan/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dylan/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
