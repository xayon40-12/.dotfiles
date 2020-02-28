xrdb < $HOME/.Xresources
if [ -f $HOME/.Xresources_local ]; then xrdb < $HOME/.Xresources; fi
feh --bg-fill $HOME/.bgw.jpg
exec i3
