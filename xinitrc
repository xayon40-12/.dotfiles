xrdb -merge $HOME/.Xresources
if [ -f $HOME/.Xresources_local ]; then
    xrdb -merge $HOME/.Xresources_local
fi
feh --bg-fill $HOME/.bgw.jpg

WINIT_HIDPI_FACTOR=2 TERMINAL=alacritty exec i3
