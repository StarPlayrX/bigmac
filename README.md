# 🍔 Big Mac 2

#### For hobbyists who want to run macOS Big Sur or macOS Monterey on Unsupported Mac hardware. 

Both Big Sur various versions and macOS Monterey betas have a boot race condition. One was first detected in macOS 11.1 where it would periodically try to boot from a Time Machine snapshot, then hang. Every since then, the boot race condition is in nearly all versions of macOS there after and it's getting worse. It is showing up on all unsupported Macs, but this issue does not rule out supported Macs. Apple keeps adding layers of security inside the boot process where 2 or more functions that rely on each other either do not fire in the same predicable order. What can happen is one process fires more than once, or it fails to run. The method that relies on it will hang. This results in a total lockdown in the boot process or it can also lead to an into an infinite loop with one or more processes are looking for something that does not exist. Since mostly unsupported Macs are affected, Apple is ignoring this issue. The boot race condition will only get fixed if third party security agencies find the boot race condition inside supported Macs. On top of all this, there is probably more than one race condition.

### <a id="raw-url" href="https://starplayrx.com/bigmac2/bigmac2_v2.0.4.dmg">bigmac2_v2.0.4.dmg (7 MB)</a>

### First Time User Guide (from an unsupported Mac)
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

### Installation from a Supported Intel Mac
  * Boot into Recovery: Cmd-R at boot
  * Open Terminal. These next steps are required to run BigMac2 and CloneToolX from a bigmac2 install disk from a Supported Mac:
    * `csrutil`
    * `csrutil disable`
    * `csrutil authenticated-root disable`

   * Download BigMac2 beta
   * Select install macOS Monterey beta 2
   * if Bigmac2 app does not run, download Xcode and compile it from source. From Xcode set the development team to none or personal and set the app signing to run locally. Always clean the build before building. bigdata.dmg gets downloaded each time. This is to save diskspace inside the repo.
   * Install bigmac2 on a USB 2.0 32Gb Partition (if the USB2.0 drive is a min of 128GB, the rest of the disk can be used for the install)
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
  
### Monterey Beta 2 is Experimental
* This is what we know so far:
  * Legacy WiFi cards will not work. Upgrade to 802.11ac/BT4LE Cards
  * USB 2.0 devices will only work with a USB 3.0 Hub or Switch. This includes Apple USB 2.0 Devices!
  * If the progress bar boots slowly and not far, that usually means that it will boot up.
  * With Race Condition, a full system seems to boot better when not in Verbose mode. This could just be voodoo.
  *
 

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
