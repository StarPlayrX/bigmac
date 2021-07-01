//
//  CreateInstallDisk.swift
//  bigmac2
//
//  Created by starplayrx on 12/21/20.
//

import Foundation

extension ViewController {
    
    //MARK: Set Base System - Adopt this helper for future quick updates
    func baseBootPlister(diskInfo: myVolumeInfo, isVerbose: Bool, isSingleUser: Bool, prebootVolume: String, isBaseSystem: Bool) {
        
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, cylon: false, title: "Making the bigmac2 installer disk bootable...")

        //MARK: Update systemVolume volume because UUIDs have changed
        if let systemVolume = getVolumeInfoByDisk(filterVolumeName: diskInfo.volumeName, disk: diskInfo.disk, isRoot: diskInfo.root) {
            
            globalVolumeInfo = systemVolume
            
            runCommand(binary: "/usr/sbin/diskutil", arguments: ["mount", systemVolume.diskSlice])

            BootSystem(system: systemVolume, dataVolumeUUID: systemVolume.uuid, isVerbose: isBaseVerbose, isSingleUser: isBaseSingleUser, prebootVolume: prebootVolume, isBaseSystem: true)
        } else {
            print("Bootable System Failure.")
        }
    }
    
    
    //MARK: To do - Setup a variable
    func downloadDMG(diskImage: String, webSite: String) {
        //Remove pre-existing file
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/Users/shared/\(diskImage)"]) //Future check if it's complete and has right checksum
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/tmp/\(diskImage)"]) //Future check if it's complete and has right checksum
        
        DispatchQueue.main.async { [self] in
            downloadLabel.stringValue = diskImage
        }

        DispatchQueue.global(qos: .background).async { [self] in
            download(urlString: "\(webSite)\(diskImage)")
        }
    }
    
    
    //MARK: To do - Setup a variable
    func downloadPkg(pkgString: String) {
        //Remove pre-existing file
        
        let installOS = installVersionIsLegacy ? installShortOS11 : installShortOS12
        
        //clean house
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/Users/shared/bigmac2.dmg"]) //Future check if it's complete and has right checksum
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/tmp/bigmac2.dmg"]) //Future check if it's complete and has right checksum
        
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/Users/shared/InstallAssistant.pkg"]) //Future check if it's complete and has right checksum
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/tmp/InstallAssistant.pkg"]) //Future check if it's complete and has right checksum
        runCommand(binary: "/bin/rm", arguments: ["-Rf", installShortOS11])
        runCommand(binary: "/bin/rm", arguments: ["-Rf", installShortOS12])

        runCommand(binary: "/bin/rm", arguments: ["-Rf","/Users/shared/InstallAssistant.pkg"])
        DispatchQueue.main.async { [self] in
            
        downloadLabel.stringValue = installVersionIsLegacy ? macOS11 : macOS12
     
            DispatchQueue.global(qos: .background).async {
                self.download(urlString: pkgString)
            }
        }
    }
    
    //MARK: To do - Setup a variable
    func downloadBigMac2(dmg: String) {
        //Remove pre-existing file
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/Users/shared/bigmac2.dmg"]) //Future check if it's complete and has right checksum
        runCommand(binary: "/bin/rm", arguments: ["-Rf","/tmp/bigmac2.dmg"]) //Future check if it's complete and has right checksum
                
        DispatchQueue.main.async { [self] in
            downloadLabel.stringValue = globalDispatch?.label ?? "Downloading disk"
        }
        
        DispatchQueue.global(qos: .background).async {
            self.download(urlString: dmg)
        }
    }
    
    //MARK: Install Shared Support DMG
    internal func installSharedSupportDMG2() {
        
        let installOSapp = installVersionIsLegacy ? installOS11 : installOS12
        
        DispatchQueue.global(qos: .background).async { [self] in
           copyFile(atPath: "/Applications/\(installOSapp)/Contents/SharedSupport/SharedSupport.dmg", toPath: "/Volumes/macOS Base System/SharedSupport.dmg")
        }
    }
    
    //MARK: Install Emoji Font
    internal func installEmojiFont(diskInfo: myVolumeInfo) {
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, title: "Installing the Apple Emoji Font...")
        sleep(2)
        copyFile(atPath: "/System/Library/Fonts/Apple Color Emoji.ttc", toPath: "\(diskInfo.path)/System/Library/Fonts/Apple Color Emoji.ttc")
    }
    
    //MARK: Increment Install Fuel Gauge
    internal func incrementInstallGauge(resetGauge: Bool, incremment: Bool, setToFull: Bool, cylon: Bool = false, title: String = "") {
        
        DispatchQueue.main.async { [self] in
            if cylon {
                sharedSupportProgressBar.startAnimation(self)
            } else {
                sharedSupportProgressBar.stopAnimation(self)
                sharedSupportProgressBar.isIndeterminate = false
                sharedSupportProgressBar.doubleValue = 0
                sharedSupportProgressBar.minValue = 0
                sharedSupportProgressBar.maxValue = 100
            }
            
            if resetGauge {
                installerFuelGauge.doubleValue = installerFuelGauge.minValue
                sharedSupportProgressBar.doubleValue = sharedSupportProgressBar.minValue

            }
            
            if incremment {
                installerFuelGauge.doubleValue += 1
            }
            
            if setToFull {
                installerFuelGauge.doubleValue = installerFuelGauge.maxValue
                sharedSupportProgressBar.doubleValue = sharedSupportProgressBar.maxValue
                    
                //MARK: Show done screen sheet
                performSegue(withIdentifier: "installComplete", sender: nil)
            }
            
            if !title.isEmpty {
                mediaLabel.stringValue = title
                
                if !gbLabel.stringValue.contains("12") {
                    gbLabel.stringValue = ""
                    percentageLabel.stringValue = ""
                }
            }
        }
        
        if (!title.isEmpty) {
            sleep(2)
        }
    }
    
    //MARK: Increment Install Fuel Gauge
    internal func setMediaLabelX(_ message: String) {
        
        DispatchQueue.main.async { [self] in
            mediaLabel.stringValue = message
        }
    }
    
    //MARK: Spinner Animation
    internal func spinnerAnimation (start: Bool, hide: Bool) {
        
        DispatchQueue.main.async { [self] in
            if start {
                createInstallSpinner.startAnimation(self)
            } else {
                createInstallSpinner.stopAnimation(self)
            }
            
            if hide {
                createInstallSpinner.isHidden = true
            } else {
                createInstallSpinner.isHidden = false
            }
        }
    }
    
    //MARK: Check for root user
    internal func checkForRootUser() -> Bool {
        rootMode || NSUserName() == "root" ? true : false
    }
    
    //MARK: Make Rename Disk using diskutil
    internal func renameDisk(bin: String = "/usr/sbin/diskutil", input: String, output: String) -> String {
        let result = runCommandReturnStr(binary: bin , arguments: ["rename", input, output]) ?? ""
        return result
    }
        
    //MARK: Make Rename Disk using diskutil
    internal func removeApfsVolume(bin: String = "/usr/sbin/diskutil", remove: String) -> String {
        let result = runCommandReturnStr(binary: bin , arguments: ["apfs", "deleteVolume", remove]) ?? ""
        return result
    }
    
    //MARK: Make Rename Disk using diskutil
    internal func blessVolume(bin: String = "/usr/sbin/bless", bless: String) -> String {
        let result = runCommandReturnStr(binary: bin , arguments: ["--mount", "/Volumes/\(bless)", "--label", bless]) ?? ""
        return result
    }
    
    //MARK: Extract DMG from Zip file
    func extractDMGfromZip(bin: String = "/usr/bin/unzip", arg: [String] ) -> String {
        let result = runCommandReturnStr(binary: bin , arguments: arg) ?? ""
        return result
    }
    
    //MARK: Add volume using ASR
    func addVolume(binStr: String = "/usr/sbin/asr", dmgPath: String, targetDisk: String, erase: Bool, title: String) -> String {
        var eraseString = ""
        
        var args = ["restore", "--source", dmgPath, "--target", targetDisk, "-noverify", "-noprompt", "--puppetstrings"]
        
        if erase {
            eraseString = "-erase"
            args.append(eraseString)
        }
        
        runProcess(binary: "/usr/sbin/asr", arguments: args, title: title)
        
        return "Done"
    }
    
    //MARK: Erase Disk
    func eraseDisk(bin: String = "/usr/sbin/diskutil", diskSlice: String ) -> String {
        let result = runCommandReturnStr(binary: bin, arguments: ["reformat", diskSlice]) ?? ""
        return result
    }
    
    //MARK: MountVolume
    func mountVolume(bin: String = "/usr/sbin/diskutil", disk: String) -> String {
        //diskutil mountDisk disk9
        let result = runCommandReturnStr(binary: "/usr/sbin/diskutil", arguments: ["mountDisk", disk]) ?? ""
        return result
    }
    

 
    //MARK: Get APFS Physical Store Disk:
    func getApfsPhysicalStoreDisk(apfsDiskInfo: String ) -> String {
        
        let apfsStringData = parseRawText(apfsDiskInfo)
        
        let array = apfsStringData.components(separatedBy: "\n")
        let ac = array.count
        
        if ac >= 11 {
            let array2 = array[10].components(separatedBy: " ")
            let disk = array2.last
            
            let getWholeDisk = disk?.components(separatedBy: "s")
            
            var forgeDisk = ""
            if let getDisk = getWholeDisk, getDisk.count >= 2, let di = Optional(getDisk[0]), let kNum = Optional(getDisk[1]) {
                forgeDisk = "\(di)s\(kNum)"
            }
            
            return forgeDisk
        } else {
            return ""
        }
    }
    
    //UnmountDrives
    func unmountDrives(mountBigmac: Bool, ejectAll: Bool) {
        
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, cylon: true, title: "Unmounting Drives...")

        let binary = "/usr/sbin/diskutil"
        let unmount = "unmount"
        let eject = "eject"
        let disks = ["Preboot","Recovery"]
        
        for disk in disks {
            runCommand( binary: binary, arguments: [ unmount, disk ] )
        }
        
        if ejectAll {
            for disk in disks {
                runCommand( binary: binary, arguments: [ eject, disk ] )
            }
        }
       
        if mountBigmac {
            runCommand( binary: binary, arguments: [ "mount", "bigmac2" ] )
        }
    }
}


