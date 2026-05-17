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
            return  UIFont.init(name: FontFamily.italic.rawValue, size: size) ?? UIFont.systemFont(ofSize: size , weight: .light)
        }
        static func regularFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: FontFamily.regular.rawValue, size: size) ?? UIFont.systemFont(ofSize: size , weight: .regular)
        }
        static func mediumFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: FontFamily.medium.rawValue, size: size) ??  UIFont.systemFont(ofSize: size  , weight: .medium)
        }
        static func boldFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: FontFamily.bold.rawValue, size: size) ??   UIFont.systemFont(ofSize: size , weight: .bold)
        }
        static func mainFont() -> UIFont {
            return UIFont.systemFont(ofSize: 17)
        }
        static func registerFontsToSystem() {
            let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
            fonts?.forEach({ url in
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            })
        }
    }
}
