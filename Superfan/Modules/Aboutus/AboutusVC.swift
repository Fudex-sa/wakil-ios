//
//  AboutusVC.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AboutusVC: BaseController {
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var faceBtn: UIButton!
    @IBOutlet weak var instaBtn: UIButton!
    @IBOutlet weak var linkinBtn: UIButton!
    @IBOutlet weak var aboutLbl: UILabel!
    var viewModel: AboutusViewModel?
    var coordinator: AboutusCoordinator?
}

// MARK: - ...  LifeCycle
extension AboutusVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.setting.listen(on: { [weak self] value in
            self?.reload()
        })
    }
}
// MARK: - ...  Functions
extension AboutusVC {
    func setup() {
        startLoading()
        viewModel?.fetchsetting()
        twitterBtn.publisher.listen(on: {[weak self] _ in
            Common().openUrl(text: self?.viewModel?.setting.value?.twitter_link ?? "")
        }).store(self)
        faceBtn.publisher.listen(on: {[weak self] _ in
            Common().openUrl(text: self?.viewModel?.setting.value?.faceBook_link ?? "")
        }).store(self)
        instaBtn.publisher.listen(on: {[weak self] _ in
            Common().openUrl(text: self?.viewModel?.setting.value?.instagram_link ?? "")
        }).store(self)
        linkinBtn.publisher.listen(on: {[weak self] _ in
            Common().openUrl(text: self?.viewModel?.setting.value?.linkedIn_link ?? "")
        }).store(self)
    }
    func reload(){
        stopLoading()
        aboutLbl.text = viewModel?.setting.value?.about_us?.htmlToString ?? ""

    }
}
// MARK: - ...  View Contract
extension AboutusVC {
}
