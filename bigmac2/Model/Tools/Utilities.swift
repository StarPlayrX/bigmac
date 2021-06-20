//
//  Utilities.swift
//  bigmac2
//
//  Created by starplayrx on 1/1/21.
//
import Cocoa

//MARK: Get Disk Info by a single Disk with all volumes it contains, plus filtering specific disk and get its slice
func getVolumeInfoByDisk(filterVolumeName: String, disk: String, isRoot: Bool = true) -> myVolumeInfo? {
    
    let volInfo = getVolumeInfo(includeHiddenVolumes: true, includeRootVol: isRoot )
    
    if isRoot {
        let d = volInfo?.filter { $0.displayName == filterVolumeName }
        let r = d?.first ?? nil
        
        if r != nil { return r }
    }
    
    if disk != "" {
        let disks = volInfo?.filter { $0.disk == disk }
        let d = disks?.filter { $0.volumeName == filterVolumeName }
        return d?.first ?? nil
    } else {
        let d = volInfo?.filter { $0.volumeName == filterVolumeName }
        return d?.first ?? nil
    }
}

//MARK: Donate to BigMac
func donate2BigMac() {
    if let url = URL(string: "https://www.paypal.com/donate?hosted_button_id=M3U48FLF87SXQ") {
        NSWorkspace.shared.open(url)
    }
}

//MARK: Mount Big Data
func mountBigData() {
    
    if let appFolder = Bundle.main.resourceURL?.path {
        
        let dir = "/\(tmp)/\(bigdata)"
        
        if checkIfFileExists(path: dir) {
            _ = mkDir(arg: "/\(tmp)/\(bigdata)")
        }
                
        //MARK: mount disk image inside temp SharedSupport
        _ = mountDiskImage(arg: ["mount", "-mountPoint", "/\(dir)", "\(appFolder)/\(bigdata).dmg", "-noverify", "-noautoopen", "-noautofsck", "-nobrowse"])
    }
}

//MARK: Unmount Big Data
func unmountBigData() {
    
    let dir = "/\(tmp)/\(bigdata)"
    
    _ = mountDiskImage(arg: ["eject", "/\(dir)"])
    _ = mountDiskImage(arg: ["eject", "/Volumes/\(bigdata)"])
    
    if checkIfFileExists(path: dir) {
        _ = rmDir(arg: "/\(tmp)/\(bigdata)")
    }
}


//MARK: Move to Utilities
func checkIfFileExists(path: String) -> Bool {
    let fm = FileManager.default
    if fm.fileExists(atPath: path) {
        return true
    } else {
        return false
    }
}

//MARK: Mount diskimage and parse disk#s#
func mountDiskImage(bin: String = "/usr/bin/hdiutil", arg: [String]) -> String {
    var mountedDisk = runCommandReturnStr(binary: bin , arguments: arg) ?? ""
    mountedDisk = parseRawText(mountedDisk)
    return mountedDisk
}


//MARK: Make Directory - To do use File Manager (For alot of these future tasks)
 func mkDir(bin: String = "/bin/mkdir", arg: String) -> String {
    let result = runCommandReturnStr(binary: bin , arguments: [arg]) ?? ""
    return result
}

//MARK: Make Directory - To do use File Manager (For alot of these future tasks)
 func rmDir(bin: String = "/bin/rm", arg: String) -> String {
    let result = runCommandReturnStr(binary: bin , arguments: [arg]) ?? ""
    return result
}


//MARK: File String
func parseRawText(_ str: String) -> String {
    
    var s = str
    
    s = s.replacingOccurrences(of: "\t", with: " ")
    
    for _ in 1...3 {
        s = s.replacingOccurrences(of: "     ", with: " ")
        s = s.replacingOccurrences(of: "    ", with: " ")
        s = s.replacingOccurrences(of: "   ", with: " ")
        s = s.replacingOccurrences(of: "  ", with: " ")
    }
    
    return s
}

extension ViewController {
    
    func removePath(atPath: String) {
        do {
            try fm.removeItem(atPath: atPath)
        } catch  {
            print(error)
        }
    }
    
    func copyPath(atPath: String, toPath:String) {
        do {
            try fm.copyItem(atPath: atPath, toPath: toPath)
        } catch  {
            print(error)
        }
    }
    
    // MARK: Get System Info
    func getSystemInfo(drive:String) -> systemInfoCodable?   {
        
        let path = "/Volumes/\(drive)/System/Library/CoreServices/SystemVersion.plist"
        if checkIfFileExists(path: path) {
            let systemPath = path
            //let systemURL = NSURL(string: systemPath)
            let systemURL = URL(fileURLWithPath: systemPath)
            var systemInfo : systemInfoCodable?
            do {
                let data = try Data(contentsOf: systemURL )
                let decoder = PropertyListDecoder()
                systemInfo = try decoder.decode(systemInfoCodable.self, from: data)
                
                return systemInfo
            } catch {
                print(error)
            }
        }

        return nil
    }
    
    func checkForBaseOS() -> Bool {
        if fm.fileExists(atPath: baseOS) {
            return true
        } else {
            return false
        }
    }
    
    func refreshPatchDisks() {
        if let getDisks = getVolumeInfo(includeHiddenVolumes: false, includeRootVol: true) {
            
            availablePatchDisks.removeAllItems()
            
            for i in getDisks {
                var drive = ""
                if i.root {
                    drive = i.displayName
                } else {
                    drive = i.volumeName
                }
                
                //MARK: bigmac2 is omitted, we don't want users trying to patch bigmac2
                if let systemInfo = getSystemInfo(drive: drive), i.displayName != bigmac2Str {
                    let majorMinorVersion = systemInfo.productUserVisibleVersion.components(separatedBy: ".")
                   // print ( majorMinorVersion, i.displayName, i.root )
                    
                    if majorMinorVersion.first == "11" {
                        availablePatchDisks.addItem(withTitle: drive)
                    }
                }
            }
        }
    }
    
    //MARK: This a better preboot routine - to do: See if we can return plist or XML
    func getDisk(substr: String, usingDiskorSlice: String, isSlice: Bool) -> String? {
        
        if let pb = runCommandReturnStr(binary: "/usr/sbin/diskutil", arguments: ["list", usingDiskorSlice]) {
            let pbArray = pb.components(separatedBy: "\n")
            
            for i in pbArray {
                if i.contains(substr) {
                    if isSlice {
                        let prebootVolume = String(i.suffix(usingDiskorSlice.count))
                        return prebootVolume
                    } else {
                        let prebootVolume = String(i.suffix(usingDiskorSlice.count + 2))
                        return prebootVolume
                    }
                }
            }
        }
        return nil
    }
    
}
