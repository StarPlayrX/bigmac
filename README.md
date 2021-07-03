# Big Mac 2 beta

### http://starplayrx.com/bigmac2/Big_Mac_2.0.2_beta19.dmg

First Time User Guide
* If you have Bluetooth 2 EDR Card, remove it. You can reinstall it later after you run the Disable Bluetooth patch +
* If you have not installed dosdude1's APFS ROM Patcher, do that first.
* Install BigMac 2 to an external hard drive or USB Flash thumb drive (should be relatively fast and min of 32 GB)
* Boot it up and go to the termina and type:

`csrutil`

`csrutil disable`

`csrutil authenticated-root disable`

This should stop the Kill -9 errors users have been getting

BigMac2 should behave from the USB 2.0 disk and on Internal SSDs. If you ZAP your PRAM, repeat.


## Monterey Beta 2 is experimental and has an extreme Race Condition.
* Apple has become the king of Race Conditions since Big Sur 11.3. There is no easy fix.
* Things are loading out of sync causing a lock down of the system. It is apparent in Verbose mode.
* because of this beta 2 is barely installable. After 2 attempts, I have not gotten to the Welcome screen.
* My next attempt will be to run bigmac2 from a supported mac and see if I get a Welcome screen then take the drive clone it using CloneToolX on bigmac2 boot disk.
* Anything around crypto and the disks are getting messed up
* Things are constantly loading out of order
* Single user mode doesn't work

## Recommended Flash Drive:
I use Samsung Flash Drive FIT Media 32GB. Once you have disabled SIP and authenticated-root, you can now install BigMac 2 to an internal SSD or Harddrive on a 32GB APFS Partition. Remember if you ZAP your PRAM, you'll need to use your USB 2.0 Drive instead.

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
