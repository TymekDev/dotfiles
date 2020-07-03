# Linking rc.conf file
echo -n "\e[36m[ranger]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/rc.conf $HOME/.config/ranger

# Linking rifle.conf file
echo -n "\e[36m[ranger]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/rifle.conf $HOME/.config/ranger
