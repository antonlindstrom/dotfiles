setxkbmap se

export PATH=$PATH:$HOME/.local/bin

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

autorandr -c

feh --bg-center $(cat ${HOME}/.desktopbg) &

devilspie -a &
xcompmgr &

exec xmonad
