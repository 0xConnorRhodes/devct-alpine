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
    bash \
    powershell \
    nushell \
    # python
    python3 \
    py3-pip \
    py3-jinja2 \
    ipython \
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
RUN curl -L https://psg-prod-eastus.azureedge.net/packages/packagemanagement.1.4.8.1.nupkg -o /tmp/PackageManagement.nupkg
RUN unzip -o /tmp/PackageManagement.nupkg -d /usr/local/share/powershell/Modules/PackageManagement
RUN rm /tmp/PackageManagement.nupkg
RUN curl -L https://psg-prod-eastus.azureedge.net/packages/powershellget.2.2.5.nupkg -o /tmp/PowerShellGet.nupkg
RUN unzip -o /tmp/PowerShellGet.nupkg -d /usr/local/share/powershell/Modules/PowerShellGet
RUN rm /tmp/PowerShellGet.nupkg

COPY bootstrap/* /opt/bootstrap/

RUN /opt/bootstrap/bootstrap-powershell.ps1

RUN adduser -D -s /usr/bin/fish connor
RUN echo 'connor:pass' | chpasswd
RUN adduser connor wheel

RUN echo 'permit persist :wheel' > /etc/doas.d/doas.conf

# set persistent volume permissions
RUN mkdir /out && chown -R 1000:1000 /out
RUN mkdir /persistent && chown -R 1000:1000 /persistent
RUN mkdir /home/connor/code && chown -R 1000:1000 /home/connor/code
RUN mkdir /home/connor/notes && chown -R 1000:1000 /home/connor/notes
RUN mkdir -p /home/connor/.local/share/zoxide
RUN mkdir -p /home/connor/.local/share/fish
RUN chown -R 1000:1000 /home/connor/.local 

# set run context for container
USER connor
WORKDIR /home/connor

RUN pip install \
    pyfzf \
    --break-system-packages

RUN chezmoi init --apply 0xConnorRhodes || true
RUN sed -i "s|https://github.com/0xConnorRhodes/dotfiles.git|git@github.com:0xConnorRhodes/dotfiles.git|g" "/home/connor/.local/share/chezmoi/.git/config"

ENTRYPOINT ["/opt/bootstrap/entrypoint.sh"]
