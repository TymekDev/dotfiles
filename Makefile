SHELL = /bin/sh

.PHONY: restow
restow:
	stow --restow --verbose --target ~/.config config
	stow --restow --verbose --target ~/.local local

.PHONY: unstow
unstow:
	stow --delete --verbose --target ~/.config config
	stow --delete --verbose --target ~/.local local
