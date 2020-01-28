# Defined in - @ line 0
function f --description 'interactive foreground'
	fg %(jobs | fzf | awk '{print $1}')
end
