all:
	cp -a ./bash_profile ~/.bash_profile
	cp -a ./bash_aliases ~/.bash_aliases
	cp -a ./tmux.conf ~/.tmux.conf

destroy:
	rm ~/.bash_profile
	rm ~/.bash_aliases
	rm ~/.tmux_conf
