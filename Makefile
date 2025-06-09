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

BREW_ESSENTIALS=bat \
								bob \
								difftastic \
								eza \
								fd \
								fish \
								fzf \
								git-absorb \
								ijq \
								jq \
								ripgrep \
								starship \
								stow \
								tmux
INSTALL_BREW_ESSENTIALS=$(addprefix install-,${BREW_ESSENTIALS})

.PHONY: restow
restow: install-stow
	mkdir -p ~/.config ~/.local/bin ~/.local/share ~/personal ~/work
	${BREW_BIN}/stow --restow --verbose --target ~/.config config
	${BREW_BIN}/stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow: install-stow
	${BREW_BIN}/stow --delete --verbose --target ~/.config config
	${BREW_BIN}/stow --delete --verbose --target ~/.local local

.PHONY: ${INSTALL_BREW_ESSENTIALS}
${INSTALL_BREW_ESSENTIALS}:
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install $(subst install-,,$@)

.PHONY: setup-gh-codespace
setup-gh-codespace: restow setup-terminfo ${INSTALL_BREW_ESSENTIALS}
	echo "${BREW_BIN}/fish" | sudo tee -a /etc/shells
	chsh -s "${BREW_BIN}/fish"
	${BREW_BIN}/bob use stable

.PHONY: setup-terminfo
setup-terminfo:
	tempfile=$$(mktemp) \
		&& curl -o $$tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
		&& tic -x -o ~/.terminfo $$tempfile \
		&& rm $$tempfile
