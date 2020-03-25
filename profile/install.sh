# Linking .profile file
echo -n "\e[36m[profile]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/.profile $HOME/dotfiles
