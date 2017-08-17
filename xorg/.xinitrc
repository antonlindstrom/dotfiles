setxkbmap se

export PATH=$PATH:$HOME/.local/bin

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

autorandr -c
xcompmgr &

feh --bg-center $(cat ${HOME}/.desktopbg) &

exec xmonad
