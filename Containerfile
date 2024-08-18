FROM alpine:latest

RUN apk upgrade

# install programs
RUN apk add \
    # gen utils
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

ENTRYPOINT ["/opt/bootstrap/entrypoint.sh"]
