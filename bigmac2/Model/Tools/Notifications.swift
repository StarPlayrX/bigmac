//
//  Notifications.swift
//  bigmac2
//
//  Created by starplayrx on 12/28/20.
//

import Cocoa

//MARK: Notification Extensions
extension Notification.Name {
    static let EraseDisk = Notification.Name("EraseDisk")
    static let EraseDmgBootDisk = Notification.Name("EraseDmgBootDisk")
    static let EraseInstallDisk = Notification.Name("EraseInstallDisk")
    static let CreateDisk = Notification.Name("DownloadBigMacDisk")
    static let RunAsRootRequest = Notification.Name("RunAsRootRequest")
    static let Runner = Notification.Name("Runner")
}

//MARK: Notfications Actions
extension ViewController {
    
    //MARK: Phase 1.2
    @objc func RunAsRootRequest(_ notification:Notification){
        
        let pw = notification.object as? String ?? ""

        //MARK: runs our app as root, pretty sweet
        let bigMacApp = Bundle.main.bundlePath
        runCommand(binary: "\(bigMacApp)/Contents/Resources/bm2" , arguments: [ "\(bigMacApp)/Contents/MacOS/bigmac2", pw ])
        exit(0)
    }

}

//MARK: Load Notifications - Add Observers
extension ViewController {
        
    override func viewDidAppear() {
        let notifications = NotificationCenter.default

        notifications.addObserver(self, selector: #selector(EraseDisk), name: .EraseDisk, object: nil)
        notifications.addObserver(self, selector: #selector(CreateDisk), name: .CreateDisk, object: nil)
        notifications.addObserver(self, selector: #selector(RunAsRootRequest), name: .RunAsRootRequest, object: nil)
        
        if NSUserName() != root {
            performSegue(withIdentifier: "userNamePassWord", sender: nil)
        }
    }
}
