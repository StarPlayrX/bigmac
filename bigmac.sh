#!/bin/sh

#  sudo ./preinstall.sh
#  BigMac MacPro pre-install tool v1.1
#  Created by StarPlayrX on 12.14.2020

#To do put in color subroutines

#AutoSwitch to current directory'
dir=$(dirname "$0")
cd "$dir"

if [ $UID != 0 ]
  then
    echo
    echo "Root permissions are vital."
    echo "Please re-run this script with sudo."
    echo
    exit 1
fi

bigmac=$(pwd)
macpro=$(sysctl hw.model)

if [[ "$macpro" != *"MacPro"* ]]
  then
    echo
    echo "Please run BigMac on a Mac Pro."
    echo
    exit 1
  else
    if [[ "$macpro" = "MacPro6,1" ]]
    then
        echo "This hardware is eligible for using macOS Big Sur."
        echo "It is not recommended to run BigMac on your machine."
        exit 1
    fi
    if [[ "$macpro" = "MacPro7,1" ]]
    then
        echo "This hardware is eligible for using macOS Big Sur."
        echo "It is not recommended to run BigMac on your machine."
        exit 1
    fi
fi

printf '\e[48;5;0m\e[K'
printf '\e[K'
printf "\n\e[38;5;172m—————————————————————————————–—————————————————————————————————————————————————"
printf '\e[K'
printf "\n\e[38;5;112m🥤 Big Sur Downloader 🍟 Big Sur USB Installer 🍔 bigmac on separate partition"
printf '\e[K'
printf "\n\e[38;5;172m—————————————————————————————–—————————————————————————————————————————————————"
printf '\e[K'
printf "\r\n\e[38;5;112m"
printf '\e[K'
printf "\e[38;5;112m"
printf '\e[K'
printf '\n\e[K'
printf '\e[K'
# Update to macOS 11.2.3 (20D91)
read -p "📦 Would you like to download macOS Big Sur 11.2.3 (20D91)? [y]: " install
printf '\e[K'

if [[ "$install" == *"y"* ]]
    then
        printf '\e[K'
        echo
        printf '\e[K'
        
            #mark="12886109321"
            #printf 'Evalulating Base System checksum...'
            #checksum=$(stat ~/Downloads/InstallAssistant.pkg | awk '{printf $2}')
                        #if [ $checksum != $mark ]

           # if [ "1" == "1" ]
                #then
                    if [ -d ~/Downloads/InstallAssistant* ]
                    then
                        rm -rf ~/Downloads/InstallAssistant*
                    fi
                    echo "Starting download..."
                    # Updated download link to macOS 11.2.3, thanks to SUS Inspector.
                    # SUS Inspector is available at https://github.com/hjuutilainen/sus-inspector/releases/latest
                    curl http://swcdn.apple.com/content/downloads/12/32/071-14766-A_Q2H6ELXGVG/zx8saim8tei7fezrmvu4vuab80m0e8a5ll/InstallAssistant.pkg -L -o ~/Downloads/InstallAssistant.pkg &> /dev/null
                    printf '\e[K'
                    echo
                    printf '\e[K'
                    # This code has been suppressed to installer command
                    echo "Preparing installer..."
                    installer -pkg ~/Downloads/InstallAssistant.pkg -target / &> /dev/null
                    rm -rf ~/Downloads/InstallAssistant*
                #else
                    printf "\nDownload Complete.\n"
                    
            #fi
fi

    printf '\e[K'
    echo
    printf '\e[K'
    
read -p "🍦 Would you like to create a USB Installer, excluding thumb drives [y]: " create
    printf '\e[K'
    echo
    printf '\e[K'
    
while [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]

do
    if [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]
        then
            printf '\e[K'
            read -p "🤯 Please place the Install macOS Big Sur.app in your 🍎 Applications 📂 Folder and press Return: "
            printf '\e[K'
        else
        printf "\033[0m"
        exit 1
    fi
done

installapp = "/Applications/Install macOS Big Sur.app"
disk=""
media=""
volumes="/Volumes/"


if [[ "$create" == *"y"* ]]
    then
        while [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
            do
                if [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
              then
                printf '\e[K'
                read -p "💾 Please Format using Disk Utility
   to Mac OS Extended (Journaled)
   Drag your External Disk here -> " media
                printf '\e[K'
                disk=$(diskutil info "$media" | grep 'Part of Whole:' | sed 's/^.\{30\}//')
                
                echo
                printf '\e[K'
                echo "🔍 Detected Whole disk: "$disk
                printf '\e[K'
    
                number=$RANDOM
                
                disk="$disk"
                            
                echo
                printf '\e[K'
                
                echo '🍩 Paritioning the drive with bigmac and install volumes.'
                printf '\e[K'
                echo
                printf '\e[K'
                diskutil partitionDisk "$disk" GPT jhfs+ bigmac_"$disk$number" 1g jhfs+ installer_"$disk$number" 16g jhfs+ FreeSpace 0 &> /dev/null
                
                echo
                printf '\e[K'
                echo 🍟 Copying bigmac patcher to volume: bigmac_"$disk$number" &> /dev/null
                echo
                printf '\e[K'
                
                
                if [ -d /Volumes/bigmac_"$disk$number" ] && [ -d $bigmac ]
                then
                    ditto -v $bigmac /Volumes/bigmac_"$disk$number" &> /dev/null
                else
                    echo "We can't find the destination or source disk for bigmac. Exiting"
                    printf "\033[0m"
                    exit 1
                fi
                
                echo
                printf '\e[K'
                echo 🍔 Renaming bigmac_"$disk$number" volume to bigmac
                echo
                printf '\e[K'
                diskutil rename bigmac_"$disk$number" bigmac
                
                echo
                printf '\e[K'
                echo 🤠 Creating bootable installer using volume: installer_"$disk$number"
                
                printf '\e[K'
                echo
                "$installapp"/Contents/Resources/createinstallmedia --nointeraction --volume /Volumes/installer_"$disk$number"

                # This code is specifically from BarryKn
                for installvolume in "Install macOS Big Sur"
                do
                    bootplist="com.apple.Boot.plist"
                    boot="/💾/"
                    printf '\e[K'
                    echo "Boot.plist -v -no_compat_check to USB Installer"
                    printf '\e[K'
                    systemconfig="/Volumes/$installvolume/Library/Preferences/SystemConfiguration/"
                    bootdisk=$(pwd)$boot
                    base="base/"
                done

                if [ -d "$bootdisk$base" ] && [ -d "$systemconfig" ]
                    then
                        printf '\e[K'
                        echo "$bootdisk$base$bootplist"
                        printf '\e[K'
                        echo "$systemconfig$bootplist"
                        printf '\e[K'
                        rm -Rf "$systemconfig$bootplist"
                        ditto -v "$bootdisk$base$bootplist" "$systemconfig$bootplist"
                    else
                        printf '\e[K'
                        echo "$bootdisk$base$bootplist"
                        printf '\e[K'
                        echo "$systemconfig$bootplist"
                        printf '\e[K'
                    echo "We are not able to write to the Boot.plist file on Installer macOS Big Sur because it's missing."
                    printf '\e[K'
                    printf "\033[0m"
                    exit 1
                fi
                
                chown -R 0:0 "$systemconfig$bootplist"
                chmod -R 755 "$systemconfig$bootplist"
                printf '\e[K'
                echo
                printf '\e[K'
                ##echo "☠️  Renaming Install macOS Big Sur volume to BigMac11USB"
                ##diskutil rename "Install macOS Big Sur" "BigMac11USB"
                ##printf '\e[K'
            fi
        done
    printf '\e[K'
    printf "\e[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
    printf '\e[K'
    printf "\e[38;5;112m Reboot -> HOLD Down OPTION Key -> Select macOS Big Sur Installer\n"
    printf '\e[K'
    printf "\e[38;5;112m Open Terminal and Type 'cd /Volumes/bigmac; ./preinstall.sh'\n"
    printf '\e[K'
    printf "\e[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
    printf '\e[K'
    printf "\e[38;5;112m Quit Terminal. Open the Installer App from the Window. Wait for 3 reboots.\n"
    printf '\e[K'
    printf "\e[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
    printf '\e[K'
    printf "\e[38;5;112m Reboot -> HOLD Down OPTION Key -> Select macOS Big Sur Installer\n"
    printf '\e[K'
    printf "\e[38;5;112m Open Terminal and Type 'cd /Volumes/bigmac; ./postinstall.sh'\n"
    printf '\e[K'
    printf "\e[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
    printf '\e[K'
    printf "[38;5;112m"
    printf '\e[K'
fi

echo
printf '\e[K'
echo "🍟 FreeSpace Partition has FREE SPACE on it! (Thank you Capt. Obvious.)"
printf '\e[K'
echo
printf '\e[K'
printf '\e[K'; echo "💰 Tips via PayPal are accepted here: https://tinyurl.com/y2dsjtq3"; printf '\e[K'
printf '\e[K'
echo
printf '\e[K'
printf "\033[0m"
exit 0
