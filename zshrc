if [[ "$(tty)" == /dev/tty1 ]]; then
    exec startx
    exit 0
fi

if [[ -f ~/.zsh_local ]] ; then
    . ~/.zsh_local
fi

# ************************ ZSH CONFIG ************************

# history
setopt PROMPT_SUBST
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt histignorealldups sharehistory

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# vim key binding
bindkey -v

# key bindings
export KEYTIMEOUT=1
#bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M viins '^R' history-incremental-pattern-search-backward
#bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M viins '^F' history-incremental-pattern-search-forward

# prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}"
}
export PS1=$'%F{cyan}%n%f@%F{green}%M%f:%F{yellow}%~%F{blue}$(parse_git_branch)%f %(?..%F{red}\a)%#%f '
export RPS1='%F{magenta}$(vi_mode_prompt_info)%f'

# ************************ USR CONFIG ************************


# poweroff
alias pf="sudo poweroff"

# editors
alias se='sudoedit'
alias v='vim'
export EDITOR='vim'

# config files
alias vimrc='vim ~/.vim/vimrc'
alias zshrc='vim ~/.zshrc'
alias zshlocal='vim ~/.zsh_local'

# color alias
alias ls="ls --color=auto"
alias grep='grep --color=auto'


#terminal clipboard (need to install xclip)
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"

#open files with type detection
alias open="xdg-open"
alias o='xdg-open >/dev/null 2>&1'

# rust
docrs() { firefox "https://docs.rs/$1" }
alias cb="cargo build"
alias cr="cargo run"
alias cbr="cargo build --release"
alias ct="RUSTFLAGS=\"$RUSTFLAGS -A dead_code\" cargo test -- --nocapture"
alias cs="cargo script"

# utilities
export PATH=~/u:$PATH
alias dev='cd $(cat ~/.current_dev)'
alias sdev='pwd > ~/.current_dev'

#disable legacy terminal xon (ctrl-s and ctrl-q)
stty -ixon

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"

# mount
alias smount='sudo mount -o gid=users,fmask=113,dmask=002'
alias sumount='sudo umount'

# ssh
alias ssht='TERM=xterm-256color ssh'

#sympy
alias sym='ipython -i ~/.sympy_setup_mat.py'
alias symphy='ipython -i ~/.sympy_setup_phy.py'

# launch neofetch when terminal start
#neofetch

#start terminal in preceding directory
function cd() {
    builtin cd $1
    pwd > ~/.current_term_dir
}
cd "$(cat ~/.current_term_dir)"
for d in d p x y z dl; do
    alias $d="cd ~/$d"
done
