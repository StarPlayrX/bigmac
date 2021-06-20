//
//  UserNamePassWord.swift
//  bigmac2
//
//  Created by starplayrx on 12/19/20.
//

import Cocoa

class CredsViewController: NSViewController {
    
    //MARK: Username and password is not save
    fileprivate var userName = ""
    fileprivate var passWord = ""
    
    @IBOutlet weak var passWordLabel: NSSecureTextField!
    @IBOutlet weak var userNameLabel: NSTextField!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    
    override func viewWillAppear() {
        super.viewDidAppear()
        progressBar.isHidden = true
        progressBar.startAnimation(self)
        if NSUserName() != root && !NSUserName().isEmpty {
            userNameLabel.stringValue = NSUserName()
        }
    }
    
    override func viewWillDisappear() {
        progressBar.isHidden = true
        progressBar.stopAnimation(self)
    }
    
    func saveNames() {
        if !userNameLabel.stringValue.isEmpty {
            userName = userNameLabel.stringValue
        }
        
        if !passWordLabel.stringValue.isEmpty {
            passWord = passWordLabel.stringValue
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //saveNames()
        dismiss(self)
        exit(0)
    }
    
    override func viewDidLoad() {
        view.window?.titlebarAppearsTransparent = true
        view.window?.styleMask.insert(NSWindow.StyleMask.fullSizeContentView)
        view.window?.title = "🍔 Big Mac 2.0"
        view.window?.level = .floating
        view.window?.styleMask = .borderless
    }
    
    @IBAction func okButton(_ sender: Any) {
        saveNames()
        progressBar.isHidden = false
        
        DispatchQueue.main.async { [self] in
            let codeword = "starplayrx"
            let script = "do shell script \"sudo echo \(codeword)\" user name \"\(userName)\" password \"\(passWord)\" with administrator privileges"
            let result = performAppleScript(script: script)
            if result.text == "starplayrx" {
                progressBar.isHidden = true
                dismiss(self)
                NotificationCenter.default.post(name: .RunAsRootRequest, object: passWord)
            } else {
                passWordLabel.resignFirstResponder()
                passWordLabel.shake(duration: 1)
                progressBar.isHidden = true
                passWordLabel.stringValue = ""
            }
        }
    }
}


