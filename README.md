# dotfiles

This repository contains all the configuration files I use. These files contain
little to no explaination what they actually configure but still might be of use
for someone.

Suggested way of cloning this repository:
```
git clone --recurse-submodules --remote-submodules git@github.com:tmakowski/dotfiles
```

If you want to avoid copying, then run `eval "$(bat -r start:end README.md)"`
replacing `start` and `end` with line numbers of the section you want to run.

## Ubuntu
<details>
<summary><strong>Packages Installation</strong></summary>
<pre><code>sudo apt update
sudo apt install -y \
  asciinema \
  autorandr \
  bat \
  blueman \
  build-essential \
  ctags \
  curl \
  discord \
  entr \
  feh \
  firefox \
  flameshot \
  fzf \
  gimp \
  git \
  htop \
  hugo \
  i3 \
  i3status \
  jq \
  kazam \
  kitty \
  moreutils \
  mpv \
  ncdu \
  pandoc \
  pavucontrol \
  python3 \
  ripgrep \
  rofi \
  sqlite3 \
  steam \
  telegram-desktop \
  tree \
  unzip \
  vim-gtk \
  wine-stable \
  zip \
  zsh
python3 -m pip install \
  Commitizen \
  i3-workspace-names-daemon
</code></pre>
</details>

### Source and .deb Packages Installation</strong></summary>
```
# delta
curl -LO https://github.com/dandavison/delta/releases/download/0.8.2/git-delta_0.8.2_amd64.deb
sudo apt install ./git-delta_0.8.2_amd64.deb && rm git-delta_0.8.2_amd64.deb

# Universal ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install && cd .. && rm -rf ctags

# Go
curl -LO https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
rm go1.17.2.linux-amd64.tar.gz

# R and radian | Expect installing additional libs
curl -LO https://cran.r-project.org/src/base/R-4/R-4.1.0.tar.gz
tar xzf R-4.1.0.tar.gz
cd R-4.1.0
./configure --enable-R-shlib --enable-BLAS-shlib --enable-R-static-lib
make
sudo make install && cd .. && rm -r R-4.1.0 R-4.1.0.tar.gz
python3 -m pip install radian
```

### Fonts and Styling
```
# JetBrains Mono
curl -LO https://github.com/JetBrains/JetBrainsMono/releases/download/v2.225/JetBrainsMono-2.225.zip
unzip -d ~/.local/share JetBrainsMono-2.225.zip && rm JetBrainsMono-2.225.zip
fc-cache -f -v

# Rofi theme
mkdir -p ~/.local/share/rofi/themes
curl -Lso ~/.local/share/rofi/themes/slate.rasi https://raw.githubusercontent.com/davatorium/rofi-themes/c16c7e91a313e4f325d631832381f628778feea1/User%20Themes/slate.rasi
```

### `betterlockscreen`
<details>
<summary><strong>Build and configure</strong></summary>
<pre><code>sudo apt install -y \
  autoconf \
  gcc \
  make \
  pkg-config \
  libpam0g-dev \
  libcairo2-dev \
  libfontconfig1-dev \
  libxcb-composite0-dev \
  libev-dev \
  libx11-xcb-dev \
  libxcb-xkb-dev \
  libxcb-xinerama0-dev \
  libxcb-randr0-dev \
  libxcb-image0-dev \
  libxcb-util-dev \
  libxcb-xrm-dev \
  libxcb-xtest0-dev \
  libxkbcommon-dev \
  libxkbcommon-x11-dev \
  libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color
cd i3lock-color
./install-i3lock-color.sh && cd .. && rm -rf i3lock-color
git clone https://github.com/betterlockscreen/betterlockscreen
cd betterlockscreen
./install.sh && cd .. && rm -rf i3lock-color
betterlockscreen -u ~/.wallpaper --fx dimblur
</code></pre>
</details>

Additionally:
* Place your wallpaper under `~/.wallpaper` for `.fehbg` to work
* Hide `flameshot` system tray icon and make it run on start-up

## Termux
Download and install [F-Droid](https://f-droid.org/) and then install
[Termux](https://f-droid.org/packages/com.termux/) via F-Droid.

<details>
<summary><strong>Packages Installation</strong></summary>
<pre><code>pkg install \
  asciinema \
  bat \
  build-essential \
  ctags \
  curl \
  entr \
  fzf \
  git \
  git-delta \
  golang \
  hugo \
  jq \
  moreutils \
  openssh \
  ripgrep \
  sqlite3 \
  tree \
  unzip \
  vim \
  zsh
</code></pre>
</details>

### Styling
Install [Termux:Styling](https://f-droid.org/packages/com.termux.styling/),
then set theme and font.

### Enabling Storage
Run `termux-setup-storage` and grant permissions to Termux app.

## Common
### Vim Plugins and oh-my-zsh
```
# oh-my-zsh
# Vim Plugins
vim +PluginInstall +GoInstallBinaries +qa

sh -c "$(curl -Lo- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/Aloxaf/fzf-tab ~ZSH_CUSTOM/plugins/fzf-tab
rm ~/.zshrc
```

### Symlink Config Files
```
printf ".config\0.vim" \
  | xargs -0 -I dir \
      xargs -n 1 bash -c "ls -A dir | xargs -n 1 -I {} ./symlink_config.sh dir/{} $HOME/dir"

printf ".git-template\0.gitconfig\0.gitconfig.private\0.vimrc\0.zshrc" \
  | xargs -0 -I {} \
      ./symlink_config.sh {} $HOME
```
