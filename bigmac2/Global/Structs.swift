//
//  Structs.swift
//  bigmac2
//
//  Created by starplayrx on 1/4/21.
//
import Foundation

//MARK: - VolumeInfo
struct myVolumeInfo {
    var diskSlice, disk, displayName, volumeName, path, uuid: String
    var external, root: Bool
    var capacity: Int
}

// MARK: - Snapshots
struct Snapshots: Codable {
    let snapshots: [Snapshot]

    enum CodingKeys: String, CodingKey {
        case snapshots = "Snapshots"
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
    let limitingContainerShrink, purgeable: Bool
    let snapshotName, snapshotUUID: String
    let snapshotXID: Int

    enum CodingKeys: String, CodingKey {
        case limitingContainerShrink = "LimitingContainerShrink"
        case purgeable = "Purgeable"
        case snapshotName = "SnapshotName"
        case snapshotUUID = "SnapshotUUID"
        case snapshotXID = "SnapshotXID"
    }
}

// MARK: - System Info code
struct systemInfoCodable: Codable {
    let productVersion, productBuildVersion, productCopyright, productName: String
    let iOSSupportVersion, productUserVisibleVersion: String
    
    enum CodingKeys: String, CodingKey {
        case productVersion = "ProductVersion"
        case productBuildVersion = "ProductBuildVersion"
        case productCopyright = "ProductCopyright"
        case productName = "ProductName"
        case iOSSupportVersion
        case productUserVisibleVersion = "ProductUserVisibleVersion"
    }
}
