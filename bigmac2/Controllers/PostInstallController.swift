//
//  PostInstallController.swift
//  bigmac2
//
//  Created by starplayrx on 1/7/21.
//

import Cocoa

class PostInstallViewController : NSViewController {
    
    @IBOutlet var creditsTextView: NSTextView!
    
    @IBAction func blessAndBoot(_ sender: Any) {
        
        // if let app = appFolder  {
        var bless = globalVolumeInfo.path + "/usr/sbin/bless"
        var path = globalVolumeInfo.path + "/"
        
        if globalVolumeInfo.root {
            bless = globalVolumeInfo.path + "/usr/sbin/bless"
            path = globalVolumeInfo.path
        }
        
        //MARK: Bless and set boot
        runCommand(binary: bless, arguments: ["--mount", path, "--label", globalVolumeInfo.displayName, "--setBoot"])
        //MARK: Reboot
        runCommand(binary: "/sbin/reboot", arguments: [])
        dismiss(self)
    }
    
    @IBAction func Donate(_ sender: Any) {
        donate2BigMac()
        dismiss(self)
    }
    
    @IBAction func ThankYou(_ sender: Any) {
        dismiss(self)
    }
    
    override func viewDidLoad() {
        var font1 = NSFont(name:"Menlo",size:12)
        var font2 = NSFont(name:"Menlo",size:13)

        if #available(OSX 10.15, *) {
            font1 = NSFont.monospacedSystemFont(ofSize: 12, weight: NSFont.Weight.regular)
            font2 = NSFont.monospacedSystemFont(ofSize: 13, weight: NSFont.Weight.regular)
        }
    
        creditsTextView.isRichText = true
        creditsTextView.isEditable = false
        creditsTextView.isSelectable = false
    
        let orange: [NSAttributedString.Key: Any] = [.font: font1!, .foregroundColor: NSColor.systemOrange]
        let green: [NSAttributedString.Key: Any] = [.font: font2!, .foregroundColor: NSColor.systemGreen]
        
        let sep1 = "—————————————————————————————–––––––––"
        let separate1 = NSMutableAttributedString(string: sep1)
        separate1.addAttributes(orange, range: NSRange(location: 0, length: sep1.count))
        creditsTextView.textStorage?.append(separate1)
        
        let credits = "🍺 Big Mac      - Wall of Fame"
        let creditsText = NSMutableAttributedString(string: credits)
        creditsText.addAttributes(green, range: NSRange(location: 0, length: credits.count + 1))
        creditsTextView.textStorage?.append(creditsText)
        
        let sep2 = "\n—————————————————————————————–––––––––"
        let separate2 = NSMutableAttributedString(string: sep2)
        separate2.addAttributes(orange, range: NSRange(location: 0, length: sep2.count))
        creditsTextView.textStorage?.append(separate2)
        
        let name1 = "\n🍎 StarPlayrX   - Big Mac 2.0\n"
        let nameA = NSMutableAttributedString(string: name1)
        nameA.addAttributes(green, range: NSRange(location: 0, length: name1.count + 1))
        creditsTextView.textStorage?.append(nameA)
        
        let name2 = "\n🍊 DosDude1     - APFS ROM Patcher\n"
        let nameB = NSMutableAttributedString(string: name2)
        nameB.addAttributes(green, range: NSRange(location: 0, length: name2.count + 1))
        creditsTextView.textStorage?.append(nameB)
        
        let name3 = "\n🍏 ASentientBot - Hax3 Installer\n"
        let nameC = NSMutableAttributedString(string: name3)
        nameC.addAttributes(green, range: NSRange(location: 0, length: name3.count + 1))
        creditsTextView.textStorage?.append(nameC)
        
        let name4 = "\n🍓 BarryKN      - Hax3 APFS Support\n"
        let nameD = NSMutableAttributedString(string: name4)
        nameD.addAttributes(green, range: NSRange(location: 0, length: name4.count + 1))
        creditsTextView.textStorage?.append(nameD)
        
        let name4b = "\n🥥 CorpNewt     - USB Map\n"
        let nameI = NSMutableAttributedString(string: name4b)
        nameI.addAttributes(green, range: NSRange(location: 0, length: name4b.count + 1))
        creditsTextView.textStorage?.append(nameI)
    
        let nameBL = "\n🫐 StarPlayrX   - BT2.0 Disabler\n"
        let nameP = NSMutableAttributedString(string: nameBL)
        nameP.addAttributes(green, range: NSRange(location: 0, length: nameBL.count + 1))
        creditsTextView.textStorage?.append(nameP)
        
        let name5 = "\n🍒 Czo          - SUVMMFaker\n"
        let nameE = NSMutableAttributedString(string: name5)
        nameE.addAttributes(green, range: NSRange(location: 0, length: name5.count + 1))
        creditsTextView.textStorage?.append(nameE)
        
        let name9 = "\n🍍 Exvision     - HDMI Audio\n"
        let nameL = NSMutableAttributedString(string: name9)
        nameL.addAttributes(green, range: NSRange(location: 0, length: name9.count + 1))
        creditsTextView.textStorage?.append(nameL)
        
        let name10 = "\n🍉 StarPlayrX   - Snapshot Delete\n"
        let nameO = NSMutableAttributedString(string: name10)
        nameO.addAttributes(green, range: NSRange(location: 0, length: name10.count + 1))
        creditsTextView.textStorage?.append(nameO)
        
        let sep3 = "—————————————————————————————–––––––––\n"
        let separate3 = NSMutableAttributedString(string: sep3)
        separate3.addAttributes(orange, range: NSRange(location: 0, length: sep3.count))
        creditsTextView.textStorage?.append(separate3)

    }
}
