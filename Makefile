COMPLETION_DIR ?= "$(HOME)/.dotfiles-completions"

GHQ_COMPLETION_URL = "https://raw.githubusercontent.com/tokubass/ghq-bash-completion/master/.ghq-completion.bash"

all:
	cp -a ./bash_profile ~/.bash_profile
	cp -a ./bash_aliases ~/.bash_aliases
	cp -a ./gitconfig ~/.gitconfig
	cp -a ./tmux.conf ~/.tmux.conf

completions:
	mkdir -p $(COMPLETION_DIR)
	cp -a ghq-completion.bash $(COMPLETION_DIR)/
	sed -i .bak 's:"__nodir__":$(COMPLETION_DIR):' $(HOME)/.bash_profile

ghq-completion.bash:
	wget -O ghq-completion.bash $(GHQ_COMPLETION_URL)

system:
	bash bootstrap/docker.bash
	bash bootstrap/install_golang.bash
	bash bootstrap/install_golang_utils.bash

destroy:
	rm ~/.bash_profile
	rm ~/.bash_aliases
	rm ~/.gitconfig
	rm ~/.tmux_conf
