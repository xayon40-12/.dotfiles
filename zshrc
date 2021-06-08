#!/bin/zsh

if [[ "$(tty)" =~ "^/dev/tty(1|2)$" ]]; then
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
export PS1=$'%F{cyan}%n%f@%F{green}%M%f:%F{yellow}%~%F{blue}$(parse_git_branch)%f\n %(?..%F{red}\a)%#%f '
export RPS1='%F{magenta}$(vi_mode_prompt_info)%f'

# ************************ USR CONFIG ************************


# poweroff
alias pf="sudo poweroff"

# editors
alias se='sudoedit'
alias v='vim'
export EDITOR=vim #'emacsclient -t -a ""'
alias e=$EDITOR
ew() {emacsclient -c -a "" $* & disown}

# config files
alias vimrc="$EDITOR ~/.vim/vimrc"
alias zshrc="$EDITOR ~/.zshrc"
alias kakrc="$EDITOR ~/.config/kak/kakrc"
alias zshlocal="$EDITOR ~/.zsh_local"

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
export PATH="$HOME/.local/bin:$PATH"
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
for d in d p x y z w dl; do
    alias $d="cd ~/$d"
done

#ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

#bashtop
alias top='$(command -v bashtop || command -v htop || command -v top)'

#notes
function n() { 
    typeset -u file
    if [[ -z $1 ]]; then
        file=todo
    else 
        file=$1
    fi
    [[ $(vim --serverlist) =~ "$file" ]] && vim --servername "$file" --remote-expr 'execute("wq")'
    exec vim --servername "$file" "$HOME/n/$file.md" 
}
alias nl="ls $HOME/n/"

#regex search
regex () {
	awk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}'
}

#haskell
alias agda='stack exec agda --'
alias ghc='stack ghc'
alias rghc='stack runghc'
alias ghciconf='kak ~/.ghc/ghci.conf'
alias ghci='stack ghci +RTS -M8192M -c30 -RTS'
alias hswatch="find . -name '*.hs' | entr -rc stack run"
alias hswatchtest="find . -name '*.hs' | entr -rc stack test"
alias hs="ptghci"

#headset
alias bc='bluetoothctl connect 4C:87:5D:A2:57:A9'

#update pacman mirror list
alias pacmirror='sudo reflector --verbose --country 'France' -l 5 -p http --sort rate --save /etc/pacman.d/mirrorlist'

if [ -e /home/xayon/.nix-profile/etc/profile.d/nix.sh ]; then . /home/xayon/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

#latex
alias mkak='kak **/main.tex'

#terminal program alias
alias ls='$(if [[ "$(which exa)" =~ "exa not found" ]]; then echo "ls"; else echo "exa -la"; fi)'

#dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# add doom emacs to path
if [ -d "$HOME/.emacs.d/bin" ]; then
    export PATH="$PATH:$HOME/.emacs.d/bin"
fi











#WARING must stay at the end
#starship prompt
eval "$(starship init zsh)"
