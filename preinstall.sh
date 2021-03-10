#!/bin/sh

#  sudo ./preinstall.sh
#  BigMac MacPro pre-install tool v1.1
#  Created by StarPlayrX on 12.14.2020

#Auto Switch to the current directory
dir=$(dirname "$0")
cd "$dir"

if [ $UID = 0 ]
  then
    echo
    echo "Root permissions are vital."
    echo "Please re-run this script with sudo."
    echo
    exit 1
fi

#Black background
k () {
    printf '\e[K'
    printf '\e[48;5;0m'
    printf '\e[K'
}

#New Line
n () {
    k
    echo
    k
}

#Orange Text
o () {
    k
    printf '\e[38;5;172m'
    k
}

#Green Text
g () {
    k
    printf '\e[38;5;112m'
    k
}

n
o
printf "—————————————————————————————————————————————————————————————————"
n
g
printf "  StarPlayrX -> Big Mac Post Installation Tool for Mac Pros 1.0.3"
n
o
printf "—————————————————————————————————————————————————————————————————"
n
g
n

IsNotRecovery=$(csrutil disable 2>&1)
Recovery="Recovery"

if [[ "$IsNotRecovery" == *"$Recovery"* ]]
    then
        g
        printf " 🍟 Activating Hax Do No Seal - Enabling Mac OS Extended Journaled"
    else
        g
        printf " 🍟 Activating Hax Do No Seal - Enabling JHGS+ and APFS"
fi

mount -uw /

bootArgs=$(nvram -p | grep boot-args)
bootArgs=$(echo $bootArgs | cut -d " " -f2-)

recommended="-v -no_compat_check amfi_get_out_of_my_way=1"

#sudo nvram csr-active-config='%ff%00%00%00'
#legacy_hda_tools_support=1 kext-dev-mode=1
#cs_enforcement_disable=1  keepsyms=1 intcoproc_unrestricted=1

n
n
o
printf "—————————————————————"
n
g
printf " 🤠 macOS boot-args"
n
o
printf "—————————————————————"
g
n
n
printf " [R]ecommended  \e[38;5;172m——>\e[38;5;112m  $recommended"
n
printf " [C]urrent      \e[38;5;172m——>\e[38;5;112m  $bootArgs"
n
n
read -p " Enter [c] or [r] : " default

if [ "$default" == "R" ] || [ "$default" == "r" ]
  then
    bootArgs="$recommended"
    nvram boot-args="$bootArgs"
fi

n
n
echo "Setting Boot Args"
n
nvram -p | grep boot-args
n

#printf '\e[K';
#printf '\e[K';echo "Check System Integrity";printf '\e[K';
#printf '\e[K';
#printf '\e[K';csrutil status;printf '\e[K';
#printf '\e[K';

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

n
echo "Software Version Check";
#kern.osversion
version=$(sysctl -n kern.osproductversion)

echo $version

o
printf "—————————————————————————————————————"
n
g
printf "      ☑️  Checking Root Status"
n
g
o
printf "—————————————————————————————————————"
g
n
    
#       Authenticated Root status: disabled
#       csr-active-config    %7f%08%00%00

if [[ $version == *"11."* ]]
 then
   

    csrutil authenticated-root status
fi

nvram -p | grep csr-active-config

o
printf "————————————————————————————————————"
n
g
printf " 📚 Disabling Library Validation"
n
o
printf "————————————————————————————————————"
n
defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true
n
o
printf "———————————————————————————————————————————————————————————————————"
n
g
printf " 🪚 Loading Hax Do Not Seal into Memory by ASentientBot | BarryKN"
o
g
n
hax="/🍟/HaxDoNotSealNoAPFSROMCheck.dylib"

asentientbot=$(pwd)
barrykn=$hax


if [[ "$IsNotRecovery" == *"$Recovery"* ]]
    then
        sudo -u $SUDO_USER launchctl setenv DYLD_INSERT_LIBRARIES "$asentientbot$barrykn"
        o
        printf "———————————————————————————————————————————————————————————————————"
        n
        g
        printf " 📀 DO NOT REBOOT. Please run the 'Install macOS Big Sur.app' now!"
    else
        launchctl setenv DYLD_INSERT_LIBRARIES "$asentientbot$barrykn"
        o
        printf "———————————————————————————————————————————————————————————————————"
        n
        g
        printf " Disabling System Integrity Protection (SIP)"
        n
        g
        printf " "
        ##csrutil enable --no-internal --without kext --without fs --without debug --without dtrace --without nvram --without basesystem
        csrutil disable
        o
        printf "———————————————————————————————————————————————————————————————————"
        g
        n
        printf " Disabling Authenticated Root"
        n
        g
        printf " "
        csrutil authenticated-root disable
        o
        printf "———————————————————————————————————————————————————————————————————"
        n
        g
        printf " Quit the Terminal and Select Install macOS Big Sur in the Window"
        n
        printf " 📀 DO NOT REBOOT. Please run the 'Install macOS Big Sur.app' now!"
        n
        o
        printf "———————————————————————————————————————————————————————————————————"
        n

fi
n
o
printf "———————————————————————————————————————————————————————————————————"
n
g
printf " 💰 Please Support Big Mac via PayPal https://tinyurl.com/y2dsjtq3"
n
o
printf "———————————————————————————————————————————————————————————————————"
g
n
n
printf "\033[0m"
INSTALLASSISTANT='/Volumes/Image Volume/Install macOS Big Sur.app/Contents/MacOS/InstallAssistant'
if [ -d $INSTALLASSISTANT ]
then
    $INSTALLASSISTANT &> /dev/null
else
    INSTALLASSISTANT='/Install macOS Big Sur.app/Contents/MacOS/InstallAssistant'
    $INSTALLASSISTANT &> /dev/null
fi
