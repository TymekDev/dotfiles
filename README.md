## dotfiles

This repository contains all the configuration files I use. These files contain
little to no explaination what they actually configure but still might be of use
for someone.


### Installation
#### Symlink Config Files
```
printf ".config .vim" \
  | xargs -d ' ' -I dir \
    xargs -n 1 \
    bash -c "ls -A dir | xargs -n 1 -I {} ./symlink_config.sh dir/{} $HOME/dir"

printf ".gitconfig .gitconfig.private .vimrc .zshrc" \
  | xargs -d ' ' -I {} \
  ./symlink_config.sh {} $HOME
```

#### Install dependencies
TODO
