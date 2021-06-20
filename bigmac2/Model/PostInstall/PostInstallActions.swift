//
//  postInstallAction.swift
//  bigmac2
//
//  Created by starplayrx on 1/1/21.
//

import Cocoa

extension ViewController {
    
    
    @IBAction func patchDiskExec_action(_ sender: Any) {
        
        postInstallTask_label.stringValue = "Starting Post Install Process..."
        postInstallDetails_label.stringValue = ""
        postInstallFuelGauge.doubleValue = 0
        postInstallProgressIndicator.doubleValue = 1
        postInstallSpinner.startAnimation(sender)
        postInstallSpinner.isHidden = false
        patchBool()
        
        DispatchQueue.global(qos: .background).async { [self] in
            PostInstall()
            
            DispatchQueue.main.async {}
        }
    }
    
    @IBAction func patchDiskAction(_ sender: Any) {
        if let disk = getVolumeInfoByDisk(filterVolumeName: availablePatchDisks.title, disk: "", isRoot: true) {
            globalVolumeInfo = disk
        }
    }
    
    @IBAction func legacyUSB_act(_ sender: Any) {
        enableUSB_btn.state == .on ? (enableUSB = true) : (enableUSB = false)
    }
    
    @IBAction func disableBluetooth_act(_ sender: Any) {
        disableBT2_btn.state == .on ? (disableBT2 = true) : (disableBT2 = false)
    }
    
    @IBAction func legacyWiFi_Action_act(_ sender: Any) {
        legacyWiFi_btn.state == .on ? (legacyWiFi = true) : (legacyWiFi = false)
    }
    
    
    
    
    @IBAction func mouSSE_Action_act(_ sender: Any) {
        amdMouSSE_btn.state == .on ? (amdMouSSE = true) : (amdMouSSE = false)
    }
    
    @IBAction func teleTrap_Action_act(_ sender: Any) {
        teleTrap_btn.state == .on ? (teleTrap = true) : (teleTrap = false)
    }
    
    @IBAction func verboseBoot_act(_ sender: Any) {
        VerboseBoot_btn.state == .on ? (VerboseBoot = true) : (VerboseBoot = false)
    }
    
    @IBAction func singleUser_act(_ sender: Any) {
        singleUser_btn.state == .on ? (singleUser = true) : (singleUser = false)
    }
    
    @IBAction func superDrive_act(_ sender: Any) {
        superDrive_btn.state == .on ? (superDrive = true) : (superDrive = false)
    }
    
    @IBAction func appleHDA_act(_ sender: Any) {
        appleHDA_btn.state == .on ? (appleHDA = true) : (appleHDA = false)
    }
    
    @IBAction func hdmiAudio_act(_ sender: Any) {
        hdmiAudio_btn.state == .on ? (hdmiAudio = true) : (hdmiAudio = false)
    }
    
    @IBAction func appStoreMacOsDownloads_act(_ sender: Any) {
        appStoreMacOS_btn.state == .on ? (appStoreMacOS = true) : (appStoreMacOS = false)
    }
    
    @IBAction func deleteApfsSnapshots_act(_ sender: Any) {
        deleteAPFSSnapshotsButton.state == .on ? (deleteSnaphots = true) : (deleteSnaphots = false)
    }
    
    @IBAction func blessVolumeSetBoot_act(_ sender: Any) {
        BlessVolume.state == .on ? (blessSystem = true) : (blessSystem = false)
    }
    
    @IBAction func updateBootSystemKCs_act(_ sender: Any) {
        updateBootSysKCs.state == .on ? (installKCs = true) : (installKCs = false)
    }
}



