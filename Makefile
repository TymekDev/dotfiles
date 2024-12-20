SHELL = /bin/sh

ifeq "$(shell uname -s)" "Darwin"
	BREW_DIR = /opt/homebrew
else ifeq "$(shell uname -s)" "Linux"
	BREW_DIR = /home/linuxbrew/.linuxbrew
else
	BREW_DIR = $(error operating system unsupported)
endif
BREW_BIN = ${BREW_DIR}/bin
BREW = ${BREW_BIN}/brew


.PHONY: restow
restow: install-stow
	mkdir -p ~/.config ~/.local/bin ~/.local/share ~/personal ~/work
	${BREW_BIN}/stow --restow --verbose --target ~/.config config
	${BREW_BIN}/stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow: install-stow
	${BREW_BIN}/stow --delete --verbose --target ~/.config config
	${BREW_BIN}/stow --delete --verbose --target ~/.local local

.PHONY: install-stow
install-stow:
	@[ -x ${BREW_BIN}/stow ] || ${BREW} install stow
