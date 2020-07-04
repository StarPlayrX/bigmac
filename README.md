Introducing Big Mac 🍔 Burgers and Fries 🍟 For Mac Pro (Early 2008)

💻 This SPX Big Mac PatchToolX may also for work for Mac Pro 2009, 2010 and 2012.

Testing is underway for Mac Book Pro 2009. If successful, will add it to the list of supported Macs

Turn your Mac Pro into a Big Mac and run Big Sur on unsupported Apple branded hardware

Disclaimer & Catalina: If you have not upgraded your Mac Pro yet to Catalina, I recommend that you do that first. You will gain some knowledge of setting up an unsupported Mac and some this readme will make sense. Before running any of these shell scripts, please back up your important data. This software is provided as is and without warranty. For my Cat-Woman PatchTool v1.0.0 see page https://starplayrx.com/#macpro. Do not run my Cat-Woman patcher on Big Sur, it will cause an issue the legacy HFS.kext. For Dosdude1's Catalina page see http://dosdude1.com/software.html. Good Luck, Happy Hacking and Your Milage May Vary. I hope this tool helps you.

🖥 This command line interface patch tool works on a 2008 Mac Pro 3,1. Mac Pro 2009, 2010, 2012 users may also benefit.

Credits

Hax.dylib by ASentientBot.
APFS ROM Patcher by DosDude1.
SPX Big Mac PatchToolX by StarPlayrX.
Kexts created by Apple.
Credits by no means endorse this product.

This patch tool contains Hax.dylib to assist with running the Installer from Catalina. It also contains APFS ROM Patcher for Macs that do not have the proper firmware to boot APFS volumes.

This patch tool currently does not include an SSE Emulator. Support for this may be added based on demand. This tool assumes you have an NVidia graphics card that supports metal. These cards include Nvidia GTX 680 2GB, 4GB, and Kepler Titan 6GB. Kepler Black Titan is currently not supported. You may be able to get it supported through MacVidCards who does an awesome job flashing non 680 cards.

PreInstall allows you to run the Big Sur beta 1 installer from Catalina:
This patcher constains a preinstall.sh that allows users to run the installer to a HFS+ disk. The installer will erase it as an APFS volume.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./preinstall.sh`

IMPORTANT:
Always install with `-v`. You will want to catch the apfs_sealvolume command and turn off the power to your Mac, or if installing to external SSD, simply unplug the SSD. The apfs_sealvolume command is displayed in the console and will be 2nd line from the bottom. Apple tries to create a sealed snapshot along with an encrypted boot disk. On a Mac Pro 3,1 and possibly other unsupported Macs, this will lead to kernal panics with CoreCrpyto or endless zombie corpses. This unorthodox method eliminates this issue. During preinstall you can add `-v` along with `-no_compat_check` to your boot args via the `preinstall.sh` tool

PostInstall patches your installation.
The post install for Mac Pro 3,1 fixes AppleHDA Audio, CD/DVD access, and Telemetry that is SSE compatible. If you have upgraded your WiFi and Bluetooth to 802.11ac combo card, your WiFi and BT4 should work out of the box. USB2, USB3, and USBC all work out of the box on Mac Pro with Big Sur. If you would like something added, you can contact me through https://StarPlayrX.com

This patcher contains a postinstall shell script.

Using the terminal, cd to the bigmac directory.

usage

`sudo ./postinstall.sh`



Future plans

Digital HDMI out.
Patched WiFi option for other Broadcom cards.
Mac OS Standard HFS disk mounting (This is pre HFS+)
