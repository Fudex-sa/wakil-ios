//
//  OnboardingVC.swift
//  Wndo
//
//  Created by Adam on 27/07/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class OnboardingVC: BaseController {
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var skipLbl: UILabel!
    @IBOutlet weak var onboardingCollection: UICollectionView!
    var viewModel: OnboardingViewModel?
    var coordinator: OnboardingCoordinator?
    var onboardList: [OnboardingModel] = []
    var page = 0

}

// MARK: - ...  LifeCycle
extension OnboardingVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        UD.onboarding = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension OnboardingVC {
    func setup() {
        onboardList.removeAll()
        onboardList.append(OnboardingModel(id: 1, title: "Explore our features".localized, des: "Get the latest news and analysis from the world of sports and follow matches and results in real time".localized, image: "Onboarding 1"))
        onboardList.append(OnboardingModel(id: 2, title: "Stay informed".localized, des: "Customize your alerts to receive the latest news and results directly".localized, image: "Onboarding 2"))
        onboardList.append(OnboardingModel(id: 3, title: "Customize your experience".localized, des: "Choose your favorite teams and sports to personalize your content".localized, image: "Onboarding 3"))
        onboardingCollection.delegate = self
        onboardingCollection.dataSource = self
        skipLbl.UIViewAction {
            UD.onboarding = true
            if UD.user == nil {
                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
            }else {
                Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
            }
        }
        langView.publisherGesture.listen(on: {[weak self] _ in
            if self?.langLbl.text == "AR".localized {
                Localizer.instance.language.send(.arabic)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.onboardingStoryboard())}
            }else {
                Localizer.instance.language.send(.english)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                    Coordinator.instance.restart(storyboard: R.storyboard.onboardingStoryboard())}
            }
            
        }).store(self)
    }
    func next(page:Int){
        self.page = page
        if self.page == 3 {
            UD.onboarding = true
            if UD.user == nil {
                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
            }else {
                Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
            }
            return
        }
        let indexPath = IndexPath(item: self.page, section: 0)
        self.onboardingCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
// MARK: - ...  View Contract
extension OnboardingVC {
}
extension OnboardingVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return onboardList.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: OnboardingCollectionViewCell.self, indexPath)
                cell.model = onboardList[safe: indexPath.row]
            cell.delegate = self
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 0
    }
  }


extension OnboardingVC:OnboardingCollectionViewCellDelegate{
    func next(wasPressedOnCell cell: OnboardingCollectionViewCell, Onboarding: OnboardingModel) {
        self.next(page: Onboarding.id)
    }
    
    
}
