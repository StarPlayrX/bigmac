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
        enableUSB = enableUSB_btn.state == .on
    }
    
    @IBAction func disableBluetooth_act(_ sender: Any) {
        disableBT2 = disableBT2_btn.state == .on
    }
    
    @IBAction func legacyWiFi_Action_act(_ sender: Any) {
        legacyWiFi = legacyWiFi_btn.state == .on
    }
    
    @IBAction func mouSSE_Action_act(_ sender: Any) {
        amdMouSSE = amdMouSSE_btn.state == .on
    }
    
    @IBAction func teleTrap_Action_act(_ sender: Any) {
        teleTrap = teleTrap_btn.state == .on
    }
    
    @IBAction func verboseBoot_act(_ sender: Any) {
        VerboseBoot = VerboseBoot_btn.state == .on
    }
    
    @IBAction func singleUser_act(_ sender: Any) {
        singleUser = singleUser_btn.state == .on
    }
    
    @IBAction func superDrive_act(_ sender: Any) {
        superDrive = superDrive_btn.state == .on
    }
    
    @IBAction func appleHDA_act(_ sender: Any) {
        appleHDA = appleHDA_btn.state == .on
    }
    
    @IBAction func hdmiAudio_act(_ sender: Any) {
        hdmiAudio = hdmiAudio_btn.state == .on
    }
    
    @IBAction func appStoreMacOsDownloads_act(_ sender: Any) {
        appStoreMacOS = appStoreMacOS_btn.state == .on
    }
    
    @IBAction func deleteApfsSnapshots_act(_ sender: Any) {
        deleteSnaphots = deleteAPFSSnapshotsButton.state == .on
    }
    
    @IBAction func blessVolumeSetBoot_act(_ sender: Any) {
        blessSystem = BlessVolume.state == .on
    }
    
    @IBAction func updateBootSystemKCs_act(_ sender: Any) {
        installKCs = updateBootSysKCs.state == .on
    }
}



