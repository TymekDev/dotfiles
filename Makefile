SHELL = /bin/sh

BREW_DIR = /opt/homebrew
BREW_BIN = ${BREW_DIR}/bin
BREW = ${BREW_BIN}/brew


.PHONY: restow
restow: install-stow
	mkdir -p ~/.config ~/.local
	${BREW_BIN}/stow --restow --verbose --target ~/.config config
	${BREW_BIN}/stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow: install-stow
	${BREW_BIN}/stow --delete --verbose --target ~/.config config
	${BREW_BIN}/stow --delete --verbose --target ~/.local local

.PHONY: install-stow
install-stow:
	@[ -x ${BREW_BIN}/stow ] || ${BREW} install stow

.PHONY: bundle-check
bundle-check:
	${BREW} bundle check --verbose

.PHONY: bundle-install
bundle-install:
	${BREW} bundle install
