//
//  ErrrMsgController.swift
//  bigmac2
//
//  Created by starplayrx on 1/16/21.
//

import Cocoa

class ErrorMsgController : NSViewController {
    
    @IBOutlet weak var errMsgLabel: NSTextField!
    
    @IBAction func okButton(_ sender: Any) {
        dismiss(self)
    }
    
    
    override func viewDidLoad() {
        errMsgLabel.stringValue = globalError
        
    }
}
