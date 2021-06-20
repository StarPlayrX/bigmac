//
//  PatchBool.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//

import Foundation

extension ViewController {
    
    //Gather checboxes
    func patchBool() {
        enableUSB       = enableUSB_btn.state == .on
        enableUSBtl     = enableUSB_btn.title
        
        disableBT2      = disableBT2_btn.state == .on
        disableBT2tl    = disableBT2_btn.title
        
        amdMouSSE       = amdMouSSE_btn.state == .on
        amdMouSSEtl     = amdMouSSE_btn.title

        teleTrap        = teleTrap_btn.state == .on
        teleTraptl      = teleTrap_btn.title
        
        VerboseBoot     = VerboseBoot_btn.state == .on
        VerboseBoottl   = VerboseBoot_btn.title

        superDrive      = superDrive_btn.state == .on
        superDrivetl    = superDrive_btn.title
        
        appleHDA        = appleHDA_btn.state == .on
        appleHDAtl      = appleHDA_btn.title
        
        hdmiAudio       = hdmiAudio_btn.state == .on
        hdmiAudiotl     = hdmiAudio_btn.title
        
        appStoreMacOS   = appStoreMacOS_btn.state == .on
        appStoreMacOStl = appStoreMacOS_btn.title
        
        singleUser      = singleUser_btn.state == .on
        singleUsertl    = singleUser_btn.title
        
        legacyWiFi      = legacyWiFi_btn.state == .on
        legacyWiFitl    = legacyWiFi_btn.title
        
        installKCs      = updateBootSysKCs.state == .on
        installKCstl    = updateBootSysKCs.title
        
        blessSystem     = BlessVolume.state == .on
        blessSystemtl   = BlessVolume.title
        
        deleteSnaphots   = deleteAPFSSnapshotsButton.state == .on
        deleteSnaphotstl = deleteAPFSSnapshotsButton.title
        
        drivX            = availablePatchDisks.title
    }
}
