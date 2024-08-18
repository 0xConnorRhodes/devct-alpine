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

# PowerShell setup
RUN mkdir -p /usr/local/share/powershell/Modules

#    curl -L https://psg-prod-eastus.azureedge.net/packages/packagemanagement.1.4.8.1.nupkg -o /tmp/PackageManagement.nupkg ; \
#    unzip -o /tmp/PackageManagement.nupkg -d /usr/local/share/powershell/Modules/PackageManagement ; \
#    rm /tmp/PackageManagement.nupkg ; \
#    curl -L https://psg-prod-eastus.azureedge.net/packages/powershellget.2.2.5.nupkg -o /tmp/PowerShellGet.nupkg ; \
#    unzip -o /tmp/PowerShellGet.nupkg -d /usr/local/share/powershell/Modules/PowerShellGet ; \
#    rm /tmp/PowerShellGet.nupkg ; \

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
