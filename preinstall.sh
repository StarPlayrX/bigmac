#!/bin/sh

#  preinstall.sh  v0.0.8
#  Created by StarPlayrX on 7/1/20.


printf '\e[48;5;0m\r\n' #black background

printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
printf "[38;5;112mStarPlayrX -=> Big Mac Pre Installation Tool for Mac Pros v0.0.11\r\n"
printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n\r\n"
printf "[38;5;112m"

printf "🍟 = Hax Do Not Seal Installation\r\n"

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

echo "\r\nCheck Root Status"
csrutil authenticated-root status

## may be able to set csr programically
echo '\n\rCheck csr-active-config:'
nvram -p | grep csr-active-config

#./'Install macOS Beta.app/Contents/MacOS/InstallAssistant' & echo '\r\n' &

echo "\r\nDisabling Library Validation"
defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

echo "\r\nLoading Hax Do Not Seal into Memory - credit ASentientBot & BarryKN :)"
hax="/🍟/HaxDoNotSeal.dylib"
echo $(pwd)$hax

#Check if sudo is available or not
if sudo -n true
then
  sudo -u $SUDO_USER launchctl setenv DYLD_INSERT_LIBRARIES $(pwd)$hax
  echo sudo user is: $SUDO_USER
  echo ''
else
  launchctl setenv DYLD_INSERT_LIBRARIES $(pwd)$hax
  echo Recovery mode detected, running Hax without sudo
  echo ''
fi

#export $SUDO_USER=bigmac

echo "You can now open the Big Sur macOS Installer app."
echo ''

