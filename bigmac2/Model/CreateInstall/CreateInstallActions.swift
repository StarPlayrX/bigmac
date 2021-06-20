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
        verboseUserCheckbox.state == .on ? (isBaseVerbose = true) : (isBaseVerbose = false)
    }


    @IBAction func baseSingleUserAction(_ sender: Any) {
        singleUserCheckbox.state == .on ? (isBaseSingleUser = true) : (isBaseSingleUser = false)
    }
 
    
    @IBAction func downloadMacOSAction(_ sender: Any) {
        if cancelTask() { return }
        
        //MARK: To Do - connect this a backend where we can possibly choose the download OR always download the latest
        //useDmgInstaller
        let macOS = globalDownloadMacOSpkg
      
        downloadMacOSTask(label: "Downloading macOS", urlString: macOS)
    }

    //MARK: Phase 1.0
    @IBAction func createInstallDisk(_ sender: Any) {
        globalInstall = install.bootIso
        if cancelTask() { return }
        //Erase a Disk first
        self.performSegue(withIdentifier: "eraseDisk", sender: self)
    }
    
    
    //MARK: Download APFS ROM Patcher
    @IBAction func apfsRomDownload(_ sender: Any) {
        if cancelTask() { return }

        dosDude1inProgressTask(label: "Downloading APFS ROM Patcher", dmg: dosDude1DMG)
    }
}


