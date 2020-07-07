#!/bin/sh

#  postinstall.sh v0.0.8
#  Created by StarPlayrX on 7/1/20.

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

#Third Party Add ons - will later conflict with AppleHDA
VoodooHDA="VoodooHDA.kext"
#AAAMouSSE="AAAMouSSE.kext"

#HFSEncodings="HFSEncodings.kext"
#HFSStandard="HFS.kext"
#HFSfs="hfs.fs"
#fsDriver="AppleFileSystemDriver.kext"

echo "SSE3 compatible Telemetry plugin"
ditto -v "$source$telemetry" "$plugins$telemetry"
echo "\r"

echo "Apple CD/DVD drive Intel PIIX ATA"
ditto -v "$source$ioATAFamily" "$dest$ioATAFamily"
echo "\r"

echo "Apple High Def Audio"
ditto -v "$source$appleHDA" "$dest$appleHDA"
echo "\r"


#comment out if you don't want this installed
echo "Voodoo Digital audio out HDMI over all Nvidia ports."
ditto -v "$source$VoodooHDA" "$libDest$VoodooHDA"
echo "\r"


#echo "MouSSE SSE4.2 Emulator"
#ditto -v "$source$AAAMouSSE" "$libDest$AAAMouSSE"
#echo "\r"


## On hold until I can compile a new Kext
##echo "Apple Standard HFS and HFS+ Disks"
##ditto -v $source$HFSStandard $dest$HFSStandard
##echo "\r"

##echo "Apple Standard HFS and HFS+ FileSystem"
##ditto -v $source$HFSfs $fs$HFSfs
##echo "\r"

##echo  "Apple Standard HFS and HFS+ Encodings"
##ditto -v $source$HFSEncodings $dest$HFSEncodings
##echo "\r"

##echo  "Apple Standard HFS and HFS+ Encodings"
##ditto -v $source$fsDriver $dest$fsDriver
##echo "\r"


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
 ##Clean up our mess
    
    if [ $destVolume == "/" ]
    then
        kernel="/📚/🍎/💾/📚/🍿/prelinkedkernel"
        currentDir=$(pwd)
        sudo ditto -v "$currentDir$kernel" /Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel
    
        kmutil create -n boot --boot-path /Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions
    fi
   kmutil install --force --volume-root "$destVolume"
    
   kcditto="kcditto"
   sbin="/usr/sbin/"
   $destVolume$sbin$kcditto
fi



echo "\r\nThis script was brought to you by StarPlayrX\r\nThe Most Awesome Sirius XM Radio player,\r\nVersion 1.1 is in public beta via TestFlight:\r\nhttps://testflight.apple.com/join/Ecz0xXvf\r\n"

read -p "Press return to Reboot [ options : q for quick ]: " rebootArgs
echo "\r\n"

if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs"
else
    reboot
fi
