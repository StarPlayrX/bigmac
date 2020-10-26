
---
🍔 Big Mac -> The macOS 11 Big Sur patch tool designed For Mac Pro 2008, 2009, 2010, 2012. Models 3,1 4,1 and 5,1.
---
---
For this patch tool to work, you need to be able to boot APFS volumes directly. For this I highly recommend Dosdude1's APFS ROM Patcher. You only need to run this patcher once but you will need follow the patcher's instruction's precisely. The Dosdude1's APFS ROM Patcher is inside this folder 😎 (smiling face with sunglasses): 


Currently this patch tool does not install Apple's WiFi drivers. I have you a Broadcom BCM43xx 1.0 device. Native AirPort drivers should work. This card also has Bluetooth 4 on it. This tool also does not install any Video drivers except for MouSSE which enables AMD Radeon drivers on Mac Pro 3,1. Native AMD and Nvidia drivers on Big Sur support Metal out of the box.

Officially supporting Big Sur Developer betas 1, 2, 6, 9 and 10 [Complete installers only]. There were some in-between installers than did not support Penryn CPUs.

Catalina:
If you have not upgraded your Mac Pro yet to Catalina, I recommend that you do that first. You will gain some knowledge of setting up an unsupported Mac and some this readme will make sense. For my Cat-Woman PatchTool v1.0.0 see page https://starplayrx.com/#macpro. Do not run my Cat-Woman patcher on Big Sur, it will cause an issue the legacy HFS.kext. For Dosdude1's Catalina page see http://dosdude1.com/software.html.

Disclaimer:
Before running any of these shell scripts, please back up your important data. This software is provided as is and without warranty.

p.s. I was under the weather when these movies where made. I may re-record them when I get a new Mic.

---
https://starplayrx.com/downloads/preinstall_bigmac.mov
https://starplayrx.com/downloads/postinstall_bigmac.mov
https://starplayrx.com/downloads/recovery_external_usb_bigsur_only.mov
https://starplayrx.com/downloads/disable_sip_and_authenticated_root_bigsur.mov
---
---
🍟 Coming Soon: a completed end-to-end full install video.
---
---
The preinstall patch tool invokes HaxDoNotSeal.dylib to enable the Big Sur installer to work. It also turns off the sealed system volume from occuring.

AMD and NVidia Metal cards are fully supported. Personally AMD does better at 4k@60 using Big Sur. Nvidia will support 4K@30 only. If you have found a hack that enables 4k@60 with Nvidia and it works well enough, please let me know through https://StarPlayrX.com

This patcher contains a preinstall.sh that allows users to run the installer to a JHFS+ disk. When finished, the macOS Installer will format it as an APFS volume.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./preinstall.sh`

Follow the directions then open the Big Sur Mac OS Installer app


PostInstall patches your installation.
The post install for Mac Pro 3,1 fixes AppleHDA Audio, CD/DVD access, and Telemetry that is SSE3 compatible. If you have upgraded your WiFi and Bluetooth to 802.11ac combo card, your WiFi and BT4 should work out of the box. USB2, USB3, and USBC all work out of the box on Mac Pro with Big Sur. If you would like something added, you can contact me through https://StarPlayrX.com

Known USB 2.0 Issue:
USB 2.0 Keyboard, Mouse or Trackpad need to be plugged in prior to booting. After Big Sur is running and you attempt to unplug them and re-plug them in, those devices will fail to work. This seems to be something that  broke. If you have a USB 3.0 PCIe card, your USB 2.0 devices the devices will be hot pluggable. A USB 3.0 Hub may work as well.

Known USB 1.0 Issue:
This issue I found with all my MAME keyboard, mouse, joysticks, arcade buttons spinners and trackballs. Under Big Sur they will power on but will be inoperarable under Big Sur. This again is something I believe  broke. It doesn't matter if they were plugged in to USB 3.0 PCIe card either. MAME / Arcade input devices are currently problem on Big Sur. Workaround: I highly recommend Mojave for SDL MAME.

This patcher contains a postinstall shell script.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./postinstall.sh`


Future plans
Patched WiFi option for other Broadcom cards.

---
🥨 MacEleven is coming soon. Unsealed and APFS snapshot free installs for Supported Intel Macs!
---
---
From a Big Sur recovery disk [ This hack only works with Big Sur Recovery volumes. ]

You will want to run

`csrutil disable`

and if possible

`csrutil authenticated-root disable`

You can do this by mounting a Big Sur recovery volume, clone the DMG using ASR to an external USB drive:

`diskutil list`

get the disk# (from the Big Sur installation).

`sudo diskutil mountDisk disk#`

open terminal and type `open /Volumes` Look for 'Recovery' mount. Inside a UUID folder, it will have the DMG that you are looking for to create a recovery USB disk. 

`sudo asr -s /path/to/dmg -t /path/to/external/usb/drive --erase --noverify`

Then reboot using the option key and select the yellow USB drive labelled `EFI`

use `cmd-v` when selecting if you want to see that it is loading.
