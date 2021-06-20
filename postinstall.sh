#!/bin/sh

#  sudo ./postinstall.sh
#  BigMac MacPro post install tool v1.1
#  Created by StarPlayrX on 12.14.2020
voice="Samantha"
rate=25

#Auto Switch to the bigmac directory located on external USB drive
dir="/Volumes/bigmac"
if [ ! -d "$dir" ]
    then
    n;o;
    exiting="Can't find the bigmac directory. Please pay attention! Exiting..."
    printf "$exiting"
    
    if [ $speak == true ]
        then
            say "$exiting" --voice "$voice" --rate $rate &
    fi

    n;n;
    exit 1
fi
cd "$dir"

IsNotRecovery=$(csrutil disable 2>&1)
Recovery="Recovery"

speak=false

if [[ "$IsNotRecovery" == *"$Recovery"* ]]
    then
        speak=true
fi


#Black background
k () {
    printf '\e[K'
    printf "\e[48;5;0m"
    printf '\e[K'
}

#New Line
n () {
    k
    printf "\n"
    k
}

#Orange Text
o () {
    k
    printf "\e[38;5;172m"
    k
}

#Green Text
g () {
    k
    printf "\e[38;5;112m"
    k
}

if [ $UID != 0 ]
  then
    echo
    echo "Root permissions are vital."
    echo "Please re-run this script with sudo."
    echo
    exit 1
fi



bigmac="$(pwd)"
k
n
o
printf "—————————————————————————————————————————————————————————————————"
n
g
printf "StarPlayrX | Welcome to Big Mac Two Post Installation Tool v2.0.9"
n
o
printf "—————————————————————————————————————————————————————————————————"
n
g

if [ $speak == true ]
    then
        say "Welcome to Big Mac Two Post Installation Tool" --voice "$voice" --rate "$rate"
fi
    
#forceLegacyWifi
forceLegacy="0"

#-legacy or -Legacy argument, forces Legacy WiFi
if [[ "$1" == "-l"* ]] || [[ "$1" == "-L"* ]]
  then
    forceLegacy="1"
    n;o
    printf 'Use Legacy Wifi is ON...'
    n
    g
    sleep 1
  else
    forceLegacy="0"
    n;g
    printf ' Auto detect WiFi is ON. Use -L argument to force Legacy 802.11n'
    n
fi



n
o
printf "—————————————————————————————————————————————————————————————————"
n
g
printf " 🍔  Apple HD Audio, SSE4.1 Telemetry, SuperDrive Support"
n
printf " 🧀  MouSSE 4.2 Emulator for AMD Radeon Video Drivers"
n
printf " 🍺  HDMI Audio, USB Map, Legacy WiFi, Disable Bluetooth"
n
printf " 🚁  Legacy WiFi, Bluetooth 2 Disabler prevents Kernel Panic"
n
printf " 🖱   USB 1.1. A Hub is recommended for USB 1 & 2 input devices"
n
printf " 📸  Snapshot Removal Tool by StarPlayrX"
n
o
printf "—————————————————————————————————————————————————————————————————"
n
g


destVolume="/"
kexts="/🍔/"
cheese="/🧀/"
beer="/🍺/"
boot="/💾/"
soft="/💿/"

bigsur="bigsur/"

source=$(pwd)$kexts
cheesey=$(pwd)$cheese
rootbeer=$(pwd)$beer
bootdisk=$(pwd)$boot
soft=$(pwd)$soft

#Apple Kexts
appleHDA="AppleHDA.kext"
ioATAFamily="IOATAFamily.kext"
AppleStorageDrivers="AppleStorageDrivers.kext"
IOUSBMassStorageClass="IOUSBMassStorageClass.kext"
IOBluetoothFamily="IOBluetoothFamily.kext"
IOBluetoothHIDDriver="IOBluetoothHIDDriver.kext"

#SSE4.1 compatible plugin
telemetry="com.apple.telemetry.plugin"
AAAMouSSE="AAAMouSSE.kext"
telemetrap="telemetrap.kext"
HDMIAudio="HDMIAudio.kext"
bootplist="com.apple.Boot.plist"
evaluatingSystemDisks="Evaluating... System Disks"
n
o
printf "————————————————–––––————————————"
n
g
printf " 💾 $evaluatingSystemDisks"
n
o
printf "————————————————–––––————————————"
n
g
#systemsetup=""
#while [[ "$systemsetup" != *"System/Library/CoreServices"* ]]
#do
#    systemsetup=$(systemsetup -liststartupdisks)
#done

if [ $speak == true ]
    then
        say "$evaluatingSystemDisks" --voice "$voice" --rate $rate &
fi

sleep 1.5

IFS=$'\n' #Breaks for in loops at line ending and ignores spaces

counter=0
systemdisks=()
space=" "
dot="."
suffix="System/Library/CoreServices"
slash="/"
startupdisk="/"
#Display the Disk Menu, routine by StarPlayrX
#for sys in $systemsetup
#do
     
#     counter=$((counter+1))
#     long=$(echo $sys | awk '{ printf $0 }' )
#     systemdisk=${long%"$suffix"}
     
#     if [[ "$systemdisk" != *"/Volumes"* ]]
#        then
#            g;n;
#            systemdisk="/"
#            printf "$counter$dot$space$systemdisk"
#            systemdisks+=($systemdisk)
#        else
#            g;n;
#            systemdisk=${systemdisk%"$space"}
#            systemdisk=${systemdisk%"$slash"}
#            printf "$counter$dot$space$systemdisk"
#           systemdisks+=($systemdisk)
#    fi
#done

IFS=$'\n'

list=$(ls /Volumes 2>&1)
match="The blessed volume in this APFS container is "
apfsContainer="APFS container"
volumesFolder="/Volumes/"
counter=0
startup="Startup"
systemdisks+=($systemdisk)
systemnames+=($systemnames)
comdot="com."
snapshot="snapshot"
timemachine="timemachine"

n
for i in $list
do

    if [[ $i != *'- Data' ]]
        then
            item=$(bless -info "$volumesFolder$i" 2>&1 | grep "$apfsContainer" 2>&1)
            
            isEmpty=$(diskutil list "$i" 2>&1)
            
            if [[ "$item" == "$match\"$volumesFolder$i\"." ]] && [ isEmpty != '' ]
                then
                 counter=$((counter+1))
                
                 printf "$counter. $i"
                 n
                 systemdisks+=("$volumesFolder$i")
                 systemnames+=("$i")
            elif [ "$item" == "$match\"/\"." ] &&  [[ "$i" != *"$snapshot"* ]] && [[ "$i" != *"$timemachine"* ]]  && [[ "$i" != *"$comdot"* ]] && [ isEmpty != '' ]
                 then
                 counter=$((counter+1))
                
                 printf "$counter. $i ($startup)"
                 n
                 systemdisks+=("/")
                 systemnames+=("$i")
            fi
    fi

done

#counter=$((counter+1)) #Sets up # Entry for the Startup Disk menu

if [ $speak == true ]
    then
        say "Please select a System Disk by it's number" --voice "$voice" --rate $rate &
fi


n;
read -p " 🎯 Target | Please select a System Disk # : " destVolume



if [ "$destVolume" != "" ] && [ "$destVolume" != "/" ] && [ -n "$destVolume" ] && [ "$destVolume" -eq "$destVolume" ] 2>/dev/null
    then
        if  [[ $((destVolume+0)) < counter ]]
            then
            destVolume=$((destVolume-1))
            label=${systemnames[destVolume]}
            destVolume=${systemdisks[destVolume]}

        fi
fi


if [ "$destVolume" == "" ] || [ "$destVolume" == "/" ]
 then
    destVolume="/"
 else
   prefix="/Volumes/"
   label=${destVolume%"$space"}
   label=${destVolume#"$prefix"}
   destVolume=${destVolume%"$space"}
fi

if [ ! -d "$destVolume" ]
    then
    n;o;
    exiting="Can't find the disk. Please pay attention! Exiting..."
    printf "$exiting"
    
    if [ $speak == true ]
        then
            say "$exiting" --voice "$voice" --rate $rate &
    fi

    n;n;
    exit 1
fi

mount -uw "$destVolume"

n;o;
printf "—————————————————————————————————————————————————————————————————"
n;
g;

marker=$volumesFolder$label

if [ "$label" == "" ]
    then
        marker="/"
fi

printf " 🎯 Target ";o;printf "——>";g; printf " $marker"
n;
printf " 🍔 Source ";o;printf "——>";g; printf " $source"
n;o;
printf "—————————————————————————————————————————————————————————————————"
n;n;g;

pro="Press the return key to proceed | or E to Exit : "

if [ $speak == true ]
    then
        say "$pro" --voice "$voice" --rate $rate &
fi


read -p "$pro" proceed

if [[ $proceed == "e"* ]] ||  [[ $proceed == "E"* ]] || [[ $proceed == "q"* ]] || [[ $proceed == "Q"* ]]
    then
    n
    wish="As you wish... exiting..."
    printf "$wish"
    n;n;
    
    if [ $speak == true ]
        then
            say "$wish" --voice "$voice" --rate $rate &
    fi

    exit 1
fi

kext="/System/Library/Extensions/"
libKext="/Library/Extensions/"
plugins="/System/Library/UserEventPlugins/"
systemconfig="/Library/Preferences/SystemConfiguration/"
bootplist="com.apple.Boot.plist"
coreservices="/System/Library/CoreServices/"
buildmanifest="BuildManifest.plist"
platformsupport="PlatformSupport.plist"

restore="/restore/"
ghost="/👻/" #Preboot temporary mount point

n;o;
printf "————————————————–––––————————————"
n;g;
printf "Boot.plist installation"
n;o;
printf "————————————————–––––————————————"
n;g;


#cp "$bootdisk$bigsur$bootplist" "$(pwd)$systemconfig$bootplist"
ditto -v "$bootdisk$bigsur$bootplist" "$destVolume$systemconfig$bootplist"
chmod 755 "$destVolume$systemconfig$bootplist"
chown 0:0 "$destVolume$systemconfig$bootplist"

ditto -v "$bootdisk$bigsur$platformsupport" "$destVolume$coreservices$platformsupport" 
chmod 755 "$destVolume$coreservices$platformsupport"
chown 0:0 "$destVolume$coreservices$platformsupport"

#Preboot work
n
printf "Loading preboot..."
preboot=$( diskutil list $destVolume | grep Preboot | grep disk | awk '{ printf $7 }' )


prebootlocation=$bigmac$ghost
prebootid=""
loc=""
slash=""

restoremanifest="/restore/BuildManifest.plist"

if [ $destVolume != "/" ]
    then
      printf "Testing Preboot mount..."
      test=$(diskutil unmount force "$preboot")
      printf "Mounting Preboot Volume..."
      diskutil mount -mountPoint "$prebootlocation" "$preboot"
      sleep 1
      prebootid=$( diskutil info "$destVolume" | grep Group | awk '{ printf $4 }' )
      loc=$prebootlocation$prebootid$slash

    else
      #Preboot Volumes are already mounted on Startup disks
      prebootlocation="/System/Volumes/Preboot/"
      prebootid=$( diskutil info / | grep Group | awk '{ printf $4 }' )
      loc=$prebootlocation$prebootid$slash
      echo $loc
fi


if [ ! -d "$prebootlocation$prebootid" ]
    then
        echo "Could not find Preboot Volume exiting... If this persists, reboot."
        diskutil umount force $preboot
        exit 1
fi

sleep 1

n
ditto -v "$bootdisk$bigsur$bootplist" "$loc$systemconfig$bootplist"
chmod 755 "$loc$systemconfig$bootplist"
chown 0:0 "$loc$systemconfig$bootplist"

ditto -v "$bootdisk$bigsur$buildmanifest" "$loc$restoremanifest"
chmod 755 "$loc$restoremanifest"
chown 0:0 "$loc$restoremanifest"

ditto -v "$bootdisk$bigsur$platformsupport" "$loc$coreservices$platformsupport"
chmod 755 "$loc$coreservices$platformsupport"
chown 0:0 "$loc$coreservices$platformsupport"

#If it's not the startup disk unmount the Preboot volume
if [ "$destVolume" != "/" ]
    then
        n
        diskutil unmount force "$preboot"
fi

sleep 3

cd $bigmac

n
printf "Enabling Softare Update"
n
if [ ! -d "/usr/local/lib" ]
    then
        mkdir "/usr/local/lib"
    fi
    
    
n
printf "SUVMMFaker Software Update by Czo"
n
suvm="SUVMMFaker.dylib"
fake="/usr/local/lib/$suvm"
swud="com.apple.softwareupdated.plist"
eden="/System/Library/LaunchDaemons/$swud"

ditto -v "$soft$suvm" "$destVolume$fake"
chmod 755 "$destVolume$fake"
chown 0:0 "$destVolume$fake"
ditto -v "$soft$swud" "$destVolume$eden"
chmod 755 "$destVolume$eden"
chown 0:0 "$destVolume$eden"

n
printf "SSE 4.2 Emulator MouSSE by Syncretic"
n
rm -Rf "$destVolume$libKext$AAAMouSSE"
sleep 0.1
ditto -v "$cheesey$AAAMouSSE" "$destVolume$libKext$AAAMouSSE"
chown -R 0:0 "$destVolume$libKext$AAAMouSSE"
chmod -R 755 "$destVolume$libKext$AAAMouSSE"
touch "$destVolume$libKext$AAAMouSSE"

n
printf "SSE 4.2 Telemetrap by Syncretic"
n
rm -Rf "$destVolume$libKext$telemetrap"
sleep 0.1
ditto -v "$cheesey$telemetrap" "$destVolume$libKext$telemetrap"
chown -R 0:0 "$destVolume$libKext$telemetrap"
chmod -R 755 "$destVolume$libKext$telemetrap"
touch "$destVolume$libKext$telemetrap"

n
printf "HDMI Audio"
n
rm -Rf "$destVolume$libKext$HDMIAudio"
sleep 0.1
ditto -v "$rootbeer$HDMIAudio" "$destVolume$libKext$HDMIAudio"
chown -R 0:0 "$destVolume$libKext$HDMIAudio"
chmod -R 755 "$destVolume$libKext$HDMIAudio"
touch "$destVolume$libKext$HDMIAudio"

n
printf "SSE4.1 compatible Telemetry plugin"
n
rm -Rf "$destVolume$plugins$telemetry"
sleep 0.1
ditto -v "$source$telemetry" "$destVolume$plugins$telemetry"
chown -R 0:0 "$destVolume$plugins$telemetry"
chmod -R 755 "$destVolume$plugins$telemetry"

n
printf "CD/DVD SuperDrive Intel PIIX ATA"
n
rm -Rf "$destVolume$kext$ioATAFamily"
sleep 0.1
ditto -v "$source$ioATAFamily" "$destVolume$kext$ioATAFamily"
chown -R 0:0 "$destVolume$kext$ioATAFamily"
chmod -R 755 "$destVolume$kext$ioATAFamily"
touch "$destVolume$kext$ioATAFamily"

IO80211Family="IO80211Family.kext"
corecapture="corecapture.kext"
ContentsPlugIns="/Contents/PlugIns/"

#Read the Wireless Card and decide which driver to use
wireless=$(ioreg -l | grep 802.11)
wirelessNetAdapter=$(echo $wireless | awk '{ printf $11 }' )

if [[ $wirelessNetAdapter == *"/ac"* ]] && [ $forceLegacy == "0" ]
    then
        n
        printf '802.11ac Detected, using Stock WiFi Drivers.'
        n
elif [ forceLegacy == "1" ] || [[ $wirelessNetAdapter == *"/n"* ]] || [[ $wirelessNetAdapter == *"/g"* ]] || [[ $wirelessNetAdapter == *"/b"* ]] || [[ $wirelessNetAdapter == *"/a"* ]]
    then
        n
        printf 'Installing 802.11 a/b/g/n compatible WiFi drivers'
        n
        rm -Rf "$destVolume$kext$IO80211Family"
        sleep 0.1
        ditto -v "$source$IO80211Family" "$destVolume$kext$IO80211Family"
        chown -R 0:0 "$destVolume$kext$IO80211Family"
        chmod -R 755 "$destVolume$kext$IO80211Family"
        
        rm -Rf "$destVolume$kext$corecapture"
        sleep 0.1
        ditto -v "$source$corecapture" "$destVolume$kext$corecapture"
        chown -R 0:0 "$destVolume$kext$corecapture"
        chmod -R 755 "$destVolume$kext$corecapture"
fi
    
n
printf "Apple HDA | Builtin Audio + USB Webcam Support"
n
rm -Rf "$destVolume$kext$appleHDA"
sleep 0.1
ditto -v "$source$appleHDA" "$destVolume$kext$appleHDA"
chown -R 0:0 "$destVolume$kext$appleHDA"
chmod -R 755 "$destVolume$kext$appleHDA"
touch "$destVolume$kext$appleHDA"


IOHIDFamily="IOHIDFamily.kext"
IOUSBHostFamily="IOUSBHostFamily.kext"
PlugIns="/Contents/PlugIns/"
AppleUSBHostMergeProperties="AppleUSBHostMergeProperties.kext"
Contents="/Contents/"
Info="Info.plist"
IOBluetoothFamily="IOBluetoothFamily.kext"
AppleMCEReporterDisabler="AppleMCEReporterDisabler.kext"

n
printf "Apple MCE Reporter Disabler by xlnc"
n
rm -Rf "$destVolume$kext$AppleMCEReporterDisabler"
sleep 0.1
ditto -v "$source$AppleMCEReporterDisabler" "$destVolume$kext$AppleMCEReporterDisabler"
chown -R 0:0 "$destVolume$kext$AppleMCEReporterDisabler"
chmod -R 755 "$destVolume$kext$AppleMCEReporterDisabler"
touch "$destVolume$kext$AppleMCEReporterDisabler"


n
printf "USB 1.1 Support by ASentientBot"
n
rm -Rf "$destVolume$kext$IOHIDFamily"
sleep 0.1
ditto -v "$source$IOHIDFamily" "$destVolume$kext$IOHIDFamily"
chown -R 0:0 "$destVolume$kext$IOHIDFamily"
chmod -R 755 "$destVolume$kext$IOHIDFamily"
touch "$destVolume$kext$IOHIDFamily"

n
printf "Mac Pro 3,1 Bluetooth 2 Disabler, Bluetooth 4 Enabler by StarPlayrX"
n
sleep 0.1
ditto -v "$source$Info" "$destVolume$kext$IOUSBHostFamily$PlugIns$AppleUSBHostMergeProperties$Contents$Info"
chown -R 0:0 "$destVolume$kext$IOUSBHostFamily$PlugIns$AppleUSBHostMergeProperties"
chmod -R 755 "$destVolume$kext$IOUSBHostFamily$PlugIns$AppleUSBHostMergeProperties"
touch "$destVolume$kext$IOUSBHostFamily$PlugIns$AppleUSBHostMergeProperties"

bin="/📠/"
vers="/sw_vers"
sw=$(pwd)$bin$vers

n
printf "Software Version Check"
n
version=$($sw '-productVersion')
printf $version
n
if [[ $version != *"11."* ]]
    then
        ## Use is Big Sur Disk
        if [ "$destVolume" == "/" ]
        then
            n
            printf "Updating System Prelinked Kernel..."
            
            kextcache -system-prelinked-kernel
            n
            printf "Updating System Caches..."
            n
            kextcache -system-caches
        else
            n
            printf "Updating kextcache on volume $destVolume..."
            n
            kextcache -u "$destVolume"
            
            printf "Updating startup kextcache check on volume $destVolume..."
            n
            kextcache -U "$destVolume"
        fi
        
        if [ "$destVolume" == "/" ]
            then
                chown -R 0:0 /System/Library/Extensions/
                chmod -R 755 /System/Library/Extensions/
                touch "$destVolume"/System/Library/Extensions/
                kextcache -i /
            else
                chown -R 0:0 "$destVolume"/System/Library/Extensions/
                chmod -R 755 "$destVolume"/System/Library/Extensions/
                touch "$destVolume"/System/Library/Extensions/

                kextcache -i "$destVolume"
        fi
    else
    
        if [ "$destVolume" == "/" ]
            then
                ##To do add variables not hard encoded string in commands but be careful, it is easy to write a Prelinked Kernel where to don't want it ( I know )
            	n
       			printf "Updating All Kernel Extensions..."

                touch /Library/Apple/System/Library/Extensions/
                touch /System/Library/Extensions/
                touch /System/Library/DriverExtensions/
                touch /Library/Extensions/
                touch /Library/DriverExtensions/
                
                kmutil install --update-all --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root /


                
                n
                printf "Rechecking System Kernel Extensions..."
                kmutil install --update-all --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root /

                n
       			printf "Rechecking Library Kernel Extensions..."
                
                kmutil install --check-rebuild --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --volume-root /


                #if LibraryAppleSystemLibrary Exists (this created after a user logs in)
                if [ -d "/Library/Apple/System/Library/" ]
                    then
                        if [ ! -d "/Library/Apple/System/Library/PrelinkedKernels/" ]
                            then
                                mkdir "/Library/Apple/System/Library/PrelinkedKernels/"
                        fi
                    /usr/bin/kmutil create -n boot --boot-path /Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel -f 'OSBundleRequired'=='Local-Root' --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root /
                #else use System Library
                else
                    /usr/bin/kmutil create -n boot --boot-path /System/Library/PrelinkedKernels/prelinkedkernel -f 'OSBundleRequired'=='Local-Root' --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root /
                
                fi
            
                
                n
                
                kcditto="kcditto"
                $kcditto
            else
                ##To do add variables not hard encoded string in commands but be careful, it is easy to write a Prelinked Kernel where to don't want it ( I know )
            	n
       			printf "Updating All Kernel Extensions..."
   
                touch "$destVolume"/Library/Apple/System/Library/Extensions/
                touch "$destVolume"/System/Library/Extensions/
                touch "$destVolume"/System/Library/DriverExtensions/
                touch "$destVolume"/Library/Extensions/
                touch "$destVolume"/Library/DriverExtensions/
                
                kmutil install --update-all --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$destVolume"/
                
                n
                printf "Rechecking System Kernel Extensions..."
                kmutil install --update-all --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$destVolume"/
    
                n
                printf "Rechecking Library Kernel Extensions..."
                
                kmutil install --volume-root "$destVolume" --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$destVolume"/
                
                #if Library/Apple/System/Library/ Exists (this created after a user logs in)
                if [ -d "$destVolume/Library/Apple/System/Library/" ]
                    then
                        #create Prelinked kernels directory
                        if [ ! -d "$destVolume/Library/Apple/System/Library/PrelinkedKernels/" ]
                            then
                                mkdir "$destVolume/Library/Apple/System/Library/PrelinkedKernels/"
                        fi
                    n
                    printf "Building Apple System Prelinked Kernel..."
                    n
                    
                    "$destVolume"/usr/bin/kmutil create -n boot --boot-path /Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel -f 'OSBundleRequired'=='Local-Root' --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$destVolume"/
                #else use System Library
                else
                
                    n
                    printf "Building System Prelinked Kernel..."
                    n
                    "$destVolume"/usr/bin/kmutil create -n boot --boot-path /System/Library/PrelinkedKernels/prelinkedkernel -f 'OSBundleRequired'=='Local-Root' --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$destVolume"/
                
                fi
                
                kcditto="kcditto"
                sbin="/usr/sbin/"
                "$destVolume$sbin$kcditto"
        fi
fi


#Snapshot deletion code by StarPlayrX 2020
snapshots=$(diskutil apfs listsnapshots "$destVolume" | grep +-- | awk '{print $2}')


n

#Credit goes to ASentientBot and JackLuke -- Testing this out to see if there are improvements
#"$destVolume"/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs_systemsnapshot -v . -r "" # I really don't know if this has any barring
#

printf 'Checking snapshots.'
n
for uuid in $snapshots
do
    n
    printf ' 📸 Attempting to delete snapshot => '
    n
    printf ' '
    printf $uuid
    n
    
    diskutil apfs deletesnapshot "$destVolume" -uuid $uuid
done


#Bless with snapshot
#bless --folder "$destVolume"/System/Library/CoreServices --bootefi --last-sealed-snapshot
#bless --folder "$destVolume"/System/Library/CoreServices --bootefi --create-snapshot

prefix="/Volumes/"
one="1"
two="2"
three="3"
four="4"

label=${label%"$one"}
label=${label%"$two"}
label=${label%"$three"}
label=${label%"$four"}
label=${label%"$space"}
label=${label#"$prefix"}

n

if [ "$destVolume" == "/" ]
    then
        n
        #sudo bless --folder /System/Library/CoreServices --mount /
        #systemsetup -setstartupdisk "$destVolume"/ #Right now this is too unpredictable 
        bless --folder /System/Library/CoreServices --bootefi --label "$label" --mount / --setBoot # To do add bless tool from 11.1
    else
        bless --folder "$destVolume"/System/Library/CoreServices --bootefi --label "$label" --mount "$destVolume" --setBoot  # To do add bless tool from 11.1
        #sudo bless --folder "$destVolume"/System/Library/CoreServices --mount "$destVolume" --label "$label" #Try to label the disk properly
        #systemsetup -setstartupdisk "$destVolume"/ #Right now this is too unpredictable 
fi


n
printf "If your system gets locked with a snapshot try cloning it with:"

n
printf "sudo asr -s / -t /Volumes/target -er -nov"

n;n;
printf " 💰 Tips via PayPal are accepted here: https://tinyurl.com/y2dsjtq3"

n
read -p "Press RETURN to Reboot [ options : q for quick ]: " rebootArgs

n
printf "\033[0m"
if [ "$rebootArgs" != "" ]
then
    reboot "-$rebootArgs" &> /dev/null
else
    reboot &> /dev/null
fi
