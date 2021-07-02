//
//  ViewController.swift
//  bigmac2
//
//  Created by starplayrx on 12/18/20.
//

import Cocoa

class ViewController: NSViewController, URLSessionDelegate {
    
    var downloadProgress = Float(-1.0)
    var downloadDataProgress = Float(-1.0)

    //MARK: Downloads Tab
    @IBAction func installerVersionAction(_ sender: Any) {
        installVersionIsLegacy = installerVersion.title.lowercased().contains(installLegacyVersion.lowercased()) ? true : false
        let defaults = UserDefaults.standard
        defaults.set(installVersionIsLegacy, forKey: "installVersionIsLegacy")
    }
    
    @IBOutlet weak var installerVersion: NSPopUpButton!
    @IBOutlet weak var mediaLabel: NSTextField!
    @IBOutlet weak var progressBarDownload: NSProgressIndicator!
    @IBOutlet weak var buildLabel: NSTextField!
    @IBOutlet weak var gbLabel: NSTextField!
    @IBOutlet weak var percentageLabel: NSTextField!
    @IBOutlet weak var createInstallSpinner: NSProgressIndicator!
    @IBOutlet weak var installerFuelGauge: NSLevelIndicator!
    @IBOutlet weak var sharedSupportProgressBar: NSProgressIndicator!
    @IBOutlet weak var downloadLabel: NSTextField!
    @IBOutlet weak var sharedSupportPercentage: NSTextField!
    @IBOutlet weak var sharedSupportGbLabel: NSTextField!
    @IBOutlet weak var singleUserCheckbox: NSButton!
    @IBOutlet weak var verboseUserCheckbox: NSButton!
    @IBOutlet weak var apfsRomPatcher: NSButton!
    @IBOutlet weak var useDmgInstaller: NSButton!
   
    @IBOutlet weak var cleanInstallViaDmg: NSButton!
    @IBOutlet weak var upgradeViaDmg: NSButton!
    
    @IBAction func donateAction(_ sender: Any) {
        donate2BigMac()
    }
    
    
    //MARK: Preinstall Tab -- Outlets
    @IBOutlet weak var DisableLibraryValidation: NSButton!
    @IBOutlet weak var DisableSIP: NSButton!
    @IBOutlet weak var DisableAuthRoot: NSButton!
    @IBOutlet weak var DisableGateKeeper: NSButton!
    @IBOutlet weak var preInstallSpinner: NSProgressIndicator!
    @IBOutlet weak var verboseGlobalBootArgs: NSButton!
    @IBOutlet weak var amfiGlobalBootArgs: NSButton!
    @IBOutlet weak var nccGlobalBootArgs: NSButton!
    @IBOutlet weak var suGlobalBootArgs: NSButton!
    
    //MARK: Tab Views
    @IBOutlet weak var downloadsTab: NSTabViewItem!
    @IBOutlet weak var preInstallTab: NSTabViewItem!
    @IBOutlet weak var postInstallTab: NSTabViewItem!    
    @IBOutlet weak var preInstaLaunchBtn: NSButton!
    
    //MARK: Screen Res Switching
    @IBOutlet weak var LowRes_720: NSButton!
    @IBOutlet weak var LowRes_1080: NSButton!
    @IBOutlet weak var HiRes_720: NSButton!
    @IBOutlet weak var HiRes_1080: NSButton!
    
    //MARK: Postinstall Tab
    @IBOutlet weak var enableUSB_btn: NSButton!
    @IBOutlet weak var disableBT2_btn: NSButton!
    @IBOutlet weak var amdMouSSE_btn: NSButton!
    @IBOutlet weak var teleTrap_btn: NSButton!
    @IBOutlet weak var VerboseBoot_btn: NSButton!
    @IBOutlet weak var superDrive_btn: NSButton!
    @IBOutlet weak var appleHDA_btn: NSButton!
    @IBOutlet weak var hdmiAudio_btn: NSButton!
    @IBOutlet weak var appStoreMacOS_btn: NSButton!
    @IBOutlet weak var legacyWiFi_btn: NSButton!
    @IBOutlet weak var singleUser_btn: NSButton!
    @IBOutlet weak var deleteAPFSSnapshotsButton: NSButton!
    @IBOutlet weak var BlessVolume: NSButton!
    @IBOutlet weak var postInstallFuelGauge: NSLevelIndicator!
    @IBOutlet weak var postInstallProgressIndicator: NSProgressIndicator!
    @IBOutlet weak var availablePatchDisks: NSPopUpButton!
    @IBOutlet weak var patchDiskExecution_btn: NSButton!
    @IBOutlet weak var postInstallTask_label: NSTextField!
    @IBOutlet weak var postInstallDetails_label: NSTextField!
    @IBOutlet weak var postInstallSpinner: NSProgressIndicator!
    @IBOutlet weak var updateBootSysKCs: NSButton!
    @IBOutlet weak var patchDisk_btn: NSButton!
    
    let fm = FileManager.default
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        installVersionIsLegacy = defaults.bool(forKey: "installVersionIsLegacy")

        installerVersion.removeAllItems()
        installerVersion.addItem(withTitle: installLegacyVersion)
        installerVersion.addItem(withTitle: installmacOS12Version)

        if installVersionIsLegacy {
            installerVersion.setTitle(installLegacyVersion)
        } else {
            installerVersion.setTitle(installmacOS12Version)
        }
        
        bootedToBaseOS = checkForBaseOS()
        refreshPatchDisks()
        bigMacDataPatchDMG()
    }
    
    override public func mouseDown(with event: NSEvent) {
        self.view.window?.performDrag(with: event)
    }
}

//No need for this yet (this can probably be removed when its decoupled from the main storyboard
class TabView : NSTabView {
    override func awakeFromNib() {
    }
}


