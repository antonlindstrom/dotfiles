# Defined in - @ line 0
function find-email --description 'Use notmuch to get an email'
	notmuch search $argv | fzf --preview 'notmuch show --format=json {1} | fmt-email'
end
