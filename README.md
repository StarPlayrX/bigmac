# 🍔 bigmac

Big Sur macOS 11 Mac Pro patcher 


## Workarounds & What Not

<b>News</b> If you have the original Bluetooth2 card, you will need to remove it to get Big Sur to boot. This includes the installer and the installation process itself and the full OS. This problem has been identified by our users. The setup is the following: an original Mac Pro 3,1 with a Bluetooth 2.0 card and an original AirPort Extreme (802.11g/n) card. An immediate solution is being worked on to patch the OS.

<b>If you cannot disable SIP</b> [Download El Capitan here](http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg) and use its recovery disk. After installing its .pkg file, run this command: Format a disk using MacOS Extended (Journaled) aka JHFS+. Run this in terminal `sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --volume /Volumes/Untitled` Option boot-key boot El Cap. Open Terminal and run `csrutil disable`

<b>New version will be released Q1 2021</b> (It will be a big departure for Big Mac)
  
<b>USB 2.0 Workaround for Input Devices</b>: There is a flaw in Big Sur and Mac Pros with USB 2.0 keyboards, mice and trackpads. These input devices do not reconnect if disconnected. A solution is to use a USB 2.0 Hub connected to a USB 2.0 port. [I have confirmed that this works.](https://appleinsider.com/articles/20/07/17/apple-has-fixed-the-usb-20-connection-bug-in-catalina-but-not-in-big-sur-yet) USB 3.0 PCIe cards will also work, but not at boot time.

<b>Legacy USB Injector or IOKit USB Map</b>, I have not gotten a Legacy USB Injector to work reliably on Big Sur yet. If you have this working on a Mac Pro 3,1 please let me know.

<b>System.kext</b> and all of its Extensions currently do not load. Catalina's do not load either.

<b>Firewire and Handoff</b> is currently not working but I am looking into both of these issues.

<b>Firewire Update:</b> In the next version, I've been able to get ancient FireWire 400 Storage devices to work as well as a Sony Firewire 400 Camcorder. I do not have the Classic iSight Firewire Camera working yet. I have been able to get video to work on the FW iSight Cam in the past but not the mic. Do not have Firewire networking working yet. These things are a low priority. If you have third party Firewire Audio device, you will need to get updated drivers for Big Sur.

<b>A Legacy WiFi Patch</b> will be added to Big Mac in the next release.

<b>BMO One</b> For users who cannot get the current installer to work, there's BMO1 for R&D and testing purposes. BMO One is an experiemental cloud based clean install. [Download BMO1](https://starplayrx.com/downloads/bigmac/BMO1.dmg). Format a disk using MacOS Extended Journaled. Run this in Terminal `sudo asr -s ~/Downloads/BMO1.dmg -er -nov -t /Volumes/changeMe` When finished cloning. Run bigmac's post install patch `cd bigmac.master; sudo ./postinstall.sh` Tip: Do not mount or double click BMO1.dmg while cloning. When finished, put the BMO1 disk image in the Trash. BMO One is available for a limited time only. It will be discontinued on January 1, 2021.

<b>One More Thing</b> A Big Mac is better than a New Mac. [Please donate.](https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ) Thank you!

### Requirements 
1. Mac Pro 2008 - 2012
1. SIP or System Integrity Protection must be disabled. If it is on booting the installer will Panic.
2. Boot screen. If you don't have a boot screen, support will not be provided. I'll leave that adventure up to you.
3. Native APFS Boot support. For a limited time, Dosdude1's APFS ROM Patcher is included in the 😎 folder (this will be removed from the repo soon, and will be included as a download option instead). You can donate to Dosdude1 for this ROM patch [here](https://www.paypal.com/donate?token=09J0A0Ry8_2hv_jV5WzK9MUx9JUzMgdvN-PS2ibJkYnPS6-OpKhKcSz35mxCtm7EGv-f9ZbP2aFDyAFc).
4. Your GPU must support Metal. I highly recommended this GPU: Radeon RX 580 8 GB on eBay for $299
5. 1 external USB SSD or hard drive. Thumb drives are not supported.
6. For the actual installation, an SSD or hard drive with 60GB or greater. 256GB recommended.

## How to boot a USB (Requires a Video Card with a Mac Boot ROM)
1. Be sure your Mac Pro can boot APFS volumes directly. There is an APFS ROM Patch for Mac Pro 3,1s.
2. Be sure to disable System Integrity Protection as soon as possible (`csrutil disable ; csrutil authenticated-root disable`).
3. Plug a USB 2.0 keyboard and pointing device directly into your Mac Pro's USB 2.0 ports.
4. Plug the bootable installer into a Mac Pro that is connected to the Internet.
5. Press and hold the Option (Alt) ⌥ key immediately after turning on or restarting your Mac.
6. Release the Option key when you see a gray boot screen showing your bootable volumes.
7. Select the volume containing the bootable installer. Then click the up arrow or press Return. 
8. Choose your language, if prompted.
9. Open the Terminal.
10. Execute `cd /Volumes/bigmac; .preinstall.sh`, and quit Terminal.
11. Select Install macOS Big Sur from the Utilities window, then click Continue and follow the onscreen instructions.

Legacy USB 2.0 for keyboard and mouse devices is not working 100%. If you leave them plugged into a USB 2.0 port, they will work. If you disconnect them, they won't reconnect. This is a problem with Big Sur which Apple introduced on their own. A workaround is use a USB3.0 PCIe card but this only works when the system is booted, not from a cold start. USB 3.0 hubs plugged into a USB 2.0 port may also work. A patch may be implemented to take care of this issue.

Note: Option boot using a boot screen requires a keyboard in directly into the machine and not a PCIe card. Bluebooth keyboards do not catch up in time and PCIe cards don't work without an OS. There used to be a a Bluetooth fix in NVRAM for this. If I locate the fix, will update.



## BigMac's Workflow in a Nut Shell 🥜
1. Workflow -> Download Big Sur -> Create USB Installer
2. Create your unpatched USB installer disk with bigmac on another partiton with `./bigmac.sh`
3. Execute `cd ~/Downloads/bigmac.master`
4. Execute `./bigmac.sh`
5. Reboot -> hold down OPTION key -> macOS Big Sur Installer
6. Workflow -> Boot USB -> Preinstall.sh -> Install -> Postinstall.sh
7. Boot the USB installer, from its Terminal type:
8. Execute `cd /Volumes/bigmac`
9. Execute `./preinstall.sh`
10. Wait for the install is fully completed (hint: it takes 3 stages to complete.)
11. Boot the USB installer, from its Terminal type:
12. Execute`cd /Volumes/bigmac`
13. Execute`./postinstall.sh`

### Pre Install Track, Before you open the Big Sur Installer (Works with All Macs)
1. Boot up the Install macOS Big Sur USB Disk (Don't have it? Execute `sudo ./bigmac.sh`)
2. Execute `cd /Volumes/bigmac`
7. Execute `./preinstall.sh`
8. set boot-args to `-no_compat_check -v`
9. Quit the Terminal. Open the big Sur installer app.
10. Big Sur installs in three stages

### Post Install Track, Required for Mac Pro 3,1
1. Boot up the Install macOS Big Sur USB Disk (don't have it? run `sudo ./bigmac.sh`)
2. Execute `cd /Volumes/bigmac`
4. Type `./postinstall.sh` and type in the volume name of the install you just did (e.g., `/Volumes/Macintosh\ HD` (This will be improved in a future version), You may have to use `ls -a` in volumes to get the name before hand. (e.g., `./postinstall.sh /Volumes/Macintosh\ HD`)
5. Quit the Terminal and select your startup disk.

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
1. Open Terminal in the booted recovery disk (and possibly external USB Big Sur USB installer disks made with createinstallmedia).
2. Execute `csrutil disable`
3. Execute `csrutil authenticated-root disable` (can only be done from Big Sur Recovery disks).
4. Use Start up disk (top left to select your installation).

### Videos
1. https://starplayrx.com/downloads/preinstall_bigmac.mov
2. https://starplayrx.com/downloads/postinstall_bigmac.mov
3. https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
4. https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov

### How to clone your system
* Execute `sudo asr -s /drag/source/here -t /drag/target/here -er -nov`

### Known issues with USB 2.0
1. Input devices that get disconnected do not reconnect. Workaround, get a USB 3.0 PCIe card and for everyday device connect them there. For option-key boot screen boot connect back to USB 2.0
2. USB drive connected to USB 2.0 can connect and reconnect.
3. If using certain thumb drives via USB 3.0 PCIe card, some will disconnect on idle. USB Thumb drives tend to not work on USB 2.0 unless seen at boot time.
4. These issues seem to all be with Big Sur and are beyond's bigmac's currently ability to rectify.

### Known issues with MAME input devices
1. Most of these devices have very old controller boards and use USB 1.0
2. These devices will power on in Big Sur but the system will not use them
3. Workaround, if you are using MAME on your Mac, revert back to Mojave or Catalina. Mojave is recommended for SDL MAME users.
4. These issues seem to all be with Big Sur and are beyond's bigmac's currently ability to rectify.

### 🍟 Special thanks to Dosdude1, ASentientBot, BarryKN, JackLukeM, Parrotgeek

## The Unsupported Macs Team, you are the Best

Updated on November 28, 2020 for macOS 11.0.1 (20B29), Mac Pros 2008, 2009, 2010, 2012, bigmac Copyright 2020 by Todd Bruss | NiceMac LLC

A Big Mac is better than a New Mac. Please donate to [NiceMac LLC](https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ)
