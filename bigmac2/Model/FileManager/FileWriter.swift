//
//  FileWriter.swift
//  bigmac2
//
//  Created by starplayrx on 12/29/20.
//
import Foundation

func txt2file(text: String, file: String) {

    //writing
    do {
        try text.write(toFile: file, atomically: false, encoding: String.Encoding.utf8)
        runCommand(binary: "/usr/sbin/chown", arguments: ["0:0", file])
        runCommand(binary: "/bin/chmod", arguments: ["755", file])
    } catch {
       print(error)
    }
}
