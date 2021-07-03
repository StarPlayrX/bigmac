BigMac2 

First Time User Guide
* Your Mac must support natively booting APFS. Please use dosdude1's APFS ROM Patcher (lower left button on Bigmac2 to download.
* You need to disable SIP and authenticated-root. To do this, your first Big Mac 2 installer should be on an external USB HD or Fast Thumb drive. It needs to be about 32Gb. You cannot disable SIP if Big Mac2 is running from an internal SSD or HD. It must be on an external disk to the system.
** After Bigmac2 is booted from an extenral disk:
* Go to the terminal and type:
`csrutil

csrutil disable

csrutil authenticated-root disable`

This should stop the Kill -9 errors users have been getting
bigmac2 should now run properly on the disk. You can try runnin the pre-install first and see what happens. It's worth a shot



        Select your macOS version (macOS 11.4 or macOS 12.0 Beta). Then to download it from Apple click "Download macOS"
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
