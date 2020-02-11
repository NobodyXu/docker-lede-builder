FROM debian:buster

# Install apt-fast to speed up downloading packages
ADD apt-fast/* /tmp/
RUN /tmp/install_apt-fast.sh

# Install basic utilities
RUN apt-fast update && apt-fast install -y time curl wget git subversion ca-certificates

# Install build tools
RUN apt-fast update && \
    apt-fast install -y build-essential asciidoc binutils bzip2 gawk gettext libncurses5-dev libz-dev \
                        patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 flex uglifyjs gcc-multilib p7zip \
                        p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev \
                        autoconf automake libtool autopoint device-tree-compiler

RUN /tmp/remove_apt-fast.sh

# Clean /tmp, cache of downloaded packages and apt indexes
RUN rm /tmp/* && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user as lede cannot be built as root
RUN useradd -m user

# Add build.sh for building with ease
ADD build.sh /usr/local/bin/

USER user
WORKDIR /home/user
