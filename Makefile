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
								gh \
								git-absorb \
								go-task/tap/go-task \
								ijq \
								jq \
								ripgrep \
								starship \
								stow \
								tmux \
								yazi

.PHONY: restow
restow: install-stow
	mkdir -p ~/.config ~/.local/bin ~/.local/share ~/.local/state/tymek-theme ~/personal ~/work
	git submodule sync
	git submodule update --init --checkout
	${BREW_BIN}/stow --restow --verbose --target ~/.config config
	${BREW_BIN}/stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow: install-stow
	${BREW_BIN}/stow --delete --verbose --target ~/.config config
	${BREW_BIN}/stow --delete --verbose --target ~/.local local

.PHONY: install-stow
install-stow:
	@[ -x ${BREW_BIN}/stow ] || ${BREW} install stow

.PHONY: install-essentials
install-essentials:
	${BREW} install ${BREW_ESSENTIALS}

.PHONY: setup-os-codespace
setup-os-codespace: restow install-essentials configure-terminfo download-rose-pine
	echo "${BREW_BIN}/fish" | sudo tee -a /etc/shells
	sudo chsh "$$(id -un)" --shell "${BREW_BIN}/fish"
	tempdir=$$(mktemp --dir) \
		&& echo "add_neovim_binary_to_path = false" > $$tempdir/config.toml \
		&& BOB_CONFIG=$$tempdir/config.toml ${BREW_BIN}/bob use stable \
		&& rm -r $$tempdir
	ln -sf request-remote-open ~/.local/bin/xdg-open
	~/.local/share/bob/nvim-bin/nvim --headless "+Lazy! restore" +qa

.PHONY: configure-terminfo
configure-terminfo:
	tempfile=$$(mktemp) \
		&& curl -o $$tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
		&& tic -x -o ~/.terminfo $$tempfile \
		&& rm $$tempfile

.PHONY: download-rose-pine
download-rose-pine:
	mkdir -p ~/.config/fish/themes/
	tempdir=$$(mktemp --dir) \
		&& git clone --depth 1 --single-branch https://github.com/rose-pine/fish $$tempdir \
		&& mv $$tempdir/themes/* ~/.config/fish/themes/ \
		&& rm -rf $$tempdir
