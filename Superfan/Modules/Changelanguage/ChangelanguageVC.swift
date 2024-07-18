//
//  ChangelanguageVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ChangelanguageVC: BaseController {
    @IBOutlet weak var englishBtn: RadioButton!
    @IBOutlet weak var arabicBtn: RadioButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arabicView: UIView!
    var viewModel: ChangelanguageViewModel?
    var coordinator: ChangelanguageCoordinator?
    var lang = ""
}

// MARK: - ...  LifeCycle
extension ChangelanguageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension ChangelanguageVC {
    func setup() {
        changeColoe()
        if Localizer.current == .arabic {
            arabicBtn.select()
            englishBtn.deselect()
            lang = "ar"
        }else {
            englishBtn.select()
            arabicBtn.deselect()
            lang = "en"
        }
        arabicView.publisherGesture.listen(on: {[weak self] _ in
            self?.arabicBtn.select()
            self?.englishBtn.deselect()
            self?.lang = "ar"
        }).store(self)
        
        englishView.publisherGesture.listen(on: {[weak self] _ in
            self?.englishBtn.select()
            self?.arabicBtn.deselect()
            self?.lang = "en"
        }).store(self)
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.lang == "ar"{
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }else {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                    //Localizer.initLang()
                }
            }
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            saveBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
}
// MARK: - ...  View Contract
extension ChangelanguageVC {
}
