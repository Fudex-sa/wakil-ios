//
//  Constants.swift
//
//  Created by mohamed abdo on 4/21/18.
//
import UIKit

struct Constants {
    static let itunesURL = "itms-apps://itunes.apple.com/app/id1330387425"
    static var isconnet = true
    static let FCMTYPE = "ios"
    static var iscompletedata = true
    static let FCMTOKEN: String = {
        return UD.DEVICE_TOKEN ?? "nil"
    }()
    static let DEVICEID = UIDevice.current.identifierForVendor!.uuidString
    static var index = 0

}
