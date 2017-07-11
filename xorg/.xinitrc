setxkbmap se

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

feh --bg-center /home/anton/.background/rocks_nature.jpg &

devilspie -a &
xcompmgr &
xmobar &

exec xmonad
