set -Uq fish_setup_done
or fish_setup

eval (starship init fish)

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore vendor/ -g ""'

set -x GOPATH $HOME/code
set -x GO111MODULE on
set -x GOPROXY https://proxy.golang.org

gpg-connect-agent updatestartuptty /bye >/dev/null
