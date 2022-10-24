FROM archlinux

ARG password="perlt"
ARG username="perlt"

RUN pacman -Sy
RUN pacman -S base-devel --noconfirm
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
RUN pacman -S cmake --noconfirm
RUN pacman -S go --noconfirm
RUN pacman -S sshpass --noconfirm

RUN  sed -i "s|# %sudo.ALL=(ALL:ALL) ALL|%sudo ALL=(ALL:ALL) ALL|g" /etc/sudoers

RUN useradd -ms /bin/bash ${username}

RUN echo "${username}:${password}" | chpasswd

RUN groupadd sudo
RUN usermod -aG sudo ${username}

USER ${username}
WORKDIR /home/${username}

RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

RUN mkdir ~/bin
RUN echo "export PATH="~/bin:$PATH"" >> ~/.bashrc

RUN git config --global core.editor "nvim"

WORKDIR /home/${username}

RUN git clone https://aur.archlinux.org/yay.git && cd yay && sshpass -p ${password} makepkg -si --noconfirm
RUN git clone https://github.com/moson-mo/pacseek.git && cd pacseek && go build . && cp ./pacseek ~/bin/pacseek
