//
//  VolumeInfo.swift
//  bigmac2
//
//  Created by starplayrx on 12/23/20.
//
import Foundation

func getVolumeInfo(includeHiddenVolumes: Bool, includeRootVol: Bool = false, includePrebootVol: Bool = false) -> [myVolumeInfo]? {
    
    let URLResourceKeys : [URLResourceKey] = [.volumeNameKey, .volumeIsRemovableKey, .volumeIsBrowsableKey, .volumeIsLocalKey, .volumeIsReadOnlyKey, .volumeIsInternalKey, .volumeIsAutomountedKey, .volumeIsEjectableKey, .volumeUUIDStringKey, .isWritableKey, .volumeIdentifierKey, .volumeLocalizedFormatDescriptionKey, .volumeLocalizedNameKey, .volumeTotalCapacityKey, .isHiddenKey, .volumeIsRootFileSystemKey]
    
    var FileManagerOptions :  FileManager.VolumeEnumerationOptions  = FileManager.VolumeEnumerationOptions.skipHiddenVolumes
    
    let volumeString = "/Volumes/"
    let apfs = "APFS"
    let preboot = "Preboot"
    let vm = "VM"
    let DAMediaBSDUnit = "DAMediaBSDUnit"
    let diskString = "disk"
    let emptyString = ""
    
    if includeHiddenVolumes { FileManagerOptions = [] }
    let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: URLResourceKeys, options: FileManagerOptions)
    if let session = DASessionCreate(kCFAllocatorDefault)  {
        if let drive = volumes {
            
            var volArray = [myVolumeInfo]()
            
            for disk in drive {
                
                let dp = String(disk.path)
                
                if dp.contains(volumeString)   || includeHiddenVolumes || (includeRootVol && dp == "/") || (includePrebootVol && dp == "Preboot") {
                    
                    var newVolume = myVolumeInfo(diskSlice: emptyString, disk: emptyString, displayName: emptyString, volumeName: emptyString, path: emptyString, uuid: emptyString, external: false, root: false, capacity: 0)

                    if let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, disk as CFURL), let bsdName = DADiskGetBSDName(disk), let desc = DADiskCopyDescription(disk) {
                      
                        newVolume.diskSlice = String(cString : bsdName)
                        
                        let desc = NSDictionary(dictionary : desc)
                        newVolume.disk = "\(diskString)\(desc[DAMediaBSDUnit] ?? emptyString )"
                    }
                    
                    if let info = try? disk.resourceValues(forKeys: Set(URLResourceKeys)) {
                        newVolume.capacity = info.volumeTotalCapacity ?? 0
                        newVolume.external = !(info.volumeIsInternal ?? true)
                        newVolume.displayName = info.volumeName ?? emptyString
                        newVolume.uuid = info.volumeUUIDString ?? emptyString
                        newVolume.root = info.volumeIsRootFileSystem ?? false
                        
                        
                        newVolume.path = disk.path
                        newVolume.volumeName = newVolume.path.replacingOccurrences(of: volumeString, with: emptyString )
              
                        if !newVolume.disk.isEmpty && !newVolume.diskSlice.isEmpty && !newVolume.volumeName.contains(vm) && info.volumeLocalizedFormatDescription == apfs {
                            volArray.append(newVolume)
                        } else if newVolume.displayName == preboot && includeHiddenVolumes {
                            volArray.append(newVolume)
                        }
                    }
                }
            }
            
            volArray.sort { $0.capacity < $1.capacity}
            
            var externalArray = [myVolumeInfo]()
            var internalArray = [myVolumeInfo]()
            
            //group by external (to do: try converting to dict group by, may not be any more performant)
            for e in volArray {
                if e.external {
                    externalArray.append(e)
                } else {
                    internalArray.append(e)

                }
            }
            
            volArray = [myVolumeInfo]()
            volArray.append(contentsOf: externalArray)
            volArray.append(contentsOf: internalArray)
            return volArray
        }
    }
    return nil
}
