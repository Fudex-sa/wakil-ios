//
//  SettingsVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SettingsVC: BaseController {
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var languageLbl: UILabel!
    var viewModel: SettingsViewModel?
    var coordinator: SettingsCoordinator?
}

// MARK: - ...  LifeCycle
extension SettingsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension SettingsVC {
    func setup() {
        if Localizer.current == .arabic {
            flagImg.image = R.image.flag()
        }else {
            flagImg.image = R.image.flag1()
        }
        flagImg.UIViewAction {
            if Localizer.current == .arabic {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }else {
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }
        }
        languageLbl.UIViewAction {
            if Localizer.current == .arabic {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }else {
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }
        }
    }
}
// MARK: - ...  View Contract
extension SettingsVC {
}
