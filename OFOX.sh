#!/bin/bash

# Huge thnx to @astrako for his help

sudo apt-get update
          sudo DEBIAN_FRONTEND=noninteractive apt-get install \
          bison build-essential curl flex git gnupg gperf \
          liblz4-tool libncurses5-dev libsdl1.2-dev libxml2 \
          libxml2-utils lzop pngcrush schedtool \
          squashfs-tools xsltproc zip zlib1g-dev \
          build-essential kernel-package libncurses5-dev \
          bzip2 git python expect \
          gcc-aarch64-linux-gnu g++-aarch64-linux-gnu -y

curl https://raw.githubusercontent.com/akhilnarang/scripts/master/setup/android_build_env.sh | bash

mkdir ~/bin
PATH=~/bin:$PATH

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

mkdir ofox
cd ofox

repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

git clone https://github.com/neel0210/android_device_samsung_m30sdd.git -b OFOX device/samsung/m30sdd

export ALLOW_MISSING_DEPENDENCIES=true
export OF_STATUS_INDENT_LEFT="48"
export OF_STATUS_INDENT_RIGHT="48"
export TARGET_DEVICE_ALT="a50, a50dd"
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/13520000.ufs/by-name/recovery"
export FOX_REPLACE_BUSYBOX_PS="1"
export FOX_USE_BASH_SHELL="1"
export FOX_USE_LZMA_COMPRESSION="1"
export FOX_USE_NANO_EDITOR="1"
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export LC_ALL="C"
export OF_DISABLE_MIUI_SPECIFIC_FEATURES="1"
export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
export OF_MAINTAINER="Neel0210"
export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
export OF_OTA_RES_DECRYPT="1"
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
export OF_USE_NEW_MAGISKBOOT="1"
export TARGET_ARCH="arm64"
export TW_DEFAULT_LANGUAGE="en"
export FOX_VERSION="R11.0"
export FOX_R11="1"
export USE_CCACHE="1"
export OF_FLASHLIGHT_ENABLE="0"
export OF_SCREEN_H="2340"
export FOX_BUILD_TYPE="Stable"
export FOX_ADVANCED_SECURITY="1"
export LZMA_RAMDISK_TARGETS="recovery"

source build/envsetup.sh
lunch omni_m30sdd-eng
mka recoveryimage
