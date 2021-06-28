//
//  Vars.swift
//  bigmac2
//
//  Created by starplayrx on 1/6/21.SE
import Foundation

var installVersionIsLegacy = true

//Menu items
var installLegacyVersion = "macOS 11.4"
var installmacOS12Version = "macOS 12.0 Beta"

//MacOS 11.4 Download
var globalDownloadMacOSpkg11 = "http://swcdn.apple.com/content/downloads/55/59/071-00696-A_4T69TQR1VO/9psvjmwyjlucyg708cqjeaiylrvb0xph94/InstallAssistant.pkg"

//Monterey 12.0 Beta Download
var globalDownloadMacOSpkg12 = "http://swcdn.apple.com/content/downloads/38/12/071-51840-A_R2JDKNM0LX/wqollynqs6j5006166tvw4rliu9htf7swu/InstallAssistant.pkg"

//Application names
let macOS11 = "macOS Big Sur"
let macOS12 = "macOS 12 Beta"

//short OS names
let OS11 = "macOS11"
let OS12 = "macOS12"

var globalVolumeInfo = myVolumeInfo(diskSlice: "", disk: "", displayName: "", volumeName: "", path: "", uuid: "", external: false, root: false, capacity: 0)
var globalWorkItem : DispatchWorkItem?
var globalDispatch : DispatchQueue?
var globalError    = "Unknown Error"
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
var https = "https"
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
let setResX = "/Applications/CloneToolX.app/Contents/MacOS/CloneToolX"

var installOS11 = "Install \(macOS11).app"
var installOS12 = "Install \(macOS12).app"

let installAsstBaseOS11 = "\(installOS11)/Contents/MacOS/InstallAssistant"
let installAsstBaseOS12 = "\(installOS12)/Contents/MacOS/InstallAssistant"

let installAsstFullOS11 = "/Applications/\(installAsstBaseOS11)"
let installAsstFullOS12 = "/Applications/\(installAsstBaseOS12)"

let installShortOS11 = "/Applications/\(installOS11)"
let installShortOS12 = "/Applications/\(installOS12)"

let sharedSupportOS11 = "\(installShortOS11)/Contents/SharedSupport/SharedSupport.dmg"
let sharedSupportOS12 = "\(installShortOS12)/Contents/SharedSupport/SharedSupport.dmg"

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
