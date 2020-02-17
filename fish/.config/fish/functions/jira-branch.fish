function jira-branch -d "List Jira tickets assigned to current user and checkout a branch with a specified name"
	jirah current  | fzf | read -l result; git checkout -b ftr/(echo $result | awk '{ print tolower($1) }')
end
