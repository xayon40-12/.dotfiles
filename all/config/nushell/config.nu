# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes
let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    # eg) {|| if $in { 'light_cyan' } else { 'light_gray' } }
    bool: light_cyan
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: {bg: red fg: white}
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: false
    color_config: $dark_theme
    float_precision: 3 # the precision for displaying floats in tables
    edit_mode: vi # emacs, vi
    keybindings: [
        {
            name: fuzzy_cd
            modifier: none
            keycode: char_f
            mode: vi_normal
            event: {send: executehostcommand cmd: 'cd $"(glob ** -F -e [**/Library/** **/.*/*/**] | str replace $"(pwd)/" "" | to text | fzf)"'}
        }
    ]
}

alias core-cd = cd
try { core-cd (open -r ~/.current_term_dir) }
def --env cd [dir = "~"] { core-cd $dir; pwd | save -f ~/.current_term_dir } 
alias pf = sudo poweroff
alias se = sudoedit
alias e = hx
alias zshrc = e ~/.zshrc
alias zshlocal = e ~/.zsh_local
alias o = open # >/dev/null 2>&1
alias cargogitinstall = cargo install --path (git rev-parse --show-toplevel)
def gitroot [f: closure] { core-cd (git rev-parse --show-toplevel); do $f }
alias smount = sudo mount -o $"uid=(whoami)" # -o $"gid=(whoami)"
alias sumount = sudo umount
def ssht [...args] { $env.TERM = "xterm-256color"; ssh ...$args }
alias sym = ipython -i ~/.sympy_setup_mat.py
alias bcd = builtin cd
alias n = e ~/notes/notes.md
alias td = e ~/notes/todo.md
alias ghciconf = e ~/.ghc/ghci.conf
def hswatch [] { glob **/*.{hs,cabal,yaml} | to text | entr -rc stack run }
def hswatchtest [] { glob **/*.hs | to text | entr -rc stack test }
alias hs = ptghci
alias pacmirror = sudo reflector --verbose --country $env.country -l 15 -p http --sort rate --save /etc/pacman.d/mirrorlist
def size [] { du --max-depth 1 | sort-by physical }
alias icat = kitty '+kitten' icat
def cclean [] { cargo locate-project | from json | get root | open | get package.name | xargs cargo clean -p }
alias rd = cd $"(glob ** -F | to text | fzf)" 

source ~/.nu_local.nu
