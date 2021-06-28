//
//  CreateInstallTasks.swift
//  bigmac2
//
//  Created by starplayrx on 12/30/20.
//

import Foundation


extension ViewController {
    
    //MARK: Task #1
    func updateInstallerPkg(installBigSurApp: String) ->  (result: String, installed: Bool) {
        
        var vet = (result: "Updating the disk failed!", installed: false)
        
        let installOSapp = installVersionIsLegacy ? installOS11 : installOS12

        let InstallAsst = "/Users/Shared/InstallAssistant.pkg"
        let InstallApp = "/Applications/\(installOSapp)"

        if checkIfFileExists(path: InstallAsst) && !checkIfFileExists(path: InstallApp) {
            incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, cylon: true, title: "Updating Installer Package...")
            vet.result = runCommandReturnStr(binary: "/usr/sbin/installer" , arguments: ["-allowUntrusted", "-pkg", InstallAsst, "-target", "/" ]) ?? ""
            vet.installed = true
        }
        
        return vet
    }
    
    
    func createDiskEnded(completed: Bool) {
        //MARK: Step 7
        cleanup(bigmac2: bigmac2)
        unmountDrives(mountBigmac: true, ejectAll: false)
     
        //MARK: Finish
        let gString = globalDispatch?.label ?? "The process"
        
        if completed {
            incrementInstallGauge(resetGauge: false, incremment: false, setToFull: true, title: "\(gString) is complete!")
        } else {
            incrementInstallGauge(resetGauge: true, incremment: false, setToFull: false, title: "\(gString) failed!")
        }
        
        spinnerAnimation(start: false, hide: true)
        
        currentWorkflowEnded()
    }
    
    
    //MARK: Task #1.5
    func checkmacOSDmgPathCheckPoint(macOSName: String) -> Bool? {
        var pass = true
        
        let checkForInstallApp = "/Users/shared/\(macOSName)"
        
        if !checkIfFileExists(path: checkForInstallApp) {
            pass = false
            
            createDiskEnded(completed: pass)
            
            globalError = "This operation cannot continue without \(checkForInstallApp). Please download the macOS DMG first"
    
            DispatchQueue.main.async { [self] in
                performSegue(withIdentifier: "displayErrMsg", sender: self)
            }
            
        }
     
        return pass
    }

    
    //MARK: Task #1.5
    func installBigSurCheckPoint(installBigSurApp: String) -> Bool? {
        var pass = true
        
        let applications = "Applications"
        let checkForInstallApp = "/\(applications)/\(installBigSurApp)"
        
        if !checkIfFileExists(path: checkForInstallApp) {
            pass = false
            
            createDiskEnded(completed: pass)
            
            globalError = "This operation cannot continue without \(checkForInstallApp). Please either place the \(installBigSurApp) inside your \(applications) folder or download a new macOS Installer disk."
    
            DispatchQueue.main.async { [self] in
                performSegue(withIdentifier: "displayErrMsg", sender: self)
            }
            
        }
     
        return pass
    }

    
    
    //MARK: Task #2
    func reformatSelectedApfsDisk(diskInfo: myVolumeInfo) {
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, cylon: true, title: "Reformatting the \(diskInfo.displayName) AFPS volume...")
        
        //MARK: Erase disk inplace using reformat
        _ = eraseDisk(diskSlice: diskInfo.diskSlice)
    }
    
    
    
    //MARK: Task #3
    func extractBaseSystem() {
        //MARK: make temp dir SharedSupport
        _ = mkDir(arg: "/\(tmp)/\(sharedsupport)")
        
        let installOSapp = installVersionIsLegacy ? installOS11 : installOS12

        //MARK: mount disk image inside temp SharedSupport
        _ = mountDiskImage(arg: ["mount", "-mountPoint", "/\(tmp)/\(sharedsupport)", "/\(applications)/\(installOSapp)/Contents/\(sharedsupport)/\(sharedsupport).dmg", "-noverify", "-noautoopen", "-noautofsck", "-nobrowse"])
        
        //MARK: Zip Extraction (retain base system disk image from DMG)
        _ = extractDMGfromZip(arg: ["-o", "/\(tmp)/\(sharedsupport)/\(macSoftwareUpdate)/\(wildZip)", "\(restoreBaseSystem)", "-d", "/\(tmp)"])
        
        //MARK: Mounted Shared Support DMG and Extracted DMG from zip
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false)
        
        _ = mountDiskImage(arg: ["unmount", "/\(tmp)/\(sharedsupport)", "-force"])
        
        
    }
    
    
    
    //MARK: Task #4
   /* func createDirectory(diskInfo: myVolumeInfo, disk: String, rndStr: String) {
        
        for _ in 1...3 {
            let result = addVolume(dmgPath: tempSystem, targetDisk: "/dev/r\(diskInfo.disk)", erase: true, title: "Creating Directory")
            if result == "Done" { break }
            sleep(2)
        }
        
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false)
        let _ = runCommandReturnString(binary: "/usr/sbin/diskutil" , arguments: ["mount", disk] )
        sleep(2)
        let _ = renameDisk(input: disk, output: "\(disk)_\(rndStr)")
    }*/
    
    
    
    //MARK: Task #5
    func installBaseSystem(diskInfo: myVolumeInfo, baseSys: String, bm2: String) {
        //MARK: Install Base System
        _ = addVolume(dmgPath: "/\(tmp)/\(restoreBaseSystem)", targetDisk: "/dev/r\(diskInfo.disk)", erase: false, title: "Installing Base System")
        _ = mountDiskImage(arg: ["unmount", "/\(tmp)/\(restoreBaseSystem)", "-force"])
        _ = mountVolume(disk: diskInfo.disk)
        _ = renameDisk(input: baseSys, output: bm2)
        
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false)
    }
    
    //MARK: Task #5.1
    func installDMGviaASR(diskInfo: myVolumeInfo, baseSys: String, bm2: String, dmg: String) {
        //MARK: Install Base System
        
        let path = "/Users/shared/\(dmg)"
        let rootpath = "/\(dmg)"

        let ttle = "Installing \(dmg)..."
        if checkIfFileExists(path: path) {
            _ = addVolume(dmgPath: path, targetDisk: "/dev/r\(diskInfo.disk)", erase: true, title: ttle)
        } else if checkIfFileExists(path: rootpath) {
            _ = addVolume(dmgPath: rootpath, targetDisk: "/dev/r\(diskInfo.disk)", erase: true, title: ttle)
        } else {
            _ = performAppleScript(script: """
                display dialog "Please download the macOS dmg first."
            """)
        }
        
        _ = mountVolume(disk: diskInfo.disk)
        
    }
    
   
    
    //MARK: Task #7
    func bigSurInstallerAppXfer(BootVolume: myVolumeInfo) {
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, cylon: false, title: "Installing the macOS App...")
        
        let appName = installVersionIsLegacy ? installOS11 : installOS12

        let contents = "Contents"
        let rootVol = BootVolume.path
        let sharedSup = "SharedSupport"
        let apps = "Applications"
        
        let root = "\(rootVol)/\(appName)/"
        let fm = FileManager.default
        
        
        do {
            let dir = try fm.contentsOfDirectory(atPath: "/\(apps)/\(appName)/\(contents)/")
            
            //MARK: Remove Items
            for i in dir {
                
                let dst = "\(root)\(contents)/\(i)"
                    
                try? fm.removeItem(atPath: dst)
            }
            
            //MARK: Copy Items
            for i in dir {
                
                let src = "/\(apps)/\(appName)/\(contents)/\(i)"
                let dst = "\(root)\(contents)/\(i)"
                
                if !i.contains("SharedSupport") && !i.isEmpty {
                    try fm.copyItem(atPath: src, toPath: dst)
                }
            }
            
        } catch {
            print(error)
        }
        
        let sharedSupportPath = "\(rootVol)/\(appName)/\(contents)/\(sharedSup)"
        
        do {
            try? fm.removeItem(atPath: sharedSupportPath)
            try fm.createDirectory(atPath: sharedSupportPath, withIntermediateDirectories: false, attributes: nil)
        } catch {
            print(error)
        }
        
        //MARK: Copy the big shared support dmg
        copyFile(atPath: "/\(apps)/\(appName)/\(contents)/\(sharedSup)/\(sharedSup).dmg", toPath: "\(sharedSupportPath)/\(sharedSup).dmg")
    }

    func installBigMacIIApp(bigmac2: myVolumeInfo) {
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false, title: "Installing the Big Mac 2 App...")
        
        //MARK: Make Preboot bootable and compatible with C-Key at boot time (currently works with PCIe SSDs)
        let rscFolder = "/\(tmp)/\(bigdata)"
        
        let bigFolder = Bundle.main.bundlePath
        
        let burgerKing = bigmac2.volumeName
        
        let util = "/Volumes/\(burgerKing)/System/Installation/CDIS/Recovery Springboard.app/Contents/Resources/Utilities.plist"
        
        let bk = "/Volumes/\(burgerKing)/Applications/bigmac2.app"
        let rdm = "/Volumes/\(burgerKing)/Applications/RDM.app"
        
        removePath(atPath: util)
            
        let macOS = installVersionIsLegacy ? OS11 : OS12
        
        copyPath(atPath: "\(rscFolder)/\(macOS)/Utilities.plist", toPath: util)
        copyPath(atPath: "\(bigFolder)", toPath: bk)
        copyPath(atPath: "\(rscFolder)/RDM.app", toPath: rdm)
    }
    
    
    //MARK: Task #8
    func cleanup(bigmac2: String) {
        _ = blessVolume(bless: bigmac2)
        
        if let getBaseSystemDisk = getVolumeInfoByDisk(filterVolumeName: "/private/\(tmp)/\(basesystem)", disk: "") {
            let infoDisc = runCommandReturnStr(binary: "/usr/sbin/diskutil" , arguments: ["apfs", "list", "\(getBaseSystemDisk.disk)"] ) ?? ""
            
            if !infoDisc.isEmpty {
                let wholeDisk = getApfsPhysicalStoreDisk(apfsDiskInfo: infoDisc)
                runCommand(binary: "/usr/sbin/diskutil" , arguments: ["eject", wholeDisk] )
            }
        }
        
        runCommand(binary: "/usr/sbin/diskutil" , arguments: ["eject", "Shared Support"] )
        
        incrementInstallGauge(resetGauge: false, incremment: true, setToFull: false)
    }
}

