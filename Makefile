COMPLETION_DIR ?= "$(HOME)/.dotfiles-completions"

GHQ_COMPLETION_URL = "https://raw.githubusercontent.com/tokubass/ghq-bash-completion/master/.ghq-completion.bash"
HUB_COMPLETION_URL = "https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh"

.DEFAULT_GOAL := help

DESTDIR  ?= $$HOME
PKGS ?= $(sort $(filter-out _resources/, $(dir $(wildcard */))))

$(REAL_DIRS):
	@mkdir -p $@

.PHONY: dryrun
dryrun: ## Dry run installation of PKGS (all or use PKGS=package).
dryrun: dirs
	$(info ===> Install files --simulate)
	stow --simulate -t $(DESTDIR) $(subst $(comma),$(space),$(PKGS))

.PHONY: install
install: ## Install PKGS (all or use PKGS=package).
install: dirs
	$(info ===> Install files)
	stow -t $(DESTDIR) $(subst $(comma),$(space),$(PKGS))

.PHONY: uninstall
uninstall: ## Uninstall PKGS (all or use PKGS=package).
	$(info ===> Uninstall files)
	stow -Dt $(DESTDIR) $(subst $(comma),$(space),$(PKGS))

.PHONY: dirs
dirs: ## Make directories to prevent symlinking them.
dirs: $(REAL_DIRS)
	$(info ===> Make directories)

.PHONY: showpkgs
showpkgs: ## Show packages about to be installed.
	@echo $(PKGS)

.PHONY: configure
configure: ## Configure private files.
	./configure

.PHONY: help
help: ## Describe tasks.
	$(info Tasks:)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
