setxkbmap se

export PATH=$PATH:$HOME/.local/bin
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

/etc/X11/xinit/xinitrc.d/50-systemd-user.sh

autorandr -c
xcompmgr &
xautolock -time 10 -locker slock -secure &

feh --bg-center $(cat ${HOME}/.desktopbg) &
export BROWSER=$(which qutebrowser)

exec xmonad
