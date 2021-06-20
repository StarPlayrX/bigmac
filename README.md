# 🍔 bigmac alpha builds

Big Sur macOS 11 Mac Pro patcher. Update source code to download MacOS 11.4

Spaces are being corrected in the current source code. A few changes are being made on June 18, 2021.

There is a known issue with PCIe SSD Cards on 11.3.2 and later. My workaround is to put the SSD card in your primary video card 16x slot (on a Mac Pro 3,1) and put the Video Card in the upper 16x slot. You will lose 1 PCIe slot depending on the width of your video card. Your mileage may vary. Untested with NVMe cards. I don't have one, but I did run into PCIe problems with the video card in it's primary slot. You may be able to do the same in a 5,1, but it's PCIe configuration is not the same as a 3,1. However I think there is a told that lets you adjust the bandwidth of certain PCIe slots on a 5,1 and that might help. Just a wild guess.

 ## [🍟 click here for bigmac2 alpha1 GUI](http://starplayrx.com/bigmac2/bigmac2-a1.pkg)
 ## [🍟 click here for bigmac2 alpha2 GUI](http://starplayrx.com/bigmac2/bigmac2-a2.pkg)


### Release Schedule
* 🍟 01.31.21 10:00PM PST Alpha 1 (11.1) [Released]
* 🍟 02.01.21 06:00PM EST Alpha 2 (11.2) [Released]
* 🍔 GUI version of the source code available here.

<img src="https://swift4me.com/images/splash/bigmac2f.png" width="100%" >

* Native Airdrop and Handoff support! Requires BT4LE and 802.11ac
* USB 1.1 Support, special thanks to JackLukem for the tip!
* FireWire 400 and 800 Hard Drive and SSD Support (booting from FW currently fails)
* Automatic Legacy WiFi 802.11n Patch 
* Legacy Bluetooth2 disabler, Bluetooth4 enabler (with card or BT4LE dongle)
* Easier to use
* Download Full Installers from the App Store
* Optional Apple Developer Seed Support Downloads
* Wicked Installer Boot System / Light Speed Emergency Disk
* Ultra Fast Boot of a Full OS
* Improved Boot Screen Support
* Full GUI
