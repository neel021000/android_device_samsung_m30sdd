#!/bin/bash

# Huge thnx to @astrako for his help

cd ../../..

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

FDEVICE="m30sdd"

# m30sdd specific
export TARGET_DEVICE_ALT="m30sdd"
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/13520000.ufs/by-name/recovery"
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/platform/13520000.ufs/by-name/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/platform/13520000.ufs/by-name/vendor"
export OF_AB_DEVICE=1
export OF_DISABLE_MIUI_SPECIFIC_FEATURES="1"
export OF_FLASHLIGHT_ENABLE="0"
export OF_MAINTAINER="neel0210"
export OF_SCREEN_H=2340
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_TWRP_COMPATIBILITY_MODE="1"

# R11
export FOX_R11="1"
export FOX_BUILD_TYPE="Beta"
export FOX_VERSION="R11.0"
export FOX_ADVANCED_SECURITY="1"
export OF_USE_TWRP_SAR_DETECT="1"
export OF_DISABLE_MIUI_OTA_BY_DEFAULT="1"
export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"

# Common
export TARGET_ARCH=arm64
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"
export PLATFORM_VERSION="16.1.0"
export PLATFORM_SECURITY_PATCH="2099-12-31"
export TW_DEFAULT_LANGUAGE="en"
export OF_KEEP_FORCED_ENCRYPTION="1"
export OF_PATCH_AVB20="1"
export OF_USE_MAGISKBOOT="1"
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
export FOX_USE_LZMA_COMPRESSION="1"
export LZMA_RAMDISK_TARGETS="recovery"

export FOX_USE_BASH_SHELL="1"
export FOX_ASH_IS_BASH="1"
export FOX_USE_NANO_EDITOR="1"
export FOX_USE_TAR_BINARY="1"
export FOX_USE_ZIP_BINARY="1"
export FOX_REPLACE_BUSYBOX_PS="1"
export OF_USE_NEW_MAGISKBOOT="1"
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"

# use system (ROM) fingerprint where available
export OF_USE_SYSTEM_FINGERPRINT="1"

# OTA for custom ROMs
#export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES="1"
#export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR="1"

add_lunch_combo omni_m30sdd-eng
source build/envsetup.sh
lunch omni_m30sdd-eng
mka recoveryimage
