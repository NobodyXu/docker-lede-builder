# Docker lede Builder, fored from mwarning/docker-openwrt-builder

Build [lede](https://github.com/coolsnowwolf/lede) images in a Docker container. This is sometimes necessary when building lede on the host system fails, e.g. when some dependency is too new, or when your computer use incompatiable toolchains like llvm.

The docker image is based on Ubuntu Linux.
Works with LEDE-17.01, OpenWrt-18.06 and newer.

A smaller container based on Alpine Linux is available in the alpine branch. But it does not build the old LEDE images.

## Prerequisites

 * Has docker/podman installed and fully configured.
 * build Docker image:

```
git clone https://github.com/mwarning/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build --squash -t lede_builder .
```

`docker` here can be replaced with `podman`.

Now the docker image is available. These steps only need to be done once.

## Usage

Create a build folder and link it into a new docker container:

```
mkdir ~/mybuild
docker run -v ~/mybuild:/home/user -it lede_builder /bin/bash
```

In the container console, enter:

```
./update_repository.sh https://github.com/coolsnowwolf/lede lede
cd lede
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j $(nproc) V=s
```

After the build, the images will be inside `~/mybuild/lede/bin/target/`.

NOTE:

`./update_repository.sh https://github.com/coolsnowwolf/lede lede` will be creating a shallow clone of the repository to save time, bandwidth and storage.

## Other Projects

Other, but very similar projects:

 * [docker-openwrt-builder](https://github.com/mwarning/docker-openwrt-docker)
 * [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
 * [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)

