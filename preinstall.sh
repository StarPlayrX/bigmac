#!/bin/sh

#  sudo ./preinstall.sh
#  BigMac MacPro pre-install tool v0.0.12
#  Created by StarPlayrX on 10.17.2020

printf '\e[48;5;0m\r\n' #black background

printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
printf "[38;5;112mStarPlayrX -=> Big Mac Pre-Installation Tool for Mac Pros v0.0.12\r\n"
printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n\r\n"
printf "[38;5;112m"

printf "🍟 = Hax Do Not Seal with No APFS Check (BarryKN fork) \r\n"

printf '\e[48;5;0m' #black background

mount -uw /

bootArgs=$(nvram -p | grep boot-args)

echo ""

bootArgs=$(echo $bootArgs | cut -d " " -f2-)

echo "nvram check"
echo $bootArgs

default="-no_compat_check -v"

read -p "
🖥  boot-args: [enter = $bootArgs]: " default

if [ "$default" != "" ]
  then
    bootArgs="$default"
fi

sudo nvram boot-args="$bootArgs"

echo "\r\nset boot args"
nvram -p | grep boot-args

echo "\r\nCheck System Integrity"
csrutil status

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

echo "\r\nSoftware Version Check"
version=$($sw '-productVersion')
echo $version

if [ $version == "10.16" ] || [ $version == "11.0" ] || [ $version == "11.1" ] || [ $version == "11.0.1" ]
 then
 
    echo "\r\nCheck Root Status"
    csrutil authenticated-root status

fi


## may be able to set csr programically
echo '\n\rCheck csr-active-config:'
nvram -p | grep csr-active-config

#./'Install macOS Beta.app/Contents/MacOS/InstallAssistant' & echo '\r\n' &

echo "\r\nDisabling Library Validation"
defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

echo "\r\nLoading Hax Do Not Seal into Memory - credit ASentientBot & BarryKN :)"
hax="/🍟/HaxDoNotSealNoAPFSROMCheck.dylib"
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

