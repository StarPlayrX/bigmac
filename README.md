
🍔 bigmac Mac Pro patcher 

Now accepting donations via https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC | StarPlayrX | Purpose: bigmac

### When running from an OS
Only clean installs are supported to an erased Mac OS Extended (Journaled) disk.


## Prerequisite (Terminal, set sudo nvram boot-args='-no_compat_check')
1. In order to do this inside macOS, SIP must be disabled
2. In Terminal type `csrutil status` to check if SIP is enabled.
3. If System Integrity Protection is not disabled, set your boot-args Recovery or an Installer disk.
4. You can also set your boot-args from an Installer disk. 
5. set your boot arguments to at least `-no_compat_check`
6. recommended boot-args `-no_compat_check amfi_get_out_of_my_way=1 -v`
7. to set boot-args from a Recovery or Install disk : `nvram boot-args='-no_compat_check amfi_get_out_of_my_way=1 -v'`
8. to set boot-args from a system with SIP disabled: `sudo nvram boot-args='-no_compat_check amfi_get_out_of_my_way=1 -v'`
9. how to check your boot-argments `nvram -p | grep boot-args`
10. you should see something like this `boot-args    -no_compat_check amfi_get_out_of_my_way=1 -v`
11. If you cannot set your boot-args, recommend creating a bootable installer Catalina patch disk from http://dosdude1.com/catalina/
12. With it you can set your boot-args very easily


## Update createinstallmedia is now preferred (APFS Supported!)
1. Drag `Install macOS Big Sur.app` to the Desktop
2. Open Terminal
3. `cd ~/Desktop/Install\ macOS\ Big\ Sur.app/Contents/Resources`
4. `sudo ./createinstallmedia -v /Volumes/externalUSB`
5. type password
6. Ready to Start.
7. If you wish to continue type (Y) then press return: `y`
8. Erasing disk: 0%... 10%... 20%... 30%... 100%
9. Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
10. When complete
11. For convience Copy the `bigmac.master` folder to a separate thumb drive

## Boot the  `Install macOS Big Sur` USB Drive
1. Reboot boot using `option key` 
2. At boot screen select `Install macOS Big Sur`  (It will be yellow if it is on an external drive)
3. You can also try `sudo bless -mount '/Volumes/Install macOS Big Sur' -setBoot --nextonly`
4. Wait for it the external media to boot up.
5. From there open the terminal
6. `cd /Volumes/pathToBigMacDisk/`
7. `cd bigMaster.master`
8. Omiting `sudo` follow the `Pre Install track in this guide`
9. Quit the Terminal app
10. Open the Big installer app. Here you can select previous installations of Big Sur betas and upgrade them!
11. Complete the install
12. Boot from the `Install mac OS Big Sir` disk again.
13. Open Terminal 
14. `cd /Volumes/pathToBigMacDisk/`
15. `cd bigMaster.master`
16. Omiting `sudo` follow the `Post Install track in this guide`
19. Select the start up disk


## Requirements 
1. Mac Pro 2008 - 2012
2. You have MacOS 10.15.x Catalina installed already. (Or do these steps on a supported Mac to an external SSD!)
3. MacOS 11.0.1 Big Sur full installer app (RC2 or public release and later)
4. APFS ROM patcher applied. Dosdude1's APFS ROM Patcher is included in the 😎 folder. You only need to flash your Mac's firmware once using his tool. You must put your mac into programming mode. Instructions are included with the tool. This requires time and patience. Don't attempt if you are tired. Do not interrupt.
5. Boot screen. I recommend you have a flashed Nvidia or AMD card that supports Metal. Some steps are difficult without one.
6. Your GPU must support Metal. AMD Cards like the RX 580 8 GB support 4k @ 60 Hz on Big Sur with 4k boot screen! Nvidia cards with metal will have 4k @ 30 Hz only. If you have 4k on Nvidia use a 30 Hz port to get a boot screen.
7. 1 - 2 external USB SSDs or hard drives for Recovery or asr disk cloning.
8. A SSD or Hard drive with 60GB or more. 256GB Recommended.


## Pre Install
1. Erase a disk using GUID Partition and Mac OS Extended (Journaled) aka JHFS+ (this step may be automated)
2. Open Terminal.app in Utilties 
3. `cd bigmac.master`
4. `sudo ./preinstall.sh`
5.  set boot-args to `-no_compat_check amfi_get_out_of_my_way=1 -v` or  `-no_compat_check -v`
6. open the macOS Big Sur installer.app
7. select your newly erased JHFS+ disk.
8. in order to complete the install, Big Sur 11.0.1 RC2 and later will reboot 3 times
9. on the 4th or 5th reboot, once you see unsupported CPU, hold down the power button. sometimes holding down the option-key works. (this will repeat endlessly on Mac Pro 3,1)


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
2. copy `disk#s#` (let's say it is `disk2s3` for this exercise)
3. `diskutil mount disk2s3`
4. `open /Volumes/Recovery`
5. Arrow down on the weird UUID tagged folder that looks like this '13540289-83B3-3105-8EC7-B05C342DB382' (this id is unique)
6. `sudo asr -s /Drag/BaseSystem.dmg/Here -t /Volumes/externalUSB_name --er --nov`
7. disk must be around 3GB or higher.


## How to turn off System Integrity Protection
### aka SIP from the Recovery disk (you can try a Big Sur USB installer disk as well)
1. Open Terminal in the booted recovery disk
2. `csrutil disable`
3. `csrutil authenticated-root disable` (can only be done from Big Sur Recovery disks)
4. Use Start up disk (top left to select your installation)


## Big Mac install scripts can run from a Recovery or Installer disk
1. Use a second USB drive and put Big Mac on it.
2. Omit the word `sudo`
3. `cd /Volumes`
4. `ls -a`
5. `cd bigmac.master`
6. Follow Pre-Install or Post-Install track.


## Videos
1. https://starplayrx.com/downloads/preinstall_bigmac.mov
2. https://starplayrx.com/downloads/postinstall_bigmac.mov
3. https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
4. https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov


## How to clone your system 
### This can help remove locked apfs snapshots easily
1. `sudo asr -s /drag/source/here -t /drag/target/here -er -nov`



Updated for macOS 11.0.1, Mac Pros 2008, 2009, 2010, 2012, Big Mac Copyright 2020 by Todd Bruss, See Credits file

Now accepting donations via https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC | StarPlayrX | Purpose: bigmac

🍟 Special thanks to the Unsupported Macs Team!
