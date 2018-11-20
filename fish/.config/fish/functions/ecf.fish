function ecf -d "Fuzzy-find and edit updated files"
	git status | awk '/modified:/ { print $2 }' | fzf | read -l result; and nvim -p "$result"
end
