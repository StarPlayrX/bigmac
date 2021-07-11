//
//  InstallKCs.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//

import Foundation

extension ViewController {
    
    /* Update System Caches on macOS 11.1 and later */
    func updateMac11onMac11SystemCache(destVolume: String) {
        if !kmMonitor {
            DispatchQueue.global(qos: .background).async { [self] in
                runIndeterminateProcess(binary: "/usr/bin/kmutil", arguments: ["log", "stream"], title: "Updating KCs...")
                kmMonitor = true
            }
        }
        
        //MARK: Constants
        let bigMacApp = Bundle.main.bundlePath
        let kmu = "kmu"
        
        // Update Kernel Extensions
        runCommand(binary: "\(bigMacApp)/Contents/Resources/\(kmu)" , arguments: [ destVolume ])
        
        // Copy Kernel Extensions (Takes not arguments and will fail if arguments are added
        runCommand(binary: "\(destVolume)/usr/sbin/kcditto" , arguments: [])
    }
}
