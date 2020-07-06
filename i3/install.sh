# Linking i3 config file
echo -n "\e[36m[i3]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/config $HOME/.config/i3

# Linking app-icons file
echo -n "\e[36m[i3]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/app-icons.json $HOME/.config/i3
