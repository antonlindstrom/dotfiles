COMPLETION_DIR ?= "$(HOME)/.dotfiles-completions"

GHQ_COMPLETION_URL = "https://raw.githubusercontent.com/tokubass/ghq-bash-completion/master/.ghq-completion.bash"
HUB_COMPLETION_URL = "https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh"

all:
	cp -a ./bash_profile ~/.bash_profile
	cp -a ./bash_aliases ~/.bash_aliases
	cp -a ./gitconfig ~/.gitconfig
	cp -a ./tmux.conf ~/.tmux.conf

completions: ghq-completion.bash hub.bash_completion.sh
	mkdir -p $(COMPLETION_DIR)
	cp -a ghq-completion.bash $(COMPLETION_DIR)/
	cp -a hub.bash_completion.sh $(COMPLETION_DIR)/
	sed -i .bak 's:"__nodir__":$(COMPLETION_DIR):' $(HOME)/.bash_profile

ghq-completion.bash:
	wget -O ghq-completion.bash $(GHQ_COMPLETION_URL)

hub.bash_completion.sh:
	wget -O hub.bash_completion.sh $(HUB_COMPLETION_URL)

system:
	bash bootstrap/docker.bash
	bash bootstrap/install_golang.bash
	bash bootstrap/install_golang_utils.bash

destroy:
	rm ~/.bash_profile
	rm ~/.bash_aliases
	rm ~/.gitconfig
	rm ~/.tmux_conf
