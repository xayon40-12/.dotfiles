if [ "$(tty)" == /dev/tty1 ]
then
    exec startx
    exit 0
fi

if [[ -f ~/.bash_local ]] ; then
    . ~/.bash_local
fi

# poweroff
alias pf="sudo poweroff"

# vim
alias v=vim
export EDITOR=vim

# color alias
alias ls="ls --color=auto"
alias grep='grep --color=auto'
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[34m\]\$(parse_git_branch)\[\033[m\]\$ "

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

#set vi mode
#set -o vi

#disable legacy terminal xon (ctrl-s and ctrl-q)
stty -ixon

#alias to edit vimrc
alias vimrc='vim ~/.vim/vimrc'


# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"
