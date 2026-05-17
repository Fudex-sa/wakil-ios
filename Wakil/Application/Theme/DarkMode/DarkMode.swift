//
//  DarkMode.swift
//  Wndo
//
//  Created by Mabdu on 01/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
extension ThemeApp {
    enum Mode: String {
        case light = "light"
        case dark = "dark"
        func apply() {
            guard let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            if #available(iOS 13.0, *) {
                switch self {
                case .dark:
                    appDelegate.window?.overrideUserInterfaceStyle = .dark
                    break
                case .light:
                    appDelegate.window?.overrideUserInterfaceStyle = .light
                    break
                default:
                    appDelegate.window?.overrideUserInterfaceStyle = .unspecified
                }
            }
        }
    }
    
}
