## 🍔 bigmac

Big Sur macOS 11 Mac Pro patcher 

If this software is useful in any way, please donate to https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC

<b>New version will be released Q1 2021</b> (It will be a big departure for Big Mac)

## Known issues

<b>USB 2.0 Workaround for Input Devices</b>: There is a flaw in Big Sur and Mac Pros with USB 2.0 keyboards, mice and trackpads. These input devices do not reconnect if disconnected. A solution is to USB 2.0 Hub connected to a USB 2.0 port. I have confirmed that this works. https://appleinsider.com/articles/20/07/17/apple-has-fixed-the-usb-20-connection-bug-in-catalina-but-not-in-big-sur-yet USB 3.0 and USBC 3.1 PCIe cards will also work, but not at boot time.

<b>Legacy USB Injector or IOKit USB Map</b>, I have not gotten a Legacy USB Injector to work reliably on Big Sur yet. If you have this working on a Mac Pro 3,1 please let me know.

<b>System.kext</b> and all of it Extensions currently do not load. Catalina's do not load either.

<b>Firewire and Handoff</b> is not currently working but I am looking into both of these issues.

<b>Old AMD Cards</b> Users with older AMD cards are having trouble getting any type of USB or macOS Installer to work. If you have an old AMD Card, you can use BigMac on a supported Mac, run through the same steps and you would normally to an External USB. After the instnall ignore permissions on the volume, then clone it back to your system using Carbon Copy Cloner or ASR. The post patcher will install mousSSE.

<b>One More Thing</b> A Big Mac is better than a New Mac. Please donate. Thank you! https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ

### Requirements 
1. Mac Pro 2008 - 2012 
2. Boot screen. If you don't have a boot screen, support will not be provided. I'll leave that adventure up to you.
3. Native APFS Boot support. For a limited time, Dosdude1's APFS ROM Patcher is included in the 😎 folder (this will be removed from the repo soon, and will be included as a download option instead. You donate to Dosdude1 for this ROM patch here: https://www.paypal.com/donate?token=09J0A0Ry8_2hv_jV5WzK9MUx9JUzMgdvN-PS2ibJkYnPS6-OpKhKcSz35mxCtm7EGv-f9ZbP2aFDyAFc)
4. Your GPU Must Support Metal. I highly recommended this GPU: Radeon RX 580 8 GB on eBay for $299
5. 1 external USB SSD or hard drive. Thumb drives are not supported.
6. For the actual installation, A SSD or Hard drive with 60GB or more. 256GB Recommended.

## How to boot a USB (Requires a Video Card with a Mac Boot ROM)
1. Be sure your Mac Pro can boot APFS volumes directly. There is an APFS ROM Patch for Mac Pro 3,1s.
2. Be sure to disable System Integrity Protection as soon as possible.
3. Plug a USB 2.0 keyboard and pointing device directly into your Mac Pro's USB 2.0 ports.
4. Plug the bootable installer into a Mac that is connected to the internet and compatible with the version of macOS you're installing.
5. Press and hold the Option (Alt) ⌥ key immediately after turning on or restarting your Mac.
6. Release the Option key when you see a gray boot screen showing your bootable volumes.
7. Select the volume containing the bootable installer. Then click the up arrow or press Return. 
8. Choose your language, if prompted.
9. Open the Terminal
10. `cd /Volumes/bigmac; .preinstall.sh`
11. Select Install macOS (or Install OS X) from the Utilities window, then click Continue and follow the onscreen instructions.

Legacy USB 2.0 for keyboard and mouse devices is not working 100%. If you leave them plugged into a USB 2.0 port, they will work. If you disconnect them, they won't reconnect. This is a problem with Big Sur which Apple introduced on their own. A workaround is use a USB3.0 PCIe card but this only works when the system is booted, not from a cold start. USB 3.0 hubs plugged into a USB 2.0 port may also work. A patch may be implemented to take care of this issue.

Note: Option boot using a boot screen requires a keyboard in directly into the machine and not a PCIe card. Bluebooth keyboards do not catch up in time and PCIe cards don't work without an OS. There used to be a a Bluetooth fix in NVRAM for this. If I locate the fix, will update.



## BigMac's Workflow in a Nut Shell 🥜
1. Workflow -> Download Big Sur -> Create USB Installer
2. Create your unpatched USB installer disk with bigmac on another partiton with `./bigmac.sh`
3. `cd ~/Downloads/bigmac.master`
4. `./bigmac.sh`
5. Reboot -> hold down OPTION key -> macOS Big Sur Installer
6. Workflow -> Boot USB -> Preinstall.sh -> Install -> Postinstall.sh
7. Boot the USB installer, from its Terminal type:
8. `cd /Volumes/bigmac`
9. `./preinstall.sh`
10. Wait for the install is fully completed (hint: it takes 3 stages to complete.)
11. Boot the USB installer, from its Terminal type:
12. `cd /Volumes/bigmac`
13. `./postinstall.sh`

### Pre Install Track, Before you open the Big Sur Installer (Works with All Macs)
1. Boot up the Install macOS Big Sur USB Disk (don't have it? run `sudo ./bigmac.sh`)
2. `cd /Volumes/bigmac`
7. `./preinstall.sh`
8. set boot-args to `-no_compat_check -v`
9. Quit the Terminal. Open the big Sur installer app.
10. Big Sur installs in three stages

### Post Install Track, Required for Mac Pro 3,1
1. Boot up the Install macOS Big Sur USB Disk (don't have it? run `sudo ./bigmac.sh)
2. `cd /Volumes/bigmac'
7. `./postinstall.sh`
8. type in the volume name of the install you just did `/Volumes/macosnamehere` (This will be improved in a future version), You may have to use `ls -a` in volumes to get the name before hand.
9. Quit the Terminal. Select your startup disk.

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

### How to turn off System Integrity Protection (this is now built into preinstall.sh)
1. Open Terminal in the booted recovery disk (and possibly external USB Big Sur USB installer disks made with createinstallmedia)
2. `csrutil disable`
3. `csrutil authenticated-root disable` (can only be done from Big Sur Recovery disks)
4. Use Start up disk (top left to select your installation)

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

If this software is useful in any way, please donate to https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ NiceMac LLC

## 🍟 Special thanks to the Unsupported Macs Team!
