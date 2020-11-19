
## 🍔 bigmac
Big Sur macOS 11 Mac Pro patcher 

Now accepting donations https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC

## 🍞 Fresh! Featuring bigmac.sh = BigMac11USB + bigmac 😃
### Welcome to 🍔 Bigmac's 🥤 USB downloader, 🍟 Installer and 🥞 Configurator
1. Easily create your USB boot disk with the bigmac patcher on its own partition! No need for a thumb drive!
2.  `cd ~/Downloads/bigmac.master`
3. `sudo ./bigmac.sh`
4. Features an automated macOS 11 downloader directly from Apple's CDN.
5. If you already have the Install Big Sur app in your /Applications folder, don't worry, the downloader is optional. 
6. Plus a fully automated USB installer maker with the bigmac patcher on one partion and BigMac11USB on the other.
7. Please do not use thumb drives with the Big Sur External USB disk maker. Only use External SSDs or Hard Drives. Thank you!
8. bigmac.sh also puts -v and -no_compat_check in the boot.plist file for you.
9. Reboot holding the the option key (assuming you have a boot screen)
10. No boot screen? Follow tips at the end of bigmac.sh for 3,1 and 4,1 5,1 respectively.
11. If you don't have a boot screen, bigmac.sh has additional tips at the end.
12. Once booted, open terminal
13. If on a 4k display type cmd + to increase the font size.
14. cd /Volumes/bigmac
15. follow the preinstall.sh track (boot the USB installer first)
16. do the install
17. follow the postinstall.sh track (reboot the USB installer first)

### Future Plans
1. GUI for bigmac.

### When running from an macOS Mojave, Catalina or Big Sur (This method is not ideal)
Only clean installs are supported to an erased Mac OS Extended (Journaled) disk aka JHFS+.

### When running the preinstall.sh from an Install macOS Big Sur USB Disk / BigMac11USB (Ideal)
APFS clean and dirty installs are supported. You can even upgrade older versions of Big Sur!

### Requirements 
1. Mac Pro 2008 - 2012
2. You have MacOS 10.15.x Catalina installed already. (Or do these steps on a supported Mac to an external SSD!)
3. APFS ROM patcher applied. Dosdude1's APFS ROM Patcher is included in the 😎 folder. You only need to flash your Mac's firmware once using his tool. You must put your mac into programming mode. Instructions are included with the tool. This requires time and patience. Don't attempt if you are tired. Do not interrupt.
Your GPU must support Metal. Flashed AMD Cards like the RX 580 8 GB support 4k @ 60 Hz on Big Sur with 4k boot screen! Flashed Nvidia cards with metal will have 4k @ 30 Hz only. If you know how to get 4k@60Hz on NVidia on Big Sur please let us know. If you have 4k on Flashed Nvidia use a 30 Hz port to get a boot screen.
4. 1 - 2 external USB SSDs or hard drives for BigMac11USB or Mac Pro 3,1 no boot screen install.
5. A SSD or Hard drive with 60GB or more. 256GB Recommended.

### How to use createinstallmedia (bigmac.sh now does this for you and more!)
1. Drag `Install macOS Big Sur.app` to the Desktop
2. Open Terminal
3. `cd ~/Desktop/Install\ macOS\ Big\ Sur.app/Contents/Resources`
4. `sudo ./createinstallmedia -v /Volumes/externalUSB`
5. type password
6. Ready to Start.
7. If you wish to continue type (Y) then press return: `y`
8. Erasing disk: 0%... 10%... 20%... 30%... 100%
9. Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
10. For convience copy the `bigmac.master` folder to a separate thumb drive

### How to boot your BigMac11USB
1. Reboot boot using `option key` 
2. At boot screen select the external USB `Install macOS Big Sur` disk. (It will be yellow if it is on an external drive)
3. Wait for the external media to boot up. You may see black screen for a minute or two before any verbose logs kick in.
4. From there open the Terminal. It's under the Utilities menu.
5. `ls -a` to see where stuff is (great invention)
6. `cd /Volumes/bigmac/`
7. Omiting `sudo` follow the `Pre Install track in this guide`
8. Quit the Terminal app
9. Within the window of the booted up install media: select the `Big Sur install icon` and click the `continue` button. Select your disk and agree to the license.
10. After the install is complete, boot from the external USB `Install mac OS Big Sir` disk again.
11. Open Terminal 
12. `cd /Volumes/bigmac/`
13. Omiting `sudo` follow the `Post Install track in this guide`
14. You will need to type in /Volumes/macOSName when it asks, This will be fixed.
15. Select the start up disk
16. If you don't have a boot screen, there are some tips after running the bigmac.sh, which you should have run previously tool.

### Pre Install script (Works with All Macs)
1. Erase a disk using GUID Partition and Mac OS Extended (Journaled) aka JHFS+ (this step may be automated)
2. Open Terminal.app in Utilties
3. `ls -a`
4. `cd /Volumes'
5. `cd whereYouHaveBigMac`
6. `cd bigmac.master` (Do not omit cd'ing to this folder it uses the working directory name to get its resources.)
7. `sudo ./preinstall.sh`
8.  set boot-args to `-no_compat_check amfi_get_out_of_my_way=1 -v` or  `-no_compat_check -v`
9. open the macOS Big Sur installer.app
10. select your newly erased JHFS+ disk.
11. in order to complete the install, Big Sur 11.0.1 RC2 and later will reboot 3 times

### Notes about Big Sur Installs
1. The install process is done in three stages each varying in time.
2. Allow all three stages to fully complete!
3. Mac Pro 3,1 Early 2008 owners will need to stop an infinite loop after the 4th or 5th reboot. Wait until you see a pattern before killing it). Hold option-key to see if you can get to a boot screen between the kernel panics. If all else fails, hold the power button down and then hold down the option-key.
4. the `-v` boot-arg helps monitor the progress.
5. After about 45 - 60 minutes, the installer should be complete.

### Special Notes with Mac Pro Early 2008 and Metal AMD Cards 
1. Big Sur's video drivers are not compatible with the Penryn style CPU
2. The Post Install script using MousSEE to emulate a couple instructions
3. This allows AMD Radeon cards that support Metal to be used on a MP3,1

### Telemetry and Mac Pro Early 2008
1. The telemetry plugin on Big Sur is not compatible with the Penryn style CPU
2. The post install script installs one that is compatible

### Mac Pro Early 2008 Installation Notes
1. In between installer tasks, Big Sur's install runs through 3 complete reboot cycles.
2. If you see kernel panics, or fast reboots after the 5th reboot, you will need to kill the cycle by holding the power button down, or if possible hold down the Option-key see if you can get back to your boot screen.
3. Then you can run the post install script from which method you ran the pre install script.
4. The post install script patches your system and allows it to boot up.

### Pre Install Notes
1. The Preinstall script runs in memory. It does not physically touch the installer. If you reboot before running the Big Sur installer app/task, you will need to run the Preinstall script again. 
2. Because the preinstall script runs in memory, do not attempt run the preinstall twice in the same boot session. This will cause major delays when opening the Big Sur install app/task.

### Post Install script (Required for Mac Pro 3,1 Early 2008)
1. Boot back into your other system using the option key.
3. `ls -a`
4. `cd /Volumes'
5. `cd whereYouHaveBigMac`
6. `cd bigmac.master` (Do not omit cd'ing to this folder it uses the working directory name to get its resources.)
7. from Finder, drag your macOS volume to the Terminal's prompt
8. Press Enter.
9. For Resources press Enter.
10. Wait
11. Press q and Enter to reboot.

### How to turn off System Integrity Protection (this is now automated)
1. Open Terminal in the booted recovery disk (and possibly external USB Big Sur USB installer disks made with createinstallmedia)
2. `csrutil disable`
3. `csrutil authenticated-root disable` (can only be done from Big Sur Recovery disks)
4. Use Start up disk (top left to select your installation)

### bigmac install scripts can run BigMac11USB
1. No need for a thumb drive.
2. Omit the word `sudo`
3. `cd /Volume/bigmac`
4. `ls -a`
5. `./preinstall.sh` then quit terminal and open up the installer.
6. after the install reboot. run `./postinstall.sh` and type in your macOS path `/Volumes/macOSnamehere` I plan to make it easier soon.
7. For more details follow Pre-Install or Post-Install track.

### Videos
1. https://starplayrx.com/downloads/preinstall_bigmac.mov
2. https://starplayrx.com/downloads/postinstall_bigmac.mov
3. https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
4. https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov

### How to clone your system
1. `sudo asr -s /drag/source/here -t /drag/target/here -er -nov`

### Known issues with USB 2.0
1. Input devices that get disconnected do not reconnect. Workaround, get a USB 3.0 PCIe card and for everyday device connect them there. For option-key boot screen boot connect back to USB 2.0
2. USB drive connected to USB 2.0 can connect and reconnect.
3. If using certain thumb drives via USB 3.0 PCIe card, some will disconnect on idle. USB Thumb drives tend to not work on USB 2.0 unless seen at boot time.
4. These issues seem to all be with Big Sur and are beyond's bigmac's currently ability to rectify.

### Known issues with MAME input devices
1. Most of these devices have very old controller boards and use USB 1.0
2. These devices will power on in Big Sur but the system will not use them
3. Workaround, if you are using MAME on your Mac, revert back to Mojave or Catalina. Mojave is recommended for SDL MAME users.
5. These issues seem to all be with Big Sur and are beyond's bigmac's currently ability to rectify.

Updated on November 17, 2020 for macOS 11.0.1 (20B29), Mac Pros 2008, 2009, 2010, 2012, bigmac Copyright 2020 by Todd Bruss, See Credits file

Now accepting donations https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC

🍟 Special thanks to the Unsupported Macs Team!
