//
//  Theme.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/27/20.
//

import Foundation
import UIKit
struct ThemeApp {
    struct Fonts {
        static func lightFont(size: CGFloat) -> UIFont {
            return  UIFont.init(name: "Expo-Arabic-Light", size: size) ?? UIFont.systemFont(ofSize: size , weight: .light)
        }
        static func regularFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "Expo-Arabic-Book", size: size) ?? UIFont.systemFont(ofSize: size , weight: .regular)
        }
        static func mediumFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "Expo-Arabic-Medium", size: size) ??  UIFont.systemFont(ofSize: size  , weight: .medium)
        }
        static func boldFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "Expo-Arabic-Bold", size: size) ??   UIFont.systemFont(ofSize: size , weight: .bold)
        }
        static func mainFont() -> UIFont {
            return UIFont.systemFont(ofSize: 17)
        }
    }
}
