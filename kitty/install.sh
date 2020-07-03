# Linking kitty.conf file
echo -n "\e[36m[kitty]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/kitty.conf $HOME/.config/kitty

# Linking theme.conf file
echo -n "\e[36m[kitty]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/theme.conf $HOME/.config/kitty
