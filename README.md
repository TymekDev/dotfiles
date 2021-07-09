## dotfiles

This repository contains all the configuration files I use. These files contain
little to no explaination what they actually configure but still might be of use
for someone.


### Installation
#### Symlink Config Files
```
printf ".config\0.vim" \
  | xargs -d ' ' -I dir \
      xargs -n 1 bash -c "ls -A dir | xargs -n 1 -I {} ./symlink_config.sh dir/{} $HOME/dir"

printf ".gitconfig\0.gitconfig.private\0.vimrc\0.zshrc" \
  | xargs -0 -I {} \
      ./symlink_config.sh {} $HOME
```

#### Install dependencies
TODO
