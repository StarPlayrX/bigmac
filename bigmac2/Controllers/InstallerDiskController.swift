//
//  InstallerDiskController.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//

import Cocoa

class InstallViewController: NSViewController {

    override func viewWillAppear() {
        super.viewDidAppear()
       
    }
    
    override func viewWillDisappear() {
    }
    
    @IBAction func donateButton_Action(_ sender: Any) {
        donate2BigMac()
        dismiss(self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(self)
    }
    
    override func viewDidLoad() {
        view.window?.titlebarAppearsTransparent = true
        view.window?.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)
        view.window?.title = "🍔 Big Mac 2.0"
        view.window?.level = .floating
        view.window?.styleMask = .borderless
    }
    
    @IBAction func okButton(_ sender: Any) {
        dismiss(self)

        var bless = globalVolumeInfo.path + "/usr/sbin/bless"
        var path = globalVolumeInfo.path + "/"
        
        if globalVolumeInfo.root {
            bless = globalVolumeInfo.path + "usr/sbin/bless"
            path = globalVolumeInfo.path
        }
        
        runCommand(binary: bless, arguments: ["--mount", "\(path)", "--folder", "\(path)System/Library/CoreServices", "--bootefi", "--label", globalVolumeInfo.displayName, "--setBoot", "--nextonly"])
        
        runCommand(binary: "/sbin/reboot", arguments: [])
    }
}
