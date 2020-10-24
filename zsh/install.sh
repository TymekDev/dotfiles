# Linking .zshrc file
echo -n "\e[36m[zsh]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/.zshrc $HOME
