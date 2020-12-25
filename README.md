# 🍔 bigmac

Big Sur macOS 11 Mac Pro patcher.

Before you start please read the [Requirements](#%EF%B8%8F-requirements) section. Thank you!

###### 🛑 Please do not disturb   🚧 Work is under construction   🚫 Interuptions stop progress

### 💿 Non Boot Screen Support Coming to bigmac 2.0
* For users who cannot use Option boot
* Will support Internal and External boot disks

### 🔥 The 6 Most Common Issues
1. User did not install Dosdude1's APFS ROM Firmware patch or take the time to do it correctly.
2. ... did not disable SIP using El Capitan macOS 10.11 or newer Recovery OS to execute this simple command: `csrutil disable`
3. ... did not set boot arguments to at least: `nvram boot-args"-no_compat_check"`
4. (Early 2008 Mac Pro / Early 2008 Xserve only) These machines have an incompatible Bluetooth 2.0 (BT2.0+EDR Card) that causes a kernal panic. Future versions will disable the card via sofware and only for Big Sur. 802.11ac / BT4 Combo cards and adapters are cost effective, plus you'll get AirDrop and Handoff support.
5. ... did not read this entire readme file. I try to cover every possible angle and I update this page when new issues are discovered. 
6. ... did not read existing open issues before posting a new issue. I keep a good portion open that are the most common issues found and solved. Issues have a way of repeating themselves. If it's a repeat, more than likely you'll find the correct answer there.

# 🍔 bigmac1.1

<img src="https://swift4me.com/images/splash/bigmac1f.png" width="100%" >

* Includes all latest patches like USB1.1 device support, Airdrop and more!
* Added a new Startup Disk tool to the repo. Created by StarPlayrX.
* Packaged in our classic v1.0 installer format
* A Big Mac is better than a New Mac. Please donate to [NiceMac LLC](https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ)


# 🍦bigmac2.0 secret lab

<img src="https://swift4me.com/images/splash/bigmac2f.png" width="100%" >

* Native Airdrop and Handoff support! Requires BT4LE and 802.11ac
* USB 1.1 Support, special thanks to JackLukem for the tip!*
* FireWire 400 and 800 Hard Drive and SSD Support (booting from FW currently fails)
* Automatic Legacy WiFi 802.11n Patch (will also have a custom override using ./postinstall -L)
* Legacy Bluetooth2 disabler, Bluetooth4 enabler (with card or BT4LE dongle)
* Easier to use
* Download Full Installers from the App Store
* Optional Apple Developer Seed Support Downloads
* Wicked Installer Boot System / Light Speed Emergency Disk
* Ultra Fast Boot of a Full OS
* Improved Boot Screen Support

## ⚒️ Requirements 
* Mac Pro 2008 - 2012. Xserves will be officially supported soon.
* SIP, a.k.a. System Integrity Protection, must be disabled otherwise the patches may not fully function. To do so:
   * [Download OS X El Capitan 10.11](http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg).
   * Open the DMG and run the package.
   * Create a installation medium from El Capitan: `sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app`
   * Reboot and hold down the option key. (No boot screen? Remove all drives and reboot, and wait for the installer to boot up.)
   * Open Terminal. Execute `csrutil disable`.
   * While you are there set some boot args: `nvram boot-args="-no_compat_check"`.
   * add -v if you want verbose boot like so: `nvram boot-args="-v -no_compat_check"`.
   * These steps will be automated in bigmac2, but it is good to have a supported disk for emergencies.
* Boot screen. If you don't have a boot screen, I'll leave that adventure up to you. Note: bigmac2 will have a non-boot screen option.
* [Download APFS ROM patcher by dosdude1](http://dosdude1.com/apps/APFS%20ROM%20Patcher.zip). Then enter password: `apfs` and follow the instructions.
* Your GPU must support Metal. I highly recommend this GPU: Radeon RX 580 8 GB Mac Edition on eBay for $299
* 1 external USB SSD or hard drive. Fast brand name flash drives like the Samsung Fit will work. Ultra slow generic thumb drives are not supported.
* For the actual installation, an SSD or hard drive with 60GB or greater. 256GB recommended.

## 📀 How to boot a USB (Recommend a Video Card with a Mac Boot ROM for now)
1. Be sure your Mac Pro can boot APFS volumes directly. There is an [APFS ROM Patch](http://dosdude1.com/apps/APFS%20ROM%20Patcher.zip) for Mac Pro 3,1s.
2. Be sure to disable System Integrity Protection as soon as possible (`csrutil disable ; csrutil authenticated-root disable`).
3. Plug a USB 2.0 keyboard and pointing device directly into your Mac Pro's USB 2.0 ports.
4. Plug the bootable installer into your Mac Pro.
5. Press and hold the Option (Alt) ⌥ key immediately after turning on or restarting your Mac Pro.
6. Release the Option key when you see a gray boot screen showing your bootable volumes.
7. Select the volume containing the bootable installer. Then click the up arrow or press Return. 
8. Choose your language, if prompted.
9. Open the Terminal.
10. Execute `/Volumes/bigmac/preinstall.sh`, and quit Terminal.
11. Select Install macOS Big Sur from the Utilities window, then click Continue and follow the onscreen instructions.

## 🥜 BigMac's Workflow in a Nut Shell 
1. Workflow -> [Download Big Sur](http://swcdn.apple.com/content/downloads/00/55/001-86606-A_9SF1TL01U7/5duug9lar1gypwunjfl96dza0upa854qgg/InstallAssistant.pkg) -> Create USB Installer (`sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume`)
2. Create your unpatched USB installer disk with bigmac on another partiton with `./bigmac.sh`
3. Execute `~/Downloads/bigmac.master/bigmac.sh`
4. Reboot -> hold down OPTION key -> macOS Big Sur Installer
5. Workflow -> Boot USB -> Preinstall.sh -> Install -> Postinstall.sh
6. Boot the USB installer, from its Terminal type:
7. Execute `/Volumes/bigmac/preinstall.sh`
8. Wait for the install is fully completed (hint: it takes 3 stages to complete.)
9. Boot the USB installer, from its Terminal type:
10. Execute `/Volumes/bigmac/postinstall.sh`

### 🔨 Pre Install Track, Before you open the Big Sur Installer (Works with All Macs)
1. Boot up the Install macOS Big Sur USB Disk (Don't have it? Execute `sudo ./bigmac.sh`).
2. Execute `/Volumes/bigmac/preinstall.sh`.
8. set boot-args to `-no_compat_check -v`.
9. Quit the Terminal. Open the big Sur installer app.
10. Big Sur installs in three stages.

### 🛠 Post Install Track, Required for Mac Pro 3,1
1. Boot up the Install macOS Big Sur USB Disk (Don't have it? Run `sudo ./bigmac.sh`)
2. Execute `cd /Volumes/bigmac`.
4. Type `./postinstall.sh` and type in the volume name of the install you just did (e.g., `/Volumes/Macintosh\ HD` (This will be improved in a future version); You may have to use `ls -al` in volumes to get the name before hand. (e.g., `./postinstall.sh /Volumes/Macintosh\ HD`)
5. Quit the Terminal and select your startup disk.

### 📝 Notes about Big Sur Installs
1. The install process is done in three stages each varying in time.
2. Allow all three stages to fully complete!
3. Mac Pro 3,1 Early 2008 owners will need to stop an infinite loop after the 4th or 5th reboot. Wait until you see a pattern before killing it). Hold option-key to see if you can get to a boot screen between the kernel panics. If all else fails, hold the power button down and then hold down the option-key.
4. the `-v` boot-arg helps monitor the progress.
5. After about 45 - 60 minutes, the installer should be complete.

### 🎸 Special Notes with Mac Pro Early 2008 and Metal AMD Cards 
1. Big Sur's AMD video drivers are not compatible with the Penryn style CPU. 
2. The Post Install script using MousSEE to emulate a couple instructions.
3. This allows AMD Radeon cards that support Metal to be used on a MacPro3,1.
4. Ironically, my AMD Radeon RX 580 Card works completely fine without a 4.2 emulator running in both Big Sur and Catalina. It even supports 4K@60Hz and a 4K boot screen with it being flashed. Simply awesome.

### 📺 Telemetry and Mac Pro Early 2008
1. The telemetry plugin on Big Sur is not compatible with the Penryn style CPU.
2. The post install script installs one that is compatible.

### 📓 Mac Pro Early 2008 Installation Notes
1. In between installer tasks, Big Sur's install runs through 3 complete reboot cycles.
2. If you see kernel panics, or fast reboots after the 5th reboot, you will need to kill the cycle by holding the power button down, or if possible hold down the Option-key see if you can get back to your boot screen.
3. Then you can run the post install script from which method you ran the pre install script.
4. The post install script patches your system and allows it to boot up.

### 📕 Pre Install Notes
1. The Preinstall script runs in memory. It does not physically touch the installer. If you reboot before running the Big Sur installer app/task, you will need to run the Preinstall script again. 
2. Because the preinstall script runs in memory, do not attempt run the preinstall twice in the same boot session. This will cause major delays when opening the Big Sur install app/task.

### 🚨 How to turn off System Integrity Protection (this is now built into preinstall.sh)
1. Open Terminal in the booted recovery disk (and possibly external USB Big Sur USB installer disks made with `createinstallmedia`).
2. Execute `csrutil disable` (Can be done on macOS 10.11 and later on Recovery, Installer Disks).
3. Execute `csrutil authenticated-root disable` (can only be done from Big Sur Recovery disks).
3. Use Start up disk (top left to select your installation).

## 📹 Videos
1. https://starplayrx.com/downloads/preinstall_bigmac.mov
2. https://starplayrx.com/downloads/postinstall_bigmac.mov
3. https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
4. https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov

## 👽 How to clone your system
* Execute `sudo asr -er -nov -s /Volumes/'yourSourceName' -t /Volumes/'yourTargetName'`

## Known issues
* Only true USB 2.0 keyboards, mice and trackpads are supported by the installer. This limitation will be fixed in bigmac2 but not for 1.x. Many keyboards and mice say they are 2.0 but you can find out for show in about this mac under USB and see what it is really using. Note USB 2.0 ports will support 1.1 usually but on Big Sur Apple removed the drivers. The OS post install shell script supports USB 1.1 but currently the installer does not. We will be correcting this limitation in bigmac2.

### USB 2.0
* Input devices that get disconnected do not reconnect. Workaround, use a USB 2.0/3.0 hub. Plug that into a Mac USB port and plug your input devices into the hub. This has been tested. USB 3.0 PCIe cards will also work but not at boot time.
* USB storage devices are hotswapped with issue.
* Certain thumb drives via USB 3.0 PCIe card, some will disconnect on idle. USB Thumb drives tend to not work on USB 2.0 unless seen at boot time.

### 🕹 MAME input devices
* USB 1.1 will be supported in bigmac2.

## 🖥 Big Mac Contributors

* ASentientBot, BarryKN, JackLukeM, Syncretic, Exvision, Ritchie333, seyoon20087
* See Credits file for our list of contributors

## 🍺 Big Unsupported Mac Influencers

* Dosdude1, Netkas, MacVidCards

## ☝️ One More Thing

* Updated on December 21, 2020 for macOS 11.1 (20C69)
* Proudly Supporting Mac Pros 2008, 2009, 2010, 2012 (3,1 4,1 5,1) and equivalent Xserves
* Do you have an old Mac Pro or Xserve and would like to Donate it? Please let us know, thank you!
* bigmac1.1 Copyright 2020 by Todd Bruss | NiceMac LLC
* A Big Mac is better than a New Mac. Please donate to [NiceMac LLC](https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ)


If you ever read the [Software License Agreement](https://www.apple.com/legal/sla/docs/macOSBigSur.pdf), macOS Big Sur is to be run on Apple branded hardware.
