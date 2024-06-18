# FIXME: some brew formulae and/or casks have different names than binaries (nvim/neovim, rg/ripgrep)
# FIXME: some brew formulae and/or casks are not installed in ${BREW_BIN}
# FIXME: neovim does not install its plugins making tmux install jittery
# FIXME: some programs require PATH properly set up. This implies that fish should be configured earlier on
# FIXME: some directories should be created a priori, because stowing them first creates a symlink to the repo and random files appear in git status
# TODO: split off non-work programs: discord, telegram-desktop, obs, signal, tarsnap
# TODO: switch from add rig, add bob
SHELL = /bin/sh

BREW_DIR = /opt/homebrew
BREW_BIN = ${BREW_DIR}/bin
BREW = ${BREW_BIN}/brew
BREW_CASKS = 1password \
						 discord \
						 docker \
						 firefox \
						 font-jetbrains-mono-nerd-font \
						 gimp \
						 karabiner-elements \
						 linearmouse \
						 obs \
						 rectangle \
						 signal \
						 slack \
						 spotify \
						 telegram-desktop
BREW_FORMULAE = asciinema \
								bat \
								coreutils \
								curl \
								difftastic \
								entr \
								eza \
								fd \
								fish \
								go \
								gh \
								ijq \
								imagemagick \
								jq \
								moreutils \
								n \
								pnpm \
								rclone \
								ripgrep \
								starship \
								sqlite \
								stow \
								tarsnap \
								tmux \
								watch
# FIXME: I now use bob (https://github.com/MordechaiHadad/bob) for Neovim management
BREW_HEADS = neovim

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
	echo "${BREW_BIN}/fish" | sudo tee -a /etc/shells
	chsh -s ${BREW_BIN}/fish
	git remote set-url origin git@github.com:TymekDev/dotfiles

.PHONY: dotfiles
dotfiles: install-tpm restow install-neovim
	[ -n "$$TMUX" ] && ${BREW_BIN}/tmux source-file ~/.config/tmux/tmux.conf || exit 0
	~/.config/tmux/plugins/tpm/bin/install_plugins

.PHONY: install-brew
install-brew:
	[ -x ${BREW} ] || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	${BREW} tap homebrew/cask-fonts

.PHONY: install
install: ${INSTALL_CASKS} ${INSTALL_FORMULAE} ${INSTALL_HEADS} install-fzf install-rust install-tpm install-wezterm

.PHONY: ${INSTALL_CASKS} 
${INSTALL_CASKS}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install --cask $(subst install-,,$@)

.PHONY: ${INSTALL_FORMULAE}
${INSTALL_FORMULAE}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install $(subst install-,,$@)

.PHONY: ${INSTALL_HEADS}
${INSTALL_HEADS}: install-brew
	[ -x ${BREW_BIN}/$(subst install-,,$@) ] || ${BREW} install --HEAD $(subst install-,,$@)

.PHONY: install-fzf
install-fzf:
	[ -x ${BREW_BIN}/fzf ] || ${BREW} install fzf
	${BREW_DIR}/opt/fzf/install

.PHONY: install-rust
install-rust:
	[ -x $${HOME}/.cargo/bin/rustc ] || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

.PHONY: install-tpm
install-tpm: install-tmux
	mkdir -p ~/.config/tmux/plugins
	[ -e ~/.config/tmux/plugins/tpm ] || git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

.PHONY: install-wezterm
install-wezterm:
	[ -x ${BREW_BIN}/wezterm ] || ${BREW} install --cask wezterm
	tempfile=$$(mktemp) \
		&& curl -o $$tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
		&& tic -x -o ~/.terminfo $$tempfile \
		&& rm $$tempfile
