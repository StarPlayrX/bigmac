#!/bin/sh

#  preinstall.sh  v0.0.5
#  Created by StarPlayrX on 7/1/20.

# Credits
# Hax.dylib by ASentientBot, see the fries 🍟 with dat folder.

cat './🎨/pre-art.ans'

mount -uw /

bootArgs=$(nvram -p | grep boot-args)

echo ""

bootArgs=$(echo $bootArgs | cut -d " " -f2-)

echo "nvram check"
echo $bootArgs

default="-no_compat_check -v"

read -p "
🖥  Set Boot Args: [enter = default]: " default

if [ "$default" != "" ]
  then
    bootArgs="$default"
fi

sudo nvram boot-args="$bootArgs"

echo "\r\nset boot args"
nvram -p | grep boot-args

echo "\r\nCheck System Integrity"
csrutil status

#csrutil authenticated-root status

## may be able to set csr programically
#nvram csr-active-config="w%08%00%00"

#./'Install macOS Beta.app/Contents/MacOS/InstallAssistant' & echo '\r\n' &

echo "\r\nDisabling Library Validation"
defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

echo "\r\nLoading Hax into Memory"
hax="/🍟/Hax.dylib"
sudo -u $SUDO_USER launchctl setenv DYLD_INSERT_LIBRARIES $(pwd)$hax

echo $(pwd)$hax
echo ""

## APFS ROM Patcher by DosDude1
##"Some Macs have old firmware and the installer may require an HFS+ disk. The macOS installer will erase it and set it to APFS. If you have one of these Macs, be sure to use Dosdude1's ROM patcher prior to running the installer. See the Sunglasses emoji folder. The firmware too will allow your Mac to natively boot APFS volumes without relying on a software patch, Clover or Open Core. Use at your own risk. This software is provided as is without warranty. Do not power off when using any firmware tool."
