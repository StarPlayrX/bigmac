//
//  AppDelegate.swift
//  bigmac2
//
//  Created by starplayrx on 12/18/20.
//

import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let defaults = UserDefaults.standard
        installVersionIsLegacy = defaults.bool(forKey: "installVersionIsLegacy")
    }
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if flag == false {

            for window in sender.windows {

                if (window.delegate?.isKind(of: ViewController.self)) == true {
                    window.orderFront(self)
                } else {
                    window.makeKeyAndOrderFront(self)
                }
            }
        }
        return true
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
        if NSUserName() == root {
            unmountBigData()
        }
        
        func save() {
            //ToDo Switch to an array and loop over or a dictionary, could even use a Struct
            let defaults = UserDefaults.standard
            defaults.set(isBaseVerbose, forKey: "isBaseVerbose")
            defaults.set(isBaseSingleUser, forKey: "isBaseSingleUser")
            defaults.set(enableUSB, forKey: "enableUSB")
            defaults.set(disableBT2, forKey: "disableBT2")
            defaults.set(teleTrap, forKey: "teleTrap")
            defaults.set(VerboseBoot, forKey: "VerboseBoot")
            defaults.set(superDrive, forKey: "superDrive")
            defaults.set(appStoreMacOS, forKey: "appStoreMacOS")
            defaults.set(appleHDA, forKey: "appleHDA")
            defaults.set(hdmiAudio, forKey: "hdmiAudio")
            defaults.set(legacyWiFi, forKey: "legacyWiFi")
            defaults.set(installKCs, forKey: "installKCs")
            defaults.set(blessSystem, forKey: "blessSystem")
            defaults.set(deleteSnaphots, forKey: "deleteSnaphots")
            defaults.set(singleUser, forKey: "singleUser")
            defaults.set(amdMouSSE, forKey: "amdMouSSE")
            defaults.set(installVersionIsLegacy, forKey: "installVersionIsLegacy")
        }
        
        save()
        
        //MARK: Stop kernel process
        runCommand(binary: "/usr/bin/killall", arguments: ["kmutil"]) //to do: capture its pid and kill it by its pid
        
        runCommand(binary: "/usr/sbin/diskutil", arguments: ["unmount", bigDataStr])
        runCommand(binary: "/usr/sbin/diskutil", arguments: ["eject", bigDataStr])
    }
}

    
  

