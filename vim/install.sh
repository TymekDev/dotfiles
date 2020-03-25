# Linking .vimrc file
echo -n "\e[36m[vim]\e[0m "
script_dir=$(dirname $0)
sh $script_dir/../symlink_config.sh $script_dir/.vimrc $HOME/dotfiles

# Creating directories used in the .vimrc
vim_dirs="$HOME/.vim/tmp $HOME/.vim/bundle"
for vim_dir in $vim_dirs; do
    echo -n "\e[36m[vim]\e[0m \e[33mcreating ~/.vim subdirectories:\e[0m "
    if [ -e "$vim_dir" ]; then
        echo "\e[94mskipped\e[0m (directory already exists $vim_dir)"
    else
        mkdir -p $vim_dir
        echo "\e[92mcreated directory \e[0m ($vim_dir)"
    fi
done

# Cloning into Vundle.vim repository if git is installed
echo -n "\e[36m[vim]\e[0m \e[33mintalling Vundle:\e[0m "
vundle_dir="$HOME/.vim/bundle/Vundle.vim"

if [ -e "$vundle_dir" ]; then
    echo "\e[94mskipped\e[0m (directory already exists $vundle_dir)"
else
    git --version > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        git clone https://github.com/VundleVim/Vundle.vim $vundle_dir > /dev/null 2>&1
        echo "\e[92mVundle installed\e[0m"
    else
        echo "\e[91mfailed to clone repository:\e[0m git installation not found"
    fi
fi

# Installing plugins
echo -n "\e[36m[vim]\e[0m \e[33mintalling Vim plugins:\e[0m "
vim --version > /dev/null 2>&1
if [ $? -eq 0 ]; then
    vim +PluginInstall +qa
    echo "\e[92mplugins installed\e[0m"
else
    echo "\e[91mfailed to install plugins:\e[0m vim installation not found"
fi
