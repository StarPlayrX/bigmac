#!/bin/sh

#  postinstall.sh v0.0.8
#  Created by StarPlayrX on 9/30/20

cat './🎨/post-art.ans'

destVolume="/"
kexts="/🍔/"
source=$(pwd)$kexts
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
fs="/System/Library/Filesystems/"

libDest=$destVolume$libKext
dest=$destVolume$kext
userEventPlugins=$destVolume$plugins

appleHDA="AppleHDA.kext"
telemetry="com.apple.telemetry.plugin"
ioATAFamily="IOATAFamily.kext"

echo "SSE3 compatible Telemetry plugin"
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
echo "Apple High Def Audio"
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
echo ""

if [ $version != "10.16" ] && [ $version != "10.16.1" ] && [ $version != "11.0" ] && [ $version != "11.0.1" ]
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
    kmutil create -n boot --kernel /System/Library/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    echo "\r\nUpdating System BootKernelExtensions..."
    kmutil create -n sys --kernel /System/Libary/Kernels/kernel --variant-suffix release --volume-root "$destVolume" --system-path /System/Library/KernelCollections/SystemKernelExtensions.kc --boot-path /System/Library/KernelCollections/BootKernelExtensions.kc

    
   kcditto="kcditto"
   sbin="/usr/sbin/"
   "$destVolume$sbin$kcditto"
fi

echo "\r\nThis script was brought to you by StarPlayrX\r\nThe Most Awesome Sirius XM Radio player,\r\nVersion 1.1 available now in the iOS AppStore!"

read -p "Press return to Reboot [ options : q for quick ]: " rebootArgs
echo "\r\n"

if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs"
else
    reboot
fi
