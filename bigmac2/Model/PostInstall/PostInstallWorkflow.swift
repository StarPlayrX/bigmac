//
//  PostInstallWorkflow.swift
//  bigmac2
//
//  Created by starplayrx on 1/3/21.
//

import Foundation

extension ViewController {
    
    func indicatorBump(taskMsg: String = "", detailMsg: String = "", updateProgBar: Bool = false) {
        DispatchQueue.main.async { [self] in
            
            let taskLabel = postInstallTask_label.stringValue
            
            if updateProgBar {
                postInstallProgressIndicator.doubleValue += 1
            }
            
            if !taskLabel.contains(taskMsg) {
                postInstallFuelGauge.doubleValue += 1
            }
            
            if !taskMsg.isEmpty {
                postInstallTask_label.stringValue = taskMsg
                postInstallDetails_label.stringValue = detailMsg
            }
            
        }
        
        if !taskMsg.isEmpty {
            sleep(1) //apply time to read the update
        }
    }
    
    
    func PostInstall() {
        
        DispatchQueue.global(qos: .background).async { [self] in
            
            indicatorBump(updateProgBar: true)
            
            var systemVolume : myVolumeInfo!
        
            systemVolume = getVolumeInfoByDisk(filterVolumeName: drivX, disk: "", isRoot: true)
            guard systemVolume != nil
            else {
                print("Cannot find the selected system disk.")
                return
            }
        
            guard systemVolume.displayName != "bigmac2"
            
            else {
                _ = performAppleScript(script: "display dialog \"We cannot find a drive to perform these patches to.\"")
                return
            }
            
            //MARK: Mount Disk RW
            runCommand(binary: "/sbin/mount", arguments: ["-uw", systemVolume.path])
            
            let preboot = getDisk(substr: "Preboot", usingDiskorSlice: systemVolume.disk, isSlice: false) ?? systemVolume.disk + "s2"
            let dataSlice = getDisk(substr: "Data", usingDiskorSlice: systemVolume.disk, isSlice: false) ?? systemVolume.disk + "s1"
            var apfsUtil = "\(systemVolume.path)\(apfs)"
            
            if systemVolume.root {
                apfsUtil = apfs
            }
            
            var dataVolumeUUID = runCommandReturnStr(binary: apfsUtil, arguments: ["-k", dataSlice]) ?? ""
            
            // Remove hard breaks in string
            dataVolumeUUID = dataVolumeUUID.replacingOccurrences(of: "\n", with: "")
            dataVolumeUUID = dataVolumeUUID.replacingOccurrences(of: "\r", with: "")

            var dest = systemVolume.path
            
            if systemVolume.root {
                dest = ""
            }
            
            let slek = "System/Library/Extensions"
            let uepi = "System/Library/UserEventPlugins"
            let lext = "Library/Extensions"
            let ulib = "usr/local/lib"
            
            indicatorBump(updateProgBar: true)

            if enableUSB {
                let kext = "IOHIDFamily.kext"
                _ = installKext(dest: dest, kext: kext, fold: slek, ttle: enableUSBtl)
            }
            
            if appleHDA {
                let kext = "AppleHDA.kext"
                _ = installKext(dest: dest, kext: kext, fold: slek, ttle: appleHDAtl)
            }
            
            if superDrive {
                let kext = "ioATAFamily.kext"
                _ = installKext(dest: dest, kext: kext, fold: slek, ttle: superDrivetl)
            }
            
            indicatorBump(updateProgBar: true)
            
            if legacyWiFi {
                var kext = "IO80211Family.kext"
                _  = installKext(dest: dest, kext: kext, fold: slek, ttle: legacyWiFitl)
                
                kext = "corecapture.kext"
                _ = installKext(dest: dest, kext: kext, fold: slek, ttle: legacyWiFitl)
            }
            
            if teleTrap {
                //let kext = "telemetrap.kext"
                //_ = installKext(dest: dest, kext: kext, fold: lext, ttle: teleTraptl)
                
                let plug = "com.apple.telemetry.plugin"
                _ = installKext(dest: dest, kext: plug, fold: uepi, ttle: teleTraptl)
            }
        
            indicatorBump(updateProgBar: true)
            
            if hdmiAudio {
                let kext = "HDMIAudio.kext"
                _ = installKext(dest: dest, kext: kext, fold: lext, ttle: hdmiAudiotl)
            }
            
            //SUVMMFaker
            if appStoreMacOS {
                let dlib = "SUVMMFaker.dylib"
                _ = installKext(dest: dest, kext: dlib, fold: ulib, ttle: appStoreMacOStl)
                
                let plst = "com.apple.softwareupdated.plist"
                let dmns = "System/Library/LaunchDaemons"
                _ = installKext(dest: dest, kext: plst, fold: dmns)
            }
            
            if disableBT2 {
                let fold = "System/Library/Extensions/IOUSBHostFamily.kext/Contents/PlugIns/AppleUSBHostMergeProperties.kext/Contents"
                let list = "Info.plist"
                let prfx = "usb"
                
                _ = installKext(dest: dest, kext: list, fold: fold, prfx: prfx, ttle: disableBT2tl)
            }
            
            indicatorBump(updateProgBar: true)
            
            BootSystem(system: systemVolume, dataVolumeUUID: dataVolumeUUID, isVerbose: VerboseBoot, isSingleUser: singleUser, prebootVolume: preboot)
            
            var sysPath = systemVolume.path
            
            if systemVolume.root {
                sysPath = ""
            }
                        
            //MARK Update Boot, System Caches
            if installKCs {
                indicatorBump(updateProgBar: true)
                updateMac11onMac11SystemCache(destVolume: sysPath)
            }
            
            //MARK: Delete Snapshots
            if deleteSnaphots {
                
                indicatorBump(taskMsg: "Looking for APFS Snapshots...", updateProgBar: true)
                
                let plist = runCommandReturnStr(binary: "/usr/sbin/diskutil", arguments: ["apfs", "listsnapshots", "-plist", systemVolume.diskSlice]) ?? ""
                
                //MARK: Delete Snapshots
                do {
                    
                    if let plistData: Data = plist.data(using: .utf8) {
                        
                        let decoder = PropertyListDecoder()
                        let snapshots = try decoder.decode(Snapshots.self, from: plistData).snapshots
                        
                        for s in snapshots {
                            indicatorBump(taskMsg: "Deleting snapshot...", detailMsg: "\(s.snapshotName)", updateProgBar: true)
                            _ = runCommandReturnStr(binary: "/usr/sbin/diskutil", arguments: ["apfs", "deleteSnapshot", systemVolume.diskSlice, "-xid", "\(s.snapshotXID)"])
                        }
                        
                        
                    } else {
                        indicatorBump(taskMsg: "No Snapshots found.", updateProgBar: true)
                    }
                    
                } catch {
                    // Handle error
                    print(error)
                }
            }
            
            if blessSystem {
                // if let app = appFolder  {
                var bless = systemVolume.path + "/usr/sbin/bless"
                var path = systemVolume.path + "/"
                
                if systemVolume.root {
                    bless = systemVolume.path + "/usr/sbin/bless"
                    path = systemVolume.path
                }
                
                indicatorBump(taskMsg: "Blessing \(systemVolume.displayName)...", detailMsg: "", updateProgBar: true)
                _ = runCommandReturnStr(binary: bless, arguments: ["--folder", "\(path)System/Library/CoreServices" , "--bootefi", "--label", systemVolume.displayName, "--setBoot"]) ?? ""

            }
            
            
            DispatchQueue.main.async { [self] in
                indicatorBump(taskMsg: "Completed the selected patches...", detailMsg: "")
                postInstallFuelGauge.doubleValue = postInstallFuelGauge.maxValue
                postInstallProgressIndicator.doubleValue = postInstallProgressIndicator.maxValue
                postInstallSpinner.stopAnimation(self)
                postInstallSpinner.isHidden = true
                globalVolumeInfo = systemVolume
                performSegue(withIdentifier: "postInstall", sender: nil)
            }
        }
    }
}
