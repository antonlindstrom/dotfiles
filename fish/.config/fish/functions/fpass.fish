function fpass -d "Fuzzy-find a Pass entry and copy the password"
	set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
	set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index +m"
	find ~/.password-store/ -name '*.gpg' | awk -v home="$HOME" '{ gsub(home"/.password-store/", "", $1); gsub(".gpg", "", $1); print $1}' | sort -ru | fzf --no-sort --tac | read -l result; and pass show --clip=1 "$result"
end
