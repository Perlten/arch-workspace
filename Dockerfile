FROM alpine:latest

ARG password="perlt"
ARG username="perlt"

RUN apk update
RUN apk upgrade

RUN apk add bash
RUN apk add sudo
RUN apk add git
RUN apk add wget
RUN apk add neovim
RUN apk add build-base
RUN apk add curl

RUN adduser -S -D ${username}

RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel
RUN adduser ${username} wheel

USER ${username}
WORKDIR /home/${username}

RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

RUN mkdir ~/bin
RUN echo "export PATH="~/bin:$PATH"" >> ~/.bashrc

RUN git config --global core.editor "nvim"

WORKDIR /home/${username}