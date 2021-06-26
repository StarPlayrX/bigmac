//
//  Vars.swift
//  bigmac2
//
//  Created by starplayrx on 1/6/21.SE
import Foundation

var installVersionIsLegacy = false
var installLegacyVersion = "macOS 11"

//MARK: TO DO -> Clean up
var globalVolumeInfo = myVolumeInfo(diskSlice: "", disk: "", displayName: "", volumeName: "", path: "", uuid: "", external: false, root: false, capacity: 0)
var globalWorkItem : DispatchWorkItem?
var globalDispatch : DispatchQueue?
var globalError    = "Unknown Error"

//MacOS 11.4
var globalDownloadMacOSpkg11 = "http://swcdn.apple.com/content/downloads/55/59/071-00696-A_4T69TQR1VO/9psvjmwyjlucyg708cqjeaiylrvb0xph94/InstallAssistant.pkg"

//Monterey Beta
var globalDownloadMacOSpkg12 = "http://swcdn.apple.com/content/downloads/38/12/071-51840-A_R2JDKNM0LX/wqollynqs6j5006166tvw4rliu9htf7swu/InstallAssistant.pkg"

let macOS11 = "macOS Big Sur"
let macOS12 = "macOS 12 Beta"

let OS11 = "macOS11"
let OS12 = "macOS12"

var globalInstall = install.bootIso

enum install {
    case bootIso
    case bootDmg
    case installDmg
    case upgradeDmg
    case installIso
}

func globalCompletedTask() {
    
    if let _ = globalWorkItem {
        globalWorkItem = nil
    }
    
  
    if let _ = globalDispatch {
        globalDispatch = nil
    }
    
    if globalWorkItem != nil {
        globalWorkItem = nil
    }
    
    if globalDispatch != nil {
        globalDispatch = nil
    }
}

var globalWebsite = "http://starplayrx.com/bigmac2/"

var kmMonitor = false
var volumeInfo = myVolumeInfo(diskSlice: "", disk: "", displayName: "", volumeName: "", path: "", uuid: "", external: false, root: false, capacity: 0)

var http = "http"
var rootMode = false
var root = "root"
var isBaseSingleUser = false
var isBaseVerbose = false
var isSysSingleUser = false
var isSysVerbose = false
var ranHax3 = false
var bootedToBaseOS = false
var enableUSB = false
var disableBT2 = false
var amdMouSSE = false
var teleTrap = true
var VerboseBoot = false
var superDrive = true
var appStoreMacOS = false
var appleHDA = true
var hdmiAudio = false
var singleUser = false
var legacyWiFi = false
var installKCs = true
var blessSystem = true
var deleteSnaphots = true

var enableUSBtl = ""
var disableBT2tl = ""
var amdMouSSEtl = ""
var teleTraptl = ""
var VerboseBoottl = ""
var superDrivetl = ""
var appStoreMacOStl = ""
var appleHDAtl = ""
var hdmiAudiotl = ""
var singleUsertl = ""
var legacyWiFitl = ""
var installKCstl = ""
var blessSystemtl = ""
var deleteSnaphotstl = ""
var bigmacDMG = "bigmac2.dmg"
var bigdataDMG = "bigdata.dmg"
var dosDude1DMG = "dosdude1.dmg"
var bigmac2Str = "bigmac2"
var domain = "www.starplayrx.com"
var tmpFolder = "/tmp/"
var bigDataDMG = "bigdata.dmg"
var bigDataStr = "bigdata"
let setResX = "/Applications/RDM.app/Contents/MacOS/SetResX"

let installAsstBaseOS11 = "/Install \(macOS11).app/Contents/MacOS/InstallAssistant"
let installAsstBaseOS12 = "/Install \(macOS12)/Contents/MacOS/InstallAssistant"

let installAsstFullOS11 = "/Applications/Install \(macOS11).app/Contents/MacOS/InstallAssistant"
let installAsstFullOS12 = "/Applications/Install \(macOS12).app/Contents/MacOS/InstallAssistant"

let installShortOS11 = "/Applications/Install \(macOS11).app"
let installShortOS12 = "/Applications/Install \(macOS12).app"

let sharedSupportOS11 = "/Applications/Install \(macOS11).app/Contents/SharedSupport/SharedSupport.dmg"
let sharedSupportOS12 = "/Applications/Install \(macOS12).app/Contents/SharedSupport/SharedSupport.dmg"

var installOS11 = "Install \(macOS11).app"
var installOS12 = "Install \(macOS12).app"

let tempFolder = "/tmp"
let tmp = "tmp"
let sharedsupport = "SharedSupport"
let bigmac2 = "bigmac2"
let macOS = "macOS"
let tempDiskImage = "bm2tmp0"
let applications = "Applications"
let basesystem = "BaseSystem"
let haxDylib = "HaxDoNotSealNoAPFSROMCheck.dylib"
var bigdata = "bigdata"
let macSoftwareUpdate = "com_apple_MobileAsset_MacSoftwareUpdate"

let wildZip = "*.zip"
let restoreBaseSystem = "AssetData/Restore/BaseSystem.dmg"
var installerVolume = "/Volumes/bigmac2"
let shared = "Shared/" //copy to shared directory
let apfs = "/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util"
var drivX = "/"
let file = "file://"
