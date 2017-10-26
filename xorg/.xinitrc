setxkbmap se
setxkbmap -option caps:escape

export PATH=$PATH:$HOME/.local/bin
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

autorandr -c
xautolock -time 10 -locker slock -secure &

exec xmonad
