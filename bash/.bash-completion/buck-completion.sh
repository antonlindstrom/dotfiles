# completion file for bash

_buck()
{
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local commands="prs pull-request"
	if [[ $COMP_CWORD -gt 1 ]]; then
		local lastarg="${COMP_WORDS[$COMP_CWORD-1]}"
		case "${COMP_WORDS[1]}" in
			prs)
				COMPREPLY=($(compgen -W "merge --show-message" -- ${cur}));
			;;
			pull-request)
				COMPREPLY=($(compgen -W "--title --message --base --head" -- ${cur}));
			;;
		esac
	else
		COMPREPLY+=($(compgen -W "${commands}" -- ${cur}))
	fi
}

complete -o default -F _buck buck
