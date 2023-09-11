# FIXME: some brew formulae and/or casks have different names than binaries (nvim/neovim, rg/ripgrep)
# FIXME: some brew formulae and/or casks are not installed in ${BREW_BIN}
# FIXME: neovim does not install its plugins making tmux install jittery
# FIXME: some programs require PATH properly set up. This implies that fish should be configured earlier on
# FIXME: some directories should be created a priori, because stowing them first creates a symlink to the repo and random files appear in git status
SHELL = /bin/sh

BREW = ${BREW_BIN}/brew
BREW_BIN = /opt/homebrew/bin
BREW_CASKS = 1password \
						 discord \
						 docker \
						 firefox \
						 font-jetbrains-mono-nerd-font \
						 gimp \
						 karabiner-elements \
						 linearmouse \
						 obs \
						 raycast \
						 runelite \
						 signal \
						 slack \
						 spotify \
						 steam \
						 telegram-desktop \
						 wezterm
BREW_FORMULAE = asciinema \
								bat \
								curl \
								difftastic \
								entr \
								exa \
								fd \
								fish \
								fzf \
								go \
								gh \
								ijq \
								imagemagick \
								jq \
								n \
								node \
								pnpm \
								ripgrep \
								sqlite \
								stow \
								tarsnap \
								tmux \
								watch
BREW_HEADS = nvim

INSTALL_CASKS = $(addprefix install-,${BREW_CASKS})
INSTALL_FORMULAE = $(addprefix install-,${BREW_FORMULAE})
INSTALL_HEADS = $(addprefix install-,${BREW_HEADS})


.PHONY: restow
restow: install-stow
	mkdir -p ~/.config ~/.local
	${BREW_BIN}/stow --restow --verbose --target ~/.config config
	${BREW_BIN}/stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow: install-stow
	${BREW_BIN}/stow --delete --verbose --target ~/.config config
	${BREW_BIN}/stow --delete --verbose --target ~/.local local

.PHONY: from-scratch
from-scratch: install dotfiles
	${BREW_BIN}/fish | sudo tee -a /etc/shells
	chsh -s ${BREW_BIN}/fish
	git remote set-url origin git@github.com:TymekDev/dotfiles

.PHONY: dotfiles
dotfiles: install-tpm restow nvim
	[ -n "$$TMUX" ] && tmux source-file ~/.config/tmux/tmux.conf
	~/.config/tmux/plugins/tpm/bin/install_plugins

.PHONY: install-brew
install-brew:
	[ -x ${BREW} ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	${BREW} tap homebrew/cask-fonts

.PHONY: install
install: ${INSTALL_CASKS} ${INSTALL_FORMULAE} ${INSTALL_HEADS} install-rust install-tpm install-wezterm

.PHONY: ${INSTALL_CASKS} 
${INSTALL_CASKS}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install --cask $(subst install-,,$@)

.PHONY: ${INSTALL_FORMULAE}
${INSTALL_FORMULAE}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install $(subst install-,,$@)

.PHONY: ${INSTALL_HEADS}
${INSTALL_HEADS}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install --HEAD $(subst install-,,$@)

.PHONY: install-rust
install-rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

.PHONY: install-tpm
install-tpm: install-tmux
	mkdir -p ~/.config/tmux/plugins
	[ -e ~/.config/tmux/plugins/tpm ] || git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

.PHONY: install-wezterm
install-wezterm:
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install --cask $(subst install-,,$@)
	tempfile=$$(mktemp) \
		&& curl -o $$tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
		&& tic -x -o ~/.terminfo $$tempfile \
		&& rm $$tempfile
