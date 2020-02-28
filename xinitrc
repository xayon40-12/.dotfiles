if [ -f $HOME/.Xresources_local ]; then
    cat $HOME/.Xresources > $HOME/.Xresources_loaded
    cat $HOME/.Xresources_local >> $HOME/.Xresources_loaded
    xrdb < $HOME/.Xresources_loaded;
else
    xrdb < $HOME/.Xresources
fi
feh --bg-fill $HOME/.bgw.jpg
exec i3
