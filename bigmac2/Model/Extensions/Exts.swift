//
//  shakeExt.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//

import Cocoa

extension NSView {
    func shake(duration: CFTimeInterval) {
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation]
        shakeGroup.duration = duration
        self.layer?.add(shakeGroup, forKey: "shakeIt")
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
    
    func stringAfter(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(suffix(from: index).dropFirst())
        } else {
            return ""
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
