# 🍔 Big Mac 2

### <a id="raw-url" href="https://starplayrx.com/bigmac2/bigmac2_v2.0.4.dmg">bigmac2_v2.0.4.dmg (7 MB)</a>

First Time User Guide (from an unsupported Mac)
* If you have Bluetooth 2 EDR Card, remove it. You can reinstall it later after you run the Disable Bluetooth patch
* If you have not installed dosdude1's APFS ROM Patcher, do that first.
* Install BigMac 2 to an external hard drive or USB Flash thumb drive (should be relatively fast and min of 32 GB)
* Next disable SIP. Boot BigMac 2 up from an extenral USB 2.0 on an unsupported Mac:

`csrutil`

`csrutil disable`

`csrutil authenticated-root disable`

 * This should stop the Kill -9 errors users have been getting

 * BigMac2 should behave from the USB 2.0 disk and on Internal SSDs. If you ZAP your PRAM, repeat.

 * If you cannot disable SIP, do this from a Recovery Disk or Create install media disk.


## Monterey Beta 2 is Experimental
* This is what we know so far:
  * Legacy WiFi cards will not work. Upgrade to 802.11ac/BT4LE Cards
  * Apple's own USB 2.0 Magic 2 devices need to be hooked up to a USB Switch or Hub. First time we had to do this.
  * With Race Condition, it seems to boot better when not in Verbose mode. This could just be voodoo.
  * If the progress bar boots slowly and not far, that usually means that it will boot up.
  * Race Condition in Apple's installer is really bad. Very difficult to install a fresh OS on an unsupported Mac.
 
  * Workaround, install from a geniune Supported Intel based Mac:
    * Boot into Recovery: Cmd-R at boot
    * Open Terminal. These next steps are required to run BigMac2 and CloneToolX from a bigmac2 install disk from a Supported Mac:
      * `csrutil`
      * `csrutil disable`
      * `csrutil authenticated-root disable`
    
    * Next Steps
      * Download BigMac2 beta
      * Select install macOS Monterey beta 2
      * Install bigmac2 on a USB 2.0 32Gb Partition
      * Boot from bigmac2
      * Launch bigmac2, from its pre install tab, Launch the installer. In five seconds, Monterey will show up
      * Several reboots will happen
      * Once Monterey is installed, reboot to bigmac2's boot disk
     
    * For Mac Pro 3,1 run the Telemtery post install by itself
    * Then run delete the APFS Snapshot by itself.
    * Now see if the USB 2.0 install boots on your unsupported Mac (this will be slow)
    
    * What doesn't work on Monetery Beta 2
      * USB 2.0 devices will only work with a USB 3.0 Hub or Switch. This includes Apple USB 2.0 Devices!
      * Beta 2 still has a Race Condition. It's bad. Apple is ignoring this issue. I have reason to believe it exists on support macs as well. Supported Macs may be covering it up by just rebooting 2-3 times when it occurs.
      
      * From a Supported mac if Bigmac2 app does not run, download Xcode and compile it from source. From Xcode set the development team to none or personal and set the app signing to run locally. On certain systems, Apple has started flagging bigmac2 as Malware. This statement is false. Bigmac2 contains zero malware. Disk image and Installer package files are downloaded to /Users/shared. These files are harmless and can be deleted at any time.

<img width="1920" alt="Screen Shot 2021-07-03 at 3 41 35 PM" src="https://user-images.githubusercontent.com/52664524/124365543-c48e8d80-dc16-11eb-961b-0e6f83a94b86.png">

## Recommended Flash Drive or a USB 2.0 / 3.0 SSD:
For Big Mac 2 installer disks, I use Samsung Flash Drive FIT Media 32GB. Once you have disabled SIP and authenticated-root, you can install BigMac 2 to an internal SSD or Harddrive on a 32GB APFS Partition. Remember if you ZAP your PRAM, you'll need to use your USB 2.0 Drive instead.

# Now you may proceed as planned.
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
