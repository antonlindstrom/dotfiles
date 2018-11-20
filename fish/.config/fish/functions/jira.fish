function jira -d "List Jira tickets assigned to current user and open it in browser"
	set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 10%
	set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index +m"
	jirah mine | fzf | read -l result; and xdg-open (jirah endpoint)/browse/(echo $result | awk '{ print $1 }')
end
