## dotfiles

This repository contains all the configuration files I use. These files contain
little to no explaination what they actually configure but still might be of use
for someone. 


### Structure
Each category has a separate directory with a brief `README.md` and `install.sh`
script (which basically creates symlinks to the default locations).

The `install.sh` scripts were written to not overwrite anything but I cannot
guarantee it as I am still learing shell scripting so... **use at your own
risk!**


### Installation
```
# Install all files configs
sh install_all.sh

# Installing single config
sh profile/install.sh
```
