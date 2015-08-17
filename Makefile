all:
	cp -a ./bash_profile ~/.bash_profile
	cp -a ./bash_aliases ~/.bash_aliases
	cp -a ./gitconfig ~/.gitconfig
	cp -a ./tmux.conf ~/.tmux.conf

system:
	bash bootstrap/docker.bash
	bash bootstrap/install_golang.bash
	bash bootstrap/install_golang_utils.bash

destroy:
	rm ~/.bash_profile
	rm ~/.bash_aliases
	rm ~/.gitconfig
	rm ~/.tmux_conf
