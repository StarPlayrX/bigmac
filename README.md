
Currently only clean installs are supported to an erased Mac OS Extended (Journaled) disk.

## Requirements 
1. Mac Pro 2008 - 2012
2. APFS ROM patcher applied. Dosdude1's APFS ROM Patcher is included in the 😎 folder. You only need to flash your Mac's firmware once using his tool. You must put your mac into programming mode. Instructions are included with the tool. This requires time and patience. Don't attempt if you are tired. Do not interrupt.
3. Boot screen. I recommend you have a flashed Nvidia or AMD card that supports Metal. Some steps are difficult without one.
4. Your GPU must support Metal. AMD Cards like the RX 580 8 GB Support 4k @ 60 Hz on Big Sur. Nvidia cards with metal will have 4k @ 30 Hz.

## Pre Install
1. Erase a disk using GUID Partition and Mac OS Extended (Journaled) aka JHFS+ (this step may be automated)
2. Open Terminal.app in Utilties 
3. `cd bigmac.master`
4. `sudo ./preinstall.sh`
5.  set boot-args to `-no_compat_check amfi_get_out_of_my_way=1 -v` or  `-no_compat_check -v`
6. open the macOS Big Sur installer.app
7. select your newly JHFS+ disk.
8. Big Sur 11.0.1 RC2 and later will reboot about 3 times
9. once you see unsupported CPU you can kill it on the 4th boot.


## Post Install
1. Boot back into your other system using the option key.
2. `cd bigmac.master`
3. `sudo ./postinstall.sh`
4. from Finder, drag your macOS volume to the Terminal's prompt
5. Press Enter.
6. For Resources press Enter.
7. Wait
8. Press q and Enter to reboot.


## How to create an external USB Recovery disk
### From Big Sur Recovery volumes only
1. `diskutil list 'Mac Volume Name'`
2. Copy disk#s#' let's say it is disk2s3 for this exercise.
3. `diskutil mount disk2s3`
4. `open /Volumes/Recovery`
5. Arrow down on the weird UUID tagged folder that looks like this '13540289-83B3-3105-8EC7-B05C342DB382' (this will vary and be unique)
6. `sudo asr -s /Volumes/Recovery/13540289-83B3-3105-8EC7-B05C342DB382/BaseSystem.dmg -t /Volumes/externalUSB --er --nov`
7. disk must be around 3GB or higher.


## How to boot Ext USB Recovery disk
1. Boot and hold down option Key
2. If only 1 external USB is connectioned it will say `EFI Boot` with a Yellow USB disk icon.
3. select it. 
4. at black screen wait until it boots (pen drives are slow, recommend a small USB SSD or External Hard Drive)


## How to turn off System Integrity Protection
### aka SIP from the Recovery disk
1. Open Terminal in the booted recovery disk
2. `csrutil disable`
3. `csrutil authenticated-root disable`
4. Use Start up disk (top left to select your installation)


## Big Mac install scripts can run from recovery a disk
1. Use a second USB drive and put Big Mac on it
2. cd /Volumes
3. ls -a
4. `cd bigmac.master`
5. Follow Pre-Install or Post-Install track.


## Videos
1. https://starplayrx.com/downloads/preinstall_bigmac.mov
2. https://starplayrx.com/downloads/postinstall_bigmac.mov
3. https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
4. https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov


## How to clone your system 
### This can also help remove locked apfs snapshots easily
1. `sudo asr -s /drag/source/here -t /drag/target/here -er -nov`



Updated for macOS 11.0.1, Mac Pros 2008, 2009, 2010, 2012, Big Mac Copyright 2020 by Todd Bruss, See Credits file
