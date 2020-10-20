
Updated for Big SIr Developer Beta 10 [ Clean Install ]. Introducing Big Mac 🍔 Burgers and Fries 🍟 Designed For Mac Pro (Early 2008). Should also work for Mac Pro 2009, 2010, 2012. 3,1 4,1 5,1. 

Currently this patch tool does not install Apple's WiFi drivers. I have you a Broadcom BCM43xx 1.0 device. Native AirPort drivers should work. This card also has Bluetooth 4 on it. It also does not install Video drivers except for MouSSE which enables AMD Radeon drivers on Mac Pro 3,1.

Supporting developer betas 1, 2, 6, 9 and 10 [Complete installers only].

Catalina:
If you have not upgraded your Mac Pro yet to Catalina, I recommend that you do that first. You will gain some knowledge of setting up an unsupported Mac and some this readme will make sense. For my Cat-Woman PatchTool v1.0.0 see page https://starplayrx.com/#macpro. Do not run my Cat-Woman patcher on Big Sur, it will cause an issue the legacy HFS.kext. For Dosdude1's Catalina page see http://dosdude1.com/software.html.

Disclaimer:
Before running any of these shell scripts, please back up your important data. This software is provided as is and without warranty.

🍟 This patch tool contains HaxDoNotSeal.dylib to assist with running the Installer from Catalina.

It also contains Dosdude1's APFS ROM Patcher for Macs that do not have the proper firmware to boot APFS volumes.

AMD and NVidia Metal cards are fully supported. Personally AMD does better at 4k@60 using Big Sur. Nvidia will support 4K@30 only. If you have found a hack that enables it and works well enough, please let me know.

This patcher contains a preinstall.sh that allows users to run the installer to a HFS+ disk. When finished, the macOS Installer will format it as an APFS volume.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./preinstall.sh`

Follow the directions then open the Big Sur Mac OS Installer app


PostInstall patches your installation.
The post install for Mac Pro 3,1 fixes AppleHDA Audio, CD/DVD access, and Telemetry that is SSE3 compatible. If you have upgraded your WiFi and Bluetooth to 802.11ac combo card, your WiFi and BT4 should work out of the box. USB2, USB3, and USBC all work out of the box on Mac Pro with Big Sur. If you would like something added, you can contact me through https://StarPlayrX.com

This patcher contains a postinstall shell script.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./postinstall.sh`



Future plans

Digital HDMI out.
Patched WiFi option for other Broadcom cards.
Mac OS Standard HFS disk mounting (This is pre HFS+)

p.s.

You will want to run

`csrutil disable`

and if possible

`csrutil authenticated-root disable`

You can do this by mounting a Big Sur recovery volume, clone the DMG using ASR to an external USB drive:

`diskutil list`

get the disk# (from the Big Sur installation).

`sudo diskutil mountDisk /dev/disk#`

set the terminal to All Disk Access in settings privacy then run this command 

`sudo mount -uw /path/to/target`

open terminal and type "open /Volumes". Look for Recovery partition, it will has the DMG that you are looking for to create a recovery USB disk. 

`sudo asr -s /path/to/dmg -t /path/to/usb --erase --noverify`
