SHELL = /bin/sh

BREW = ${BREW_BIN}/brew
BREW_BIN = /opt/homebrew/bin
BREW_CASKS = 1password \
						 brave-browser \
						 discord \
						 docker \
						 font-jetbrains-mono-nerd-font \
						 gimp \
						 karabiner-elements \
						 kitty \
						 obs \
						 raycast \
						 runelite \
						 signal \
						 slack \
						 spotify \
						 steam \
						 telegram-desktop
BREW_FORMULAE = asciinema \
								bat \
								difftastic \
								entr \
								exa \
								fd \
								fish \
								fzf \
								go \
								ijq \
								imagemagick \
								jq \
								node \
								pnpm \
								ripgrep \
								sqlite \
								stow \
								tarsnap \
								tmux \
								watch
BREW_HEAD = nvim

.PHONY: restow
restow:
	stow --restow --verbose --target ~/.config config
	stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow:
	stow --delete --verbose --target ~/.config config
	stow --delete --verbose --target ~/.local local

.PHONY: from-scratch
from-scratch: brew install
	${BREW_BIN}/fish | sudo tee -a /etc/shells
	chsh -s ${BREW_BIN}/fish

.PHONY: brew
brew:
	[ -x ${BREW} ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	${BREW} tap homebrew/cask-fonts

.PHONY: install
install: ${BREW_FORMULAE} ${BREW_CASKS}

.PHONY: ${BREW_CASKS}
${BREW_CASKS}: brew
	${BREW} install --cask $@

.PHONY: ${BREW_FORMULAE}
${BREW_FORMULAE}: brew
	${BREW} install $@

.PHONY: ${BREW_HEAD}
${BREW_HEAD}: brew
	${BREW} install --HEAD $@
