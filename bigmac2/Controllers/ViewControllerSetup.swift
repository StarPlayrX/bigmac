//
//  ViewSetup.swift
//  bigmac2
//
//  Created by starplayrx on 12/30/20.
//

import Cocoa

//MARK: Main View Setup
extension ViewController {
    
    //MARK: View Will Appear
    override func viewWillAppear() {
        super.viewWillAppear()
                  
        progressBarDownload.doubleValue = 0 //set progressBar to 0 at star
        
        rootMode = NSUserName() == "root" ? true : false
        
        installerFuelGauge.doubleValue = 0
        
        let defaults = UserDefaults.standard
        var counter = 0
        
        isBaseVerbose    = defaults.bool(forKey: "isBaseVerbose")
        isBaseSingleUser = defaults.bool(forKey: "isBaseSingleUser")
        isSysVerbose     = defaults.bool(forKey: "isSysVerbose")
        isSysSingleUser  = defaults.bool(forKey: "isSysSingleUser")
        
        enableUSB       = defaults.bool(forKey: "enableUSB")
        disableBT2      = defaults.bool(forKey: "disableBT2")
        teleTrap        = defaults.bool(forKey: "teleTrap")
        VerboseBoot     = defaults.bool(forKey: "VerboseBoot")
        superDrive      = defaults.bool(forKey: "superDrive")
        appStoreMacOS   = defaults.bool(forKey: "appStoreMacOS")
        appleHDA        = defaults.bool(forKey: "appleHDA")
        hdmiAudio       = defaults.bool(forKey: "hdmiAudio")
        singleUser      = defaults.bool(forKey: "singleUser")
        legacyWiFi      = defaults.bool(forKey: "legacyWiFi")
        
        installKCs      = defaults.bool(forKey: "installKCs")
        blessSystem     = defaults.bool(forKey: "blessSystem")
        deleteSnaphots  = defaults.bool(forKey: "deleteSnaphots")
         
        isBaseSingleUser ? (singleUserCheckbox.state = .on) : (singleUserCheckbox.state = .off)
        isBaseVerbose    ? (verboseUserCheckbox.state = .on) : (verboseUserCheckbox.state = .off)
        
         _ =  enableUSB       ? (enableUSB_btn.state = .on,      counter += 1)         : (enableUSB_btn.state = .off, ())
         _ =  disableBT2      ? (disableBT2_btn.state = .on,     counter += 1)         : (disableBT2_btn.state = .off, ())
         _ =  teleTrap        ? (teleTrap_btn.state = .on,       counter += 1)         : (teleTrap_btn.state = .off, ())
         _ =  VerboseBoot     ? (VerboseBoot_btn.state = .on,    counter += 1)         : (VerboseBoot_btn.state = .off, ())
         _ =  superDrive      ? (superDrive_btn.state = .on,     counter += 1)         : (superDrive_btn.state = .off, ())
         _ =  appStoreMacOS   ? (appStoreMacOS_btn.state = .on,  counter += 1)         : (appStoreMacOS_btn.state = .off, ())
         _ =  appleHDA        ? (appleHDA_btn.state = .on,       counter += 1)         : (appleHDA_btn.state = .off, ())
         _ =  hdmiAudio       ? (hdmiAudio_btn.state = .on,      counter += 1)         : (hdmiAudio_btn.state = .off, ())
         _ =  singleUser      ? (singleUser_btn.state = .on,     counter += 1)         : (singleUser_btn.state = .off, ())
         _ =  legacyWiFi      ? (legacyWiFi_btn.state = .on,     counter += 1)         : (legacyWiFi_btn.state = .off, ())
         _ =  installKCs      ? (updateBootSysKCs.state = .on,   counter += 1)         : (updateBootSysKCs.state = .off, ())
         _ =  blessSystem     ? (BlessVolume.state = .on,        counter += 1)         : (BlessVolume.state = .off, ())
         _ =  deleteSnaphots  ? (deleteAPFSSnapshotsButton.state = .on, counter += 1)  : (deleteAPFSSnapshotsButton.state = .off, ())
            
        //MARK: Maybe create a struct for the check selection and add on other things like last tab used
        
        //MARK: To do Generate an AI that knows what should be checked for the User, Defaulting to Mac Pro 3,1 Generic Specs
        if counter == 0 {
            enableUSB = false
            enableUSB_btn.state = .off
            
            disableBT2 = true
            disableBT2_btn.state = .on
                        
            teleTrap = true
            teleTrap_btn.state = .on
            
            VerboseBoot = false
            VerboseBoot_btn.state = .off
            
            superDrive = true
            superDrive_btn.state = .on
            
            appStoreMacOS = false
            appStoreMacOS_btn.state = .off
            
            appleHDA = true
            appleHDA_btn.state = .on
            
            hdmiAudio = false
            hdmiAudio_btn.state = .off
            
            singleUser = false
            singleUser_btn.state = .off
            
            legacyWiFi = false
            legacyWiFi_btn.state = .off
            
            installKCs = true
            updateBootSysKCs.state = .on
            
            blessSystem = true
            BlessVolume.state = .on
            
            deleteSnaphots = true
            deleteAPFSSnapshotsButton.state = .on
        }
    }
}
