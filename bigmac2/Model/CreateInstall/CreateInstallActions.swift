//
//  InstallerActions.swift
//  bigmac2
//
//  Created by starplayrx on 12/28/20.
//
import Cocoa

//MARK: Installer Actions
extension ViewController {
    
    @IBAction func baseVerboseAction(_ sender: Any) {
        isBaseVerbose = verboseUserCheckbox.state == .on
    }


    @IBAction func baseSingleUserAction(_ sender: Any) {
        isBaseSingleUser = singleUserCheckbox.state == .on
    }
    
    @IBAction func downloadMacOSAction(_ sender: Any) {
        if cancelTask() { return }
    
        installVersionIsLegacy = installerVersion.title.lowercased().contains(installLegacyVersion.lowercased()) ? true : false
        
        //MARK: To Do - connect this a backend where we can possibly choose the download OR always download the latest
        //useDmgInstaller
        let macOS = installVersionIsLegacy ? globalDownloadMacOSpkg11 : globalDownloadMacOSpkg12
        let version = installVersionIsLegacy ? macOS11 : macOS12
        
        downloadMacOSTask(label: "Downloading \(version)", urlString: macOS)
    }

    //MARK: Phase 1.0
    @IBAction func createInstallDisk(_ sender: Any) {
        globalInstall = install.bootIso
        
        installVersionIsLegacy = installerVersion.title.lowercased().contains(installLegacyVersion.lowercased()) ? true : false

        if cancelTask() { return }
        //Erase a Disk first
        self.performSegue(withIdentifier: "eraseDisk", sender: self)
    }
    
    
    //MARK: Download APFS ROM Patcher
    @IBAction func apfsRomDownload(_ sender: Any) {
        if cancelTask() { return }

        dosDude1inProgressTask(label: "Downloading APFS ROM Patcher", dmg: dosDude1Dmg)
    }
}
