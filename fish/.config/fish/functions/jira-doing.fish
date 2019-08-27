function jira-doing -d "List Jira tickets assigned to current user and is in development and open it in browser"
	jirah current  | fzf | read -l result; and xdg-open (jirah endpoint)/browse/(echo $result | awk '{ print $1 }')
end
