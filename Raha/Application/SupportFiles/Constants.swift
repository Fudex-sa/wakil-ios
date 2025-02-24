//
//  Constants.swift
//
//  Created by mohamed abdo on 4/21/18.
//
import UIKit

struct Constants {
    static let itunesURL = "itms-apps://itunes.apple.com/app/id6547850254"
    static var isconnet = true
    static let FCMTYPE = "ios"
    static var iscompletedata = true
    static let FCMTOKEN: String = {
        return UD.DEVICE_TOKEN ?? "nil"
    }()
    static let DEVICEID = UIDevice.current.identifierForVendor!.uuidString
    static var index = 0
    
    func addLineSpacingAndAlignment(text: String, lineSpacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = alignment

            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

            return attributedString
        }
        
}
