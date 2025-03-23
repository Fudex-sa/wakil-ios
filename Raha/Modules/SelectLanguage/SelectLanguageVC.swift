//
//  SelectLanguageVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SelectLanguageVC: BaseController {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var englishRadio: RadioButton!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var arabicRadio: RadioButton!
    @IBOutlet weak var arabicView: UIView!
    var viewModel: SelectLanguageViewModel?
    var coordinator: SelectLanguageCoordinator?
    var type = 1
}

// MARK: - ...  LifeCycle
extension SelectLanguageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension SelectLanguageVC {
    func setup() {
        if Localizer.current == .english {
            type = 1
            englishView.backgroundColor = R.color.lightblue()
            englishRadio.select()
            arabicView.backgroundColor = R.color.whiteColor()
            arabicRadio.deselect()
        }else {
            type = 2
            arabicView.backgroundColor = R.color.lightblue()
            arabicRadio.select()
            englishView.backgroundColor = R.color.whiteColor()
            englishRadio.deselect()
        }
        arabicView.publisherGesture.listen(on: {[weak self] _ in
            self?.arabicView.backgroundColor = R.color.lightblue()
            self?.arabicRadio.select()
            self?.englishView.backgroundColor = R.color.whiteColor()
            self?.englishRadio.deselect()
            self?.type = 2
        }).store(self)
        englishView.publisherGesture.listen(on: {[weak self] _ in
            self?.englishView.backgroundColor = R.color.lightblue()
            self?.englishRadio.select()
            self?.arabicView.backgroundColor = R.color.whiteColor()
            self?.arabicRadio.deselect()
            self?.type = 1
        }).store(self)
        doneBtn.publisher.listen(on: {[weak self] _ in
            if self?.type == 1 {
                self?.dismiss(animated: true, completion: {
                    Localizer.instance.language.send(.english)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                        Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                        //Localizer.initLang()
                    }
                   
                })
               
            }else {
                self?.dismiss(animated: true, completion: {
                    Localizer.instance.language.send(.arabic)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                        Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
                        //Localizer.initLang()
                    }
                   
                })
            }
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension SelectLanguageVC {
}
