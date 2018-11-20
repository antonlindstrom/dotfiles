.DEFAULT_GOAL := help

DESTDIR  ?= $$HOME
PKGS ?= $(sort $(filter-out _resources/, $(dir $(wildcard */))))

REAL_DIRS := $(addprefix $(DESTDIR)/, .i3 .mutt .offlineimap .vim/autoload .config/termite .config/dunst .config/autorandr .config/qutebrowser .config/systemd/user/default.target.wants .config/i3 .local/bin .tmux/plugins .weechat .config/fish)

$(REAL_DIRS):
	@mkdir -p $@

.PHONY: dryrun
dryrun: ## Dry run installation of PKGS (all or use PKGS=package).
dryrun: dirs
	$(info ===> Install files --simulate)
	stow --simulate -t $(DESTDIR) $(subst $(comma),$(space),$(PKGS))

.PHONY: preinstall
preinstall: ## Preinstall target for git submodules.
	$(info ===> Update submodules)
	git submodule update --init

.PHONY: install
install: ## Install packages and run preconfiguration
install: configure dirs preinstall pkgs vimplugs

.PHONY: pkgs
pkgs: ## Install PKGS (all or use PKGS=package).
pkgs:
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

.PHONY: vimplugs
vimplugs: ## Install Vundle plugins in VIm.
	vim -c 'PlugInstall | qa'

.PHONY: restore-config-backup
restore-config-backup: ## Restore secret configuration from backup.
	restic snapshots --tag config
	@echo
	@echo "==> Restoring latest snapshot with tag 'config' to $(DESTDIR), waiting 10s to allow abort."
	sleep 10
	restic restore latest --tag config --target $(DESTDIR)

.PHONY: help
help: ## Describe tasks.
	$(info Tasks:)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
