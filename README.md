# Docker lede Builder, forked from mwarning/docker-openwrt-builder

Build [lede](https://github.com/coolsnowwolf/lede) images in a Docker container. This is sometimes necessary when building lede on the host system fails, e.g. when some dependency is too new, or when your computer use incompatiable toolchains like llvm.

The docker image is based on Ubuntu Linux.
Works with LEDE-17.01, OpenWrt-18.06 and newer.

A smaller container based on Alpine Linux is available in the alpine branch. But it does not build the old LEDE images.

## Prerequisites

 * Has docker/podman installed and fully configured.
 * build Docker image:

```
git clone --depth 1 https://github.com/mwarning/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build --squash -t lede_builder .
```

`docker` here can be replaced with `podman`.

Now the docker image is available. These steps only need to be done once.

## Usage

Create a build folder and link it into a new docker container:

```
mkdir ~/mybuild && cd ~/mybuild

git clone https://github.com/coolsnowwolf/lede

docker run -v ~/mybuild:/home/user/lede -it lede_builder
```

Now just wait until the menu (invoked by `make menuconfig`) comes out and pick whatever you like, save and exit, then the compilation will start automatically.
After the build, the images will be inside `~/mybuild/lede/bin/target/`.

*NOTE*:

`docker` here can be replaced with `podman`.

## Other Projects

Other, but very similar projects:

 * [docker-openwrt-builder](https://github.com/mwarning/docker-openwrt-docker)
 * [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
 * [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)

