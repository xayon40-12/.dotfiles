if [[ "$(tty)" == /dev/tty1 ]]; then
    exec startx
    exit 0
fi

if [[ -f ~/.zsh_local ]] ; then
    . ~/.zsh_local
fi

# ************************ ZSH CONFIG ************************
setopt PROMPT_SUBST

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

# color alias
alias ls="ls --color=auto"
alias grep='grep --color=auto'
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='%F{cyan}%n%f@%F{green}%M%f:%F{yellow}%~%F{blue}$(parse_git_branch)%f %(?..%F{red})%#%f '

#terminal clipboard (need to install xclip)
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"

#open files with type detection
alias open="xdg-open"
alias o='xdg-open >/dev/null 2>&1'

# rust
alias cb="cargo build"
alias cr="cargo run"
alias cbr="cargo build --release"
alias ct="RUSTFLAGS=\"$RUSTFLAGS -A dead_code\" cargo test -- --nocapture"

# utilities
export PATH=~/u:$PATH
alias dev='cd $(cat ~/.current_dev)'
alias sdev='pwd > ~/.current_dev'

#disable legacy terminal xon (ctrl-s and ctrl-q)
stty -ixon

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"
