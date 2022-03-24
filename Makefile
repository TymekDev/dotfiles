all:
	stow --restow --verbose --target ~/.config config
	stow --restow --verbose --target ~/.local local
delete:
	stow --delete --verbose --target ~/.config config
	stow --delete --verbose --target ~/.local local
