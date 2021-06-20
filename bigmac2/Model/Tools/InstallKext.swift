//
//  InstallKext.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//

import Foundation

extension ViewController {
    
    func installKext(dest: String, kext: String, fold: String, prfx: String = "", ttle: String = "") -> Bool {
        var strg = ""
        let fail = "Do not pass"
        var pass = false
        let copy = "Copying"
        let inst = "Installing"
        let dots = "..."
        let source = "\(tmpFolder)\(bigdata)"
    
        let destiny = "\(dest)/\(fold)/\(kext)"
        let mdir = "\(dest)/\(fold)/"
        
        if ttle.isEmpty {
            indicatorBump(taskMsg: "\(inst) \(kext)\(dots)", detailMsg: "\(destiny)")
        } else {
            indicatorBump(taskMsg: "\(inst) \(ttle)\(dots)", detailMsg: "\(destiny)")
        }
        
        if kext.contains("lib") {
            runCommand(binary: "/bin/mkdir", arguments: [mdir])
        }
        
        print(["-v", "\(source)/\(prfx)\(kext)", destiny])
        
        try? fm.removeItem(atPath: destiny)
        
        strg = runCommandReturnStr(binary: "/usr/bin/ditto", arguments: ["-v", "\(source)/\(prfx)\(kext)", destiny]) ?? fail
        print(strg)
        let x = runCommandReturnStr(binary: "/usr/sbin/chown", arguments: ["-R", "0:0", destiny])
        print(x as Any)
        let y = runCommandReturnStr(binary: "/bin/chmod", arguments: ["-R", "755", destiny])
        print(y as Any)
        //runCommand(binary: "/usr/bin/touch", arguments: [destiny])
        
        strg = strg.replacingOccurrences(of: "\n", with: "")
        strg = strg.replacingOccurrences(of: "\r", with: "")
        strg = strg.replacingOccurrences(of: " ", with: "")
        
        if strg.hasPrefix(copy) && strg.hasSuffix(kext)  {
            pass = !pass
        }
        
        print(pass)
        
        return pass
    }
}

