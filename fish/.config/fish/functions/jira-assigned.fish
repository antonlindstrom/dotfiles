function jira-assigned -d "List Jira tickets assigned to current user and open it in browser"
	jirah mine | fzf | read -l result; and xdg-open (jirah endpoint)/browse/(echo $result | awk '{ print $1 }')
end
