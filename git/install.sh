# Linking .gitconifg file
echo -n "\e[36m[git]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/.gitconfig $HOME

# Linking .gitattributes file
echo -n "\e[36m[git]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/.gitattributes $HOME

# git configuration
git --version > /dev/null 2>&1
if [ $? -eq 0 ]; then

    # Setting global .gitattributes file
    echo -n "\e[36m[git]\e[0m \e[33msetting global .gitattributes file:\e[0m "
    git config --global core.attributesfile $HOME/.gitattributes
    echo -n "\e[92mdone\e[0m\n"

    # Updating name (only if it was provided)
    echo -n "\e[36m[git]\e[0m \e[33mprovide name (press enter to skip):\e[0m "
    read name

    echo -n "\e[36m[git]\e[0m \e[33mname update"
    if [ -z $name ]; then
        echo ": \e[94mskipped\e[0m (name not provided)"
    else
        git config --global user.name $name && echo "d: \e[92m$name\e[0m"
    fi

    # Updating email (only if it was provided)
    echo -n "\e[36m[git]\e[0m \e[33mprovide email (press enter to skip):\e[0m "
    read email

    echo -n "\e[36m[git]\e[0m \e[33memail update"
    if [ -z $email ]; then
        echo ": \e[94mskipped\e[0m (email not provided)"
    else
        git config --global user.email $email && echo "d: \e[92m$email\e[0m"
    fi

    # TODO: Saving GitHub token
else
    echo "\e[91mfailed to update name:\e[0m git installation not found"
    echo "\e[91mfailed to update email:\e[0m git installation not found"
fi
