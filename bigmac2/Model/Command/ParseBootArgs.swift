//
//  ParseBootArgs.swift
//  bigmac2
//
//  Created by starplayrx on 12/30/20.
//

import Foundation

extension ViewController {
    func parseBootArgs() {
        var bootargs = runCommandReturnString(binary: "/usr/sbin/nvram", arguments: ["-p"])
        
        let nvramArray = bootargs?.components(separatedBy: "\n")
        
        if let nvramArray = nvramArray {
            for i in nvramArray {
                if i.contains("boot-args") {
                    bootargs = i
                }
            }
        }
      
        bootargs = bootargs?.replacingOccurrences(of: "boot-args\t", with: "")
        bootargs = bootargs?.replacingOccurrences(of: "\"", with: "")

        if let b = bootargs, !b.isEmpty {
            bootArgsField.stringValue = b
        } else {
            bootArgsField.stringValue = ""
        }
    }
}
