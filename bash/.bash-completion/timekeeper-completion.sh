# completion file for bash

_timekeeper()
{
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local commands="in out ls import tag dashboard help"
	if [[ $COMP_CWORD -gt 1 ]]; then
		local lastarg="${COMP_WORDS[$COMP_CWORD-1]}"
		case "${COMP_WORDS[1]}" in
			in)
				COMPREPLY=($(compgen -W "--at --note --tag" -- ${cur}));
			;;
			out)
				COMPREPLY=($(compgen -W "--at --note --tag" -- ${cur}));
			;;
			ls)
				COMPREPLY=($(compgen -W "--current --day-hour-limit --format --from --stats --stats-format --tag --today --week" -- ${cur}));
			;;
			tag)
				if [[ $COMP_CWORD -le 2 ]]; then
					COMPREPLY=($(compgen -W "$(timekeeper ls --format='{{.UUID}}')" -- ${cur}));
				fi
			;;
		esac
	else
		COMPREPLY+=($(compgen -W "${commands}" -- ${cur}))
	fi
}

complete -o default -F _timekeeper timekeeper
