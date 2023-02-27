xrdb -merge $HOME/.Xresources
if [ -f $HOME/.Xresources_local ]; then
    xrdb -merge $HOME/.Xresources_local
fi
feh --bg-fill $HOME/.bgw.jpg

#uim input (for japanese)
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

export TERMINAL=kitty
#WINIT_HIDPI_FACTOR=2 TERMINAL=alacritty
exec i3
#exec emacs
