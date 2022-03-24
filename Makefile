all:
	stow --restow --verbose --target ~/.config config
	stow --restow --verbose --target ~/.local local
