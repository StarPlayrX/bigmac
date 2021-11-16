# 🍔 Big Mac 2


### For Mac enthusiasts who want to run macOS Big Sur or macOS Monterey on Unsupported Mac hardware. 

When compling from source, always clean your build folder. BigMac stores small DMG within itself.

### Bluetooth, WiFi, Handoff possible on Monterey (Mac Pro 3,1 4,1 5,1):
This weekend I started experimenting with a Lenovo WiFi 802.11ac/Bluetooth 4.2LE PCIe card using a combination of Open Source drivers that mess well with Apple's and was able to get Handoff working with Monterey Beta 2 and currently have WiFi and BT working on Big Sir 11.2.3 and Monterey Beta 2 and 3.

The culprit for my BCM 20702B0 card not working after Monterey Beta 1 is USB. Many users are modding the card and re-routing USB to a USB 3.0 card or USB 2.0 Hub. I use the same idea and routed the USB from the Lenovo PCIe card to a USB 3.0 port. This works on both Big Sur and Monterey. I lose a PCIe slot, but I can live with that.


### First Time User Guide macOS 11.2.3 (from an unsupported Mac)
* If running Bigmac2 recovery / install disk from OWC 2.5" SSD, use a 4x PCIe slot (on Mac Pro 3,1 use the 3rd PCIe slot, not the 1st or 2nd 16x slots)
* If Bigmac2 app does not run, try resigning it: `codesign --force --deep --sign - /Applications/bigmac2.app`
* If you have Bluetooth 2 EDR Card, remove it. You can reinstall it later after you run the Disable Bluetooth patch
* If you have not installed dosdude1's APFS ROM Patcher, do that first.
* If you want native WiFi and BT4, do yourself a huge favor and get a 802.11ac/BT4LE Broadcom black iMac style combo card. This will also give you Airdrop and Handoff without any weird hacks.
* Install BigMac 2 to an external hard drive or USB Flash thumb drive (should be relatively fast and min of 32 GB)
* Next disable SIP. Boot BigMac 2 up from an external USB 2.0 on an unsupported Mac:
  * `csrutil`
  * `csrutil disable`
  * `csrutil authenticated-root disable`

 * This should stop the Kill -9 errors users have been getting

 * BigMac2 should behave from the USB 2.0 disk and on Internal SSDs. If you ZAP your PRAM, repeat.

 * If you cannot disable SIP, do this from a Recovery Disk or Create install media disk.

### Installation of macOS 11.2.3 from a Supported Intel Mac 
  * Boot into Recovery: Cmd-R at boot
  * Open Terminal. These next steps are required to run BigMac2 and CloneToolX from a bigmac2 install disk from a Supported Mac:
    * `csrutil`
    * `csrutil disable`
    * `csrutil authenticated-root disable`

   * Download BigMac2 beta
   * if Bigmac2 app does not run, try resigning it: `codesign --force --deep --sign - /Applications/bigmac2.app`
   * Select install macOS Monterey beta 2
   * Boot from bigmac2
   * From the Springboard, launch bigmac2
   * From bigmac2's pre install tab, Launch the installer. In five seconds, the macOS installer will be shown.
   * Several reboots will happen
   * When welcome screen shows, shutdown.
   * Boot back into the bigmac2 intall disk
   * For Mac Pro 3,1 run the Telemtery post install by itself
   * Then for all systems, delete the APFS Snapshot by itself
   * Shutdown
   * Now see if the USB 2.0 install boots on your unsupported Mac (this will be slow)
   * If success, you can now clone your system to BigMac. Besure to remove the live snapshot on the clone using bigmac delete snapshot.
   * Install any other post install items from bigMac2 and also check Bless and update KCs.
  
### Future OC instructions when BM includes OC integration:
  * placeholder
  
### Monterey Beta 2 is Experimental
* This is what we know so far:
  * Legacy WiFi cards will not work. Upgrade to 802.11ac/BT4LE Cards
  * BlueTooth 4LE 20702B0 Cards are currently only working with beta 1.
  * Having zero luck with USB Bluetooth cards on Monterery.
  * We will be testing IntelWireless WiFi / BT combo cards soon with third party drivers.
  * USB 2.0 devices will only work with a USB 3.0 Hub or Switch. This includes Apple USB 2.0 Devices. ;(
  * If the progress bar boots slowly and not far, that usually means that it will boot up.
  * With Race Condition, a full system seems to boot better when not in Verbose mode. This could just be voodoo.
  * For AMD cards MouSSE is not needed. It's only needed on Mojave. I run an RX 580 8GB flashed and a Radeon Pro WX4100 non flashed. Neither need MouSSE. It will be removed from future versions of bigmac2.
 

<img width="1920" alt="Screen Shot 2021-07-03 at 3 41 35 PM" src="https://user-images.githubusercontent.com/52664524/124365543-c48e8d80-dc16-11eb-961b-0e6f83a94b86.png">

## Recommended Flash Drive or a USB 2.0 / 3.0 SSD
For Big Mac 2 installer disks, I use Samsung Flash Drive FIT Media 32GB. Once you have disabled SIP and authenticated-root, you can install BigMac 2 to an internal SSD or Harddrive on a 32GB APFS Partition. Remember if you ZAP your PRAM, you'll need to use your USB 2.0 Drive instead.

## Here are some screenshots and notes
        Select your macOS version. Then to download it from Apple click "Download macOS"
<img width="664" alt="Screen Shot 2021-06-28 at 7 18 47 PM" src="https://user-images.githubusercontent.com/52664524/123715182-bcfd6c00-d845-11eb-8c76-79c24ba9daf4.png">


        Click "Create Installer Disk" Erase an APFS partition, SSD or Fast Flash Thumb drive (32GB or bigger)
<img width="664" alt="Screen Shot 2021-06-28 at 7 03 19 PM" src="https://user-images.githubusercontent.com/52664524/123714802-039e9680-d845-11eb-8b76-4e47c9420b4e.png">

        This will create your installer disk to an APFS volume
<img width="664" alt="Screen Shot 2021-06-28 at 7 08 36 PM" src="https://user-images.githubusercontent.com/52664524/123714673-c803cc80-d844-11eb-813c-4c8231905dd5.png">

        Boot up the installer disk (Not compatible with USB 1 or BT2 EDR)
<img width="664" alt="Screen Shot 2021-06-28 at 7 11 20 PM" src="https://user-images.githubusercontent.com/52664524/123714687-cdf9ad80-d844-11eb-985e-c62b5c2dcf72.png">

        From the boot disk select these options and press Launch Installer
<img width="664" alt="Screen Shot 2021-06-28 at 7 14 25 PM" src="https://user-images.githubusercontent.com/52664524/123714830-12854900-d845-11eb-8340-cb4135854d38.png">

        Recommended checkboxes. If unsure, use Telemetry and Remove APFS Snapshots to start

<img width="664" alt="image" src="https://user-images.githubusercontent.com/52664524/123714867-2761dc80-d845-11eb-901e-9ff625f288fd.png">

        ClonetoolX included with Big Mac 2.0 (See Big Mac 2.0's boot disk)
<img width="637" alt="Screen Shot 2021-06-28 at 7 04 20 PM" src="https://user-images.githubusercontent.com/52664524/123715347-1c5b7c00-d846-11eb-935a-d3ebcce67c32.png">
