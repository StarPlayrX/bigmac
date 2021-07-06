//
//  MainWIndowViewController.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//
import Cocoa

class WindowController : NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        _ = performAppleScript(script: "tell me to activate")

        if NSUserName() == root {
            window?.setFrameAutosaveName("bigMacMainView")
            window?.level = .normal
            shouldCascadeWindows = false
            window?.titlebarAppearsTransparent = true
            window?.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)
            window?.title = "🍔 Big Mac 2.0"
        } else {
            window?.alphaValue = 0.0
            window?.setFrameAutosaveName("") // don't save window position if it's not the root user. Otherwise things get weird
            window?.level = .floating
            
            if let x = window?.frame.minX, let y = window?.frame.minX, let w = window?.minSize.width, let h = window?.minSize.height {                
                window?.setFrame(NSRect(x:x, y: (h + y * 0.375),width: w, height: h), display: true)
            }
        }
    }
}
