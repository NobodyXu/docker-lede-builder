FROM debian:buster

# Install basic utilities
RUN apt-get update && apt-get install -y sudo time curl wget git subversion ca-certificates

# Install build tools
RUN apt-get update && \
    apt-get install -y build-essential asciidoc binutils bzip2 gawk gettext libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 flex uglifyjs gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler

# Clean /tmp, cache of downloaded packages and apt indexes
RUN rm /tmp/* && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user as lede cannot be built as root
RUN useradd -m user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"
