//
//  FileDownloader.swift
//  bigmac2
//
//  Created by starplayrx on 12/19/20.
//

import Cocoa

extension ViewController : URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Void {
        
        let a = round (Float(totalBytesWritten) / 1000 / 1000 / 10 ) / 100 //Gigabytes In
        if !a.isFinite || a.isNaN { return }

        let b = round (Float(totalBytesExpectedToWrite) / 1000 / 1000 / 10 ) / 100 //Gigabytes Max
        if !b.isFinite || b.isNaN || b.isZero { return }
        
        if ( a / b ).isNaN || ( a / b ).isInfinite { return }

        let percentageDouble = Double ( a / b * 100 )
        let percentageInt = Int ( a / b * 100 )
        
        func updateScreen() {
            DispatchQueue.main.async { [self] in
                
                let padding = String(a).count < 4 ? "0" : ""
                gbLabel.stringValue = "\(a)\(padding) GB / \(b) GB"
                progressBarDownload.doubleValue = percentageDouble
                percentageLabel.stringValue = "\(percentageInt)%"
            }
        }
        
        if Float(percentageInt) != downloadProgress {
            updateScreen()
            downloadProgress = Float(percentageInt)
        } else if a == b && a > 0 {
            
            updateScreen()
            DispatchQueue.main.async { [self] in
                createInstallSpinner.isHidden = true
                createInstallSpinner.stopAnimation(self)
            }
            
        } else if downloadDataProgress != a {
            updateScreen()
            downloadDataProgress = a
        }
       
        if globalWorkItem == nil || globalDispatch == nil {
            downloadTask.cancel()
            session.invalidateAndCancel()
        }
    }
    
    //to do add error handling
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let fm = FileManager.default
        
        func moveItem(at: URL, to: URL) {
            do {
                try fm.moveItem(at: at, to: to)

            } catch {
                    print(error)
            }
        }
        
        if let filename = downloadTask.currentRequest?.url?.lastPathComponent {
            
            if filename.hasSuffix(".dmg") && !filename.contains("macOS") {
               // let test = applicat
                let resourceURL = Bundle.main.resourceURL
            
                if let savedURL = resourceURL?.appendingPathComponent ( filename) {
               
                    if filename == bigmacDMG, let userURL = try? fm.url (for: .userDirectory, in: .localDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Shared/" + filename)  {
                        moveItem(at: location, to: userURL  )
                        sleep(1)
                        globalCompletedTask()
                        NotificationCenter.default.post(name: .CreateDisk, object: nil)
                    }
                    
                    if filename == dosDude1DMG {
                        moveItem(at: location, to: savedURL)
                        sleep(1)
                        _ = mountDiskImage(arg: ["mount", "\(savedURL.path)", "-noverify", "-noautofsck", "-autoopen"])
                        sleep(1)
                        globalCompletedTask()
                    }
                   
                    if filename == bigDataDMG {
                        moveItem(at: location, to: savedURL)
                        sleep(1)
                        mountBigData()
                        sleep(1)
                        globalCompletedTask()
                    }
                }
              

            } else {
                let documentsURL = try? fm.url(for: .userDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
                let savedURL = documentsURL?.appendingPathComponent ( shared + filename)
                
                if let savedURL = savedURL {
                    try? fm.moveItem(at: location, to: savedURL)
                    sleep(1)
                    _ = updateInstallerPkg()
                    sleep(1)
                    globalCompletedTask()
                }
                
                globalCompletedTask()
            }
        }
    }
    
    func download(urlString: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self as URLSessionDelegate, delegateQueue: nil)
        
        if let url = NSURL(string: urlString) {
            let task = session.downloadTask(with: url as URL)
            
            task.resume()
            
            DispatchQueue.main.async { [self] in
                createInstallSpinner.isHidden = false
                createInstallSpinner.startAnimation(self)
            }
        }
    }
    
    func startCopy(sourcePath: String, targetPath: String) {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: targetPath) == true {
            try? fileManager.removeItem(atPath: targetPath)
        }
        
        if fileManager.fileExists(atPath: targetPath) == false {
            try? fileManager.copyItem(atPath: sourcePath, toPath: targetPath)
        }
        
        DispatchQueue.main.async { [self] in
            createInstallSpinner.isHidden = false
            createInstallSpinner.startAnimation(self)
        }
        
    }
    
    @objc func checkFileSize(sourcePath: String, targetPath: String ) {
        let fileManager = FileManager.default
        
        do {
            let fileSize = try fileManager.attributesOfItem(atPath: sourcePath)[FileAttributeKey.size] as? Double
            let fileSizeTarget = try fileManager.attributesOfItem(atPath: targetPath)[FileAttributeKey.size] as? Double
            
            if let fileSizeTarget = fileSizeTarget, let fileSize = fileSize {
                
                if fileSize.isInfinite || fileSize.isNaN { return }
                if fileSizeTarget.isInfinite || fileSizeTarget.isNaN { return }
                
                let gigsCopied = round ( fileSizeTarget / 1000 / 1000 / 10 ) / 100
                let gigsTotal = round ( fileSize / 1000 / 1000 / 10 ) / 100
                
                if Double(gigsCopied / gigsTotal * 100).isInfinite || Double(gigsCopied / gigsTotal * 100).isNaN { return }
                
                let percentageDouble = Double(gigsCopied / gigsTotal * 100)
                let percentageInt = Int(gigsCopied / gigsTotal * 100)
                
                DispatchQueue.main.async(execute: { [self] in
                    
                    sharedSupportProgressBar.doubleValue = percentageDouble
                    sharedSupportPercentage.stringValue = "\(percentageInt)%"
                    sharedSupportGbLabel.stringValue = "\(gigsCopied) GB / \(gigsTotal) GB"
                })
                
                if ( gigsCopied == gigsTotal && gigsCopied != 0.0 && gigsTotal != 0  ) {
                    timer?.invalidate()
                    
                    DispatchQueue.main.async(execute: { [self] in
                        
                        createInstallSpinner.stopAnimation(self)
                        createInstallSpinner.isHidden = true
                    })
                }
            }
        } catch {
            print(error)
        }
    }
    
    func copyFile(atPath sourcePath: String, toPath targetPath: String) {
        DispatchQueue.main.async { [self] in
            
            timer?.invalidate()
            timer = nil
            sleep(1)
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] timer in
                checkFileSize(sourcePath: sourcePath, targetPath: targetPath)
            }
        }
    
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: targetPath) {
            
            do {
                try fileManager.removeItem(atPath: targetPath)
            } catch {
                print(error)
            }
        }
        
        startCopy(sourcePath: sourcePath, targetPath: targetPath)
    }
}
