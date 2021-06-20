//
//  CreateInstallWorkflow.swift
//  bigmac2
//
//  Created by starplayrx on 12/30/20.
//

import Foundation

extension ViewController {
    
    //MAIN WORKFLOW STARTS HERE
    func installIsoBootDisk(diskInfo: myVolumeInfo, isVerbose: Bool, isSingleUser: Bool) {
        
        DispatchQueue.global(qos: .background).async { [self] in
            spinnerAnimation(start: true, hide: false)
            incrementInstallGauge(resetGauge: true, incremment: true, setToFull: false, cylon: true, title: "Firing up the install disk process...")
          
            let baseSys = "macOS Base System"
            let bm2 = bigmac2
            let dmg = bigmacDMG
        
            _ = updateInstallerPkg(installBigSurApp: installBigSur)
            
            //MARK: Check the Big Sur app is ready
            guard let pass = installBigSurCheckPoint(installBigSurApp: installBigSur), pass == true else {
                return
            }
       
            installDMGviaASR(diskInfo: diskInfo, baseSys: baseSys, bm2: bm2, dmg: dmg)
            
            let prebootDiskSlice = getDisk(substr: "Preboot", usingDiskorSlice: diskInfo.disk, isSlice: false) ?? diskInfo.disk + "s2"
            let diskInfo = getVolumeInfoByDisk(filterVolumeName: bigmac2Str, disk: diskInfo.disk) ?? diskInfo

            installBigMacIIApp(bigmac2: diskInfo)

            //MARK: Update systemVolume volume because UUIDs have changed
            baseBootPlister(diskInfo: diskInfo, isVerbose: isBaseVerbose, isSingleUser: isSingleUser, prebootVolume: prebootDiskSlice, isBaseSystem: true)
                 
            installEmojiFont(diskInfo: diskInfo)
            bigSurInstallerAppXfer(isBeta: false, BootVolume: diskInfo)
            createDiskEnded(completed: true)
  
        }
    }
}
