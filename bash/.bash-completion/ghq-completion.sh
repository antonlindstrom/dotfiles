# completion file for bash

_ghq()
{
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local commands="get help import list look root"
	if [[ $COMP_CWORD -gt 1 ]]; then
		local lastarg="${COMP_WORDS[$COMP_CWORD-1]}"
		case "${COMP_WORDS[1]}" in
			look)
				if [[ $COMP_CWORD -le 2 ]]; then
					COMPREPLY=($(compgen -W "$(ghq list --unique)" -- ${cur}));
				fi
			;;
		esac
	else
		COMPREPLY+=($(compgen -W "${commands}" -- ${cur}))
	fi
}

complete -o default -F _ghq ghq
