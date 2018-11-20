# Defined in - @ line 0
function clipit --description 'alias clipit xclip -i -selection clipboard'
	xclip -i -selection clipboard $argv;
end
