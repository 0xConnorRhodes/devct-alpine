FROM alpine:latest

RUN apk upgrade

# install programs
RUN apk add \
    # gen utils
    doas \
    chezmoi \
    # networking utils
    rsync \
    curl \
    # dev
    git \
    just \
    lua \
    powershell \
    nushell \
    # python
    python3 \
    py3-pip \
    # gen workflow
    unzip \
    screen \
    mosh \
    tree \
    bat \
    ripgrep \
    fzf \
    fd \
    fish \
    zoxide \
    lf \
    neovim

COPY bootstrap/* /opt/bootstrap/

#RUN adduser -D -s /usr/bin/fish connor \

RUN adduser -D -s /usr/bin/fish connor
RUN echo 'connor:pass' | chpasswd
RUN adduser connor wheel

RUN echo 'permit persist :wheel' > /etc/doas.d/doas.conf

# set run context for container
USER connor
WORKDIR /home/connor

RUN chezmoi init --apply 0xConnorRhodes || true

ENTRYPOINT ["/opt/bootstrap/entrypoint.sh"]
