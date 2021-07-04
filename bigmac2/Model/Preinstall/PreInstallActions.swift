//
//  PreInstallActions.swift
//  bigmac2
//
//  Created by starplayrx on 12/31/20.
//
import Cocoa

extension ViewController {
    @IBAction func LaunchInstallerAction(_ sender: Any) {
    
        preInstaLaunchBtn.isEnabled = false
        
        let libVal = DisableLibraryValidation.state == .on
        let SIP = DisableSIP.state == .on
        let AR = DisableAuthRoot.state == .on
        let GK = DisableGateKeeper.state == .on
    
        func macOS(installer: String) {
            if !ranHax3 {
                ranHax3 = true
                runCommand(binary: "/bin/launchctl", arguments: ["setenv", "DYLD_INSERT_LIBRARIES", "/\(tmp)/\(bigdata)/\(haxDylib)"])
            }
            
            let bigMacApp = Bundle.main.bundlePath
            runCommand(binary: "\(bigMacApp)/Contents/Resources/lax" , arguments: [installer])
            
            DispatchQueue.global(qos: .background).async {
                for i in 1...6 {
                    sleep(1)
                    DispatchQueue.main.async { [self] in
                        preInstallSpinner.doubleValue = Double(i)
                        
                        if i == 6 {
                            sleep(2) //try to prevent another launch
                            preInstaLaunchBtn.isEnabled = true
                        }
                    }
                }
            }
        }
        
        func preInstallRunner(libVal: Bool, SIP: Bool, AR: Bool) {
            var bootArgs = ""
            
            if suGlobalBootArgs.state == .on {
                bootArgs = bootArgs + "-s "
            }
            
            if verboseGlobalBootArgs.state == .on {
                bootArgs = bootArgs + "-v "
            }
            
            if amfiGlobalBootArgs.state == .on {
                bootArgs = bootArgs + "amfi_get_out_of_my_way=1 "
            }
            
            if amfiGlobalBootArgs.state == .on {
                bootArgs = bootArgs + "-no_compat_check "
            }
            
            #if arch(x86_64)
            if !bootArgs.isEmpty {
                bootArgs = bootArgs + "arch=x86_64"
            }
            #endif
            
            runCommand(binary: "/usr/sbin/nvram" , arguments: ["boot-args=\(bootArgs)"])
            
            if libVal {
                runCommand(binary: "/usr/bin/defaults" , arguments: ["write", "/Library/Preferences/com.apple.security.libraryvalidation.plist", "DisableLibraryValidation", "-bool", "true"])
            }
            
            //MARK: Disable SIP
            if SIP {
                runCommand(binary: "/usr/bin/csrutil" , arguments: ["disable"])
            }
            
            //MARK: Disable AR
            if AR {
                runCommand(binary: "/usr/bin/csrutil" , arguments: ["authenticated-root", "disable"])
            }
            
            //MARK: Disable GateKeeper
            if GK {
                runCommand(binary: "/usr/sbin/spctl" , arguments: ["--master-disable"])
            } else {
                runCommand(binary: "/usr/sbin/spctl" , arguments: ["--master-enable"])
            }
            
            let fileManager = FileManager.default
            
            var installAsstBaseOS = installVersionIsLegacy ? installAsstBaseOS11 : installAsstBaseOS12
            var installAsstFullOS = installVersionIsLegacy ? installAsstFullOS11 : installAsstFullOS12
            
            let fm = FileManager.default
            if fm.fileExists(atPath: installAsstBaseOS) {
                
                // Verifies what installation we may be working with
                if let legacyFileSize = try? fileManager.attributesOfItem(atPath: installAsstBaseOS11)[FileAttributeKey.size] as? Double {
                    print("legacyFileSize", legacyFileSize)
                    installVersionIsLegacy = legacyFileSize > Double(80000) ? true : false
                }
                
                installAsstBaseOS = installVersionIsLegacy ? installAsstBaseOS11 : installAsstBaseOS12

                macOS(installer: installAsstBaseOS)
           
            } else if fm.fileExists(atPath: installAsstFullOS) {
                globalError = "Only clean installs from Mac OS Extended Journaled (JHFS+) volumes are supported from a full version of macOS. To install or upgrade directly to APFS disks, boot from the bigmac2 Installation Disk. If you have a boot screen, reboot using the option key."
                
                // Verifies what installation we may be working with
                if let legacyFileSize = try? fileManager.attributesOfItem(atPath: installAsstFullOS11)[FileAttributeKey.size] as? Double {
                    print("legacyFileSize", legacyFileSize)
                    installVersionIsLegacy = legacyFileSize > Double(80000) ? true : false
                }
                
                installAsstFullOS = installVersionIsLegacy ? installAsstFullOS11 : installAsstFullOS12
                performSegue(withIdentifier: "displayErrMsg", sender: self)
                macOS(installer: installAsstFullOS)
            } else {
                globalError = "It does not appear that you have downloaded a macOS installer yet. Please go to the Downloads tab and download macOS or obtain a fresh installer from Apple."
                
                performSegue(withIdentifier: "displayErrMsg", sender: self)
                preInstaLaunchBtn.isEnabled = true
            }
            
        }
        
        preInstallRunner(libVal: libVal, SIP: SIP, AR: AR)
        
    }
}
