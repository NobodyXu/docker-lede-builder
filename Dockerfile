FROM debian:buster

# Install apt-fast to speed up downloading packages
## Add key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B
## Add sources.list
ADD apt-fast.list /etc/apt/sources.list.d/
## Install apt-fast non-interactively
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast
## Configure apt-fast
RUN echo debconf apt-fast/maxdownloads string  $(nproc) | debconf-set-selections
RUN echo debconf apt-fast/dlflag       boolean true     | debconf-set-selections
RUN echo debconf apt-fast/aptmanager   string  apt-get  | debconf-set-selections

# Install basic utilities
RUN apt-fast update && apt-fast install -y time curl wget git subversion ca-certificates

# Install build tools
RUN apt-fast update && \
    apt-fast install -y build-essential asciidoc binutils bzip2 gawk gettext libncurses5-dev libz-dev \
                        patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 flex uglifyjs gcc-multilib p7zip \
                        p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev \
                        autoconf automake libtool autopoint device-tree-compiler

# Purge apt-fast and its mirror
## Purge apt-fast
RUN apt-get purge -y apt-fast
## Remove sources.list
RUN rm /etc/apt/sources.list.d/apt-fast.list
## Remove key
RUN apt-key del A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B

# Clean /tmp, cache of downloaded packages and apt indexes
RUN rm /tmp/* && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user as lede cannot be built as root
RUN useradd -m user

USER user
WORKDIR /home/user

# Add update_repository.sh for convenient shallow cloning.
ADD update_repository.sh /home/user
