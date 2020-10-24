# Linking i3status config file
echo -n "\e[36m[i3status]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/config $HOME/.config/i3status
