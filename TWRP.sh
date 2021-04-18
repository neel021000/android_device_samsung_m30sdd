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

mkdir twrp
cd twrp

repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

git clone https://github.com/neel0210/android_device_samsung_m30sdd.git -b 3.5.2 device/samsung/m30sdd

. build/envsetup.sh
lunch omni_m30sdd-eng
mka recoveryimage -j64
