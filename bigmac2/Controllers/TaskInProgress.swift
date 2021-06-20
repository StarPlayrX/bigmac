//
//  TaskInProgress.swift
//  bigmac2
//
//  Created by starplayrx on 1/12/21.
//

import Cocoa

class TaskInProgController : NSViewController {
    
    @IBOutlet weak var taskLabel: NSTextField!
    
    @IBOutlet weak var taskBar: NSProgressIndicator!
    
    @IBAction func cancelTask(_ sender: Any) {
        dismiss(self)
        
        if let _ = globalDispatch, let _ = globalWorkItem {
            globalDispatch = nil
            globalWorkItem = nil
        }
   
        taskBar.stopAnimation(self)

    }
    
    @IBAction func continueTask(_ sender: Any) {
        cancel()
    }
    
    var timer : Timer!
    
    func cancel() {
        timer?.invalidate()
        
        if let _ = timer {
            timer = nil
        }
        dismiss(self)
        taskBar.stopAnimation(self)
    }
    
    func autoCancel() {
        if globalDispatch == nil || globalWorkItem == nil {
            cancel()
        }
    }
    
    func startTimer() {
        DispatchQueue.main.async { [self] in
            
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [self] timer in
                autoCancel()
            }
        }
    }
    
    override func viewDidLoad() {
        taskBar.startAnimation(self)
        
        if let d = globalDispatch {
            taskLabel.stringValue = "\(d.label) is running.\nPlease wait for it to complete."
        }
        
        startTimer()
    }
}
