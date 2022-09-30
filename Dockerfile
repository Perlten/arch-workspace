FROM archlinux

RUN pacman -Sy
RUN pacman -S sudo --noconfirm
RUN pacman -S vi --noconfirm
RUN pacman -S vim --noconfirm
RUN pacman -S wget --noconfirm
RUN pacman -S neovim --noconfirm
RUN pacman -S git --noconfirm
RUN pacman -S ranger --noconfirm
RUN pacman -S python-pynvim --noconfirm
RUN pacman -S python-pip --noconfirm   
RUN pacman -S python-setuptools --noconfirm
RUN pacman -S nodejs --noconfirm
RUN pacman -S npm --noconfirm
RUN pacman -S unzip --noconfirm
RUN pacman -S fzf --noconfirm
RUN pacman -S ripgrep --noconfirm
RUN pacman -S htop --noconfirm
RUN pacman -S openssh --noconfirm
RUN pacman -S which --noconfirm
RUN pacman -S clang --noconfirm
RUN pacman -S make --noconfirm
RUN pacman -S cmake --noconfirm

RUN  sed -i "s|# %sudo.ALL=(ALL:ALL) ALL|%sudo ALL=(ALL:ALL) ALL|g" /etc/sudoers

RUN useradd -ms /bin/bash perlt

RUN echo 'perlt:perlt' | chpasswd

RUN groupadd sudo
RUN usermod -aG sudo perlt

USER perlt
WORKDIR /home/perlt

RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

RUN git config --global core.editor "neovim"

RUN git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
RUN git clone https://github.com/Perlten/astrovim-config.git ~/.config/nvim/lua/user

RUN nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

RUN nvim --headless -c "MasonInstall pyright" -c "qall"
RUN nvim --headless -c "MasonInstall flake8" -c "qall"
RUN nvim --headless -c "MasonInstall black" -c "qall"
RUN nvim --headless -c "MasonInstall bash-language-server" -c "qall"
RUN nvim --headless -c "MasonInstall shellcheck" -c "qall"
RUN nvim --headless -c "MasonInstall shfmt" -c "qall"

# compiles fzf for telescope error if not
RUN cd ~/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim && mkdir -p build && cd build
WORKDIR /home/perlt/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim/build
RUN cmake .. && make
RUN echo perlt | sudo -S cp libfzf.so /usr/local/lib

WORKDIR /home/perlt
