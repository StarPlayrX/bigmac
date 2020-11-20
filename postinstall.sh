#!/bin/sh

#  sudo ./postinstall.sh
#  BigMac MacPro post install tool v11.0.1 build 0.1
#  Created by StarPlayrX on 11.17.2020


#Auto Switch to the current directory
dir=$(dirname "$0")
cd "$dir"

bigmac="$(pwd)"

printf '\e[48;5;0m' #black background
echo
printf '\e[K'

printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"
printf "[38;5;112mStarPlayrX -> Big Mac Post Installation Tool for Mac Pros v11.0.1 0.1\r\n"
printf "[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n\r\n"
printf "[38;5;112m"

printf "🍔 = Apple HD Audio, SSE4.1 Telemetry, SuperDrive Support\r\n"
printf "🧀 = MouSSE 4.2 Emulator for AMD Radeon Video Drivers\r\n"
printf "🍺 = HDMI Audio, Legacy USB Injector\r\n"
printf "📸 = Snapshot removal tool by StarPlayrX\r\n"

destVolume="/"
kexts="/🍔/"
cheese="/🧀/"
beer="/🍺/"
boot="/💾/"

bigsur="bigsur/"

source=$(pwd)$kexts
cheesey=$(pwd)$cheese
rootbeer=$(pwd)$beer
bootdisk=$(pwd)$boot

read -p "
🖥  Destination Volume [ $destVolume = return key | drag volume here -> ]: " destVolume2

if [ "$destVolume2" != "" ]
 then
   mount -uw "$destVolume2"
   destVolume="$destVolume2"
 else
   mount -uw /
fi

read -p "
🍔 Resources [ $source = return key ]: " source2

if [ "$source2" != "" ]
  then
    source="$source2/"
fi

echo "\r\n🖥  Destination --> $destVolume"
echo "\r\n🍔 Resources   --> $source\r\n"
read -p "Press return to proceed:" proceed

kext="/System/Library/Extensions/"
libKext="/Library/Extensions/"
plugins="/System/Library/UserEventPlugins/"
systemconfig="/Library/Preferences/SystemConfiguration/"

libDest=$destVolume$libKext
dest=$destVolume$kext
userEventPlugins=$destVolume$plugins

#Apple Kexts
appleHDA="AppleHDA.kext"
ioATAFamily="IOATAFamily.kext"

#SSE4.1 compatible plugin
telemetry="com.apple.telemetry.plugin"

#Third Party Kexts
AAAMouSSE="AAAMouSSE.kext"
LegacyUSBInjector="LegacyUSBInjector.kext"
SIPManager="SIPManager.kext"
HDMIAudio="HDMIAudio.kext"
bootplist="com.apple.Boot.plist"

echo "Boot.plist -no_compat_check"
rm -Rf "$systemconfig$bootplist"
ditto -v "$bootdisk$bigsur$bootplist" "$systemconfig$bootplist"
chown -R 0:0 "$systemconfig$bootplist"
chmod -R 755 "$systemconfig$bootplist"
echo "\r"


rm -Rf "$libDest$SIPManager"
rm -Rf "$libDest$LegacyUSBInjector"

echo "SSE4.2 AMD Radeon Driver Emulator MouSSE"
rm -Rf "$libDest$AAAMouSSE"
ditto -v "$cheesey$AAAMouSSE" "$libDest$AAAMouSSE"
chown -R 0:0 "$libDest$AAAMouSSE"
chmod -R 755 "$libDest$AAAMouSSE"
echo "\r"

echo "HDMI Audio"
rm -Rf "$libDest$HDMIAudio"
ditto -v "$rootbeer$HDMIAudio" "$libDest$HDMIAudio"
chown -R 0:0 "$libDest$HDMIAudio"
chmod -R 755 "$libDest$HDMIAudio"
echo "\r"

echo "SSE4.1 compatible Telemetry plugin"
rm -Rf "$userEventPlugins$telemetry"
ditto -v "$source$telemetry" "$userEventPlugins$telemetry"
chown -R 0:0 "$userEventPlugins$telemetry"
chmod -R 755 "$userEventPlugins$telemetry"
echo "\r"

echo "Apple CD/DVD drive Intel PIIX ATA"
rm -Rf "$dest$ioATAFamily"
ditto -v "$source$ioATAFamily" "$dest$ioATAFamily"
chown -R 0:0 "$dest$ioATAFamily"
chmod -R 755 "$dest$ioATAFamily"
echo "\r"

##This also fixes USB Video crash bug in Quicktime Player.
echo "Apple HD Audio"
rm -Rf "$dest$appleHDA"
ditto -v "$source$appleHDA" "$dest$appleHDA"
chown -R 0:0 "$dest$appleHDA"
chmod -R 755 "$dest$appleHDA"
echo "\r"

echo "Apple HD Audio"
rm -Rf "$dest$appleHDA"
ditto -v "$source$appleHDA" "$dest$appleHDA"
chown -R 0:0 "$dest$appleHDA"
chmod -R 755 "$dest$appleHDA"
echo "\r"

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

echo "Software Version Check"
version=$($sw '-productVersion')
echo $version

#Will find a better way to compare these strings (one day)
if [ $version != "11.0.1" ] && [ $version != "11.0.2" ] && [ $version != "11.0.3" ] && [ $version != "11.0.4" ] && [ $version != "11.0.5" ] && [ $version != "11.0.6" ] && [ $version != "11.0.7" ] && [ $version != "11.0.8" ] && [ $version != "11.0.9" ] && [ $version != "11.1.0" ] && [ $version != "11.1.1" ]
 then
   ## Use is not Catalina
   if [ "$destVolume" == "/" ]
   then
     echo "\r\nUpdating System Prelinked Kernel...\r\n"
       kextcache -system-prelinked-kernel
     echo "\r\nUpdating System Caches...\r\n"
       kextcache -system-caches
     else
       echo "\r\nUpdating kextcache on volume $destVolume...\r\n"
         kextcache -u "$destVolume"
       echo "\r\nUpdating startup kextcache check on volume $destVolume...\r\n"
         kextcache -U "$destVolume"
   fi
 
 else
    ##Barry's version
    echo "\r\nUpdating Boot BootKernelExtensions..."
    kmutil create -n boot --kernel /System/Library/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --system-path /System/Library/KernelCollections/SystemKernelExtensions.kc --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    echo "\r\nUpdating System BootKernelExtensions..."
    kmutil create -n sys --kernel /System/Libary/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --system-path /System/Library/KernelCollections/SystemKernelExtensions.kc --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    
   kcditto="kcditto"
   sbin="/usr/sbin/"
   "$destVolume$sbin$kcditto"
fi

#Snapshot deletion code by StarPlayrX 2020
snapshots=$(diskutil apfs listsnapshots "$destVolume" | grep +-- | sed 's/^.\{4\}//')

echo '\r\nChecking snapshots.'

for uuid in $snapshots
do
    printf '📸 Attempting to delete snapshot => '
    echo $uuid
    echo ''
    
    diskutil apfs deletesnapshot "$destVolume" -uuid $uuid
done

bless --folder "$destVolume/System/Library/CoreServices" --bootefi ##--create-snapshot

echo "\r\nIf your system gets locked with a snapshot try cloning it with:"
echo "\r\nsudo asr -s /Volumes/YourSoureVolName -t /Volumes/YourTargetVolName -er -nov"

echo "\r\n💰Tips via PayPal are accepted here: https://tinyurl.com/y2dsjtq3\r\n"

read -p "Press return to Reboot [ options : q for quick ]: " rebootArgs
echo "\r\n"

if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs"
else
    reboot
fi
