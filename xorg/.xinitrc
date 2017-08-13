setxkbmap se

export PATH=$PATH:$HOME/.local/bin

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

autorandr -c

feh --bg-center /home/anton/.background/rocks_nature.jpg &

devilspie -a &
xcompmgr &

exec xmonad
