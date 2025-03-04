//
//  CustomTabBarController.swift
//  Massaser
//
//  Created by M.abdu on 8/31/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit
class CustomTabBarController: UITabBarController {
    var customTabBar: CustomTabBarView!
    var lastControllerSelected: Int = 0
    var tabBarHeight: CGFloat {
        get {
            if UIApplication.hasTopNotch {
                return 80
            } else {
                return 80
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar()
        self.selectedIndex = Constants.index

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customTabBar.selectedIndex = self.selectedIndex
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func setcurrntindex(index: Int){
        if index == 0 {
            self.customTabBar.homeBackgroundView.backgroundColor = R.color.lightblue()
            self.customTabBar.homeImg.tintColor = R.color.normalblue()
            self.customTabBar.homeLbl.textColor = R.color.normalblue()
            self.customTabBar.bookingBackgroundView.backgroundColor = .clear
            self.customTabBar.bookingImg.tintColor = R.color.normalblue()
            self.customTabBar.bookingLbl.textColor = R.color.normalblue()
            self.customTabBar.moreBackgroundView.backgroundColor = .clear
            self.customTabBar.moreImg.tintColor = R.color.darkgray2()
            self.customTabBar.moreLbl.textColor = R.color.darkgray2()
        }
    }
    func loadTabBar() {
        tabBar.isHidden = true
        self.customTabBar = CustomTabBarView(frame: CGRect(x: 0, y: 0, width: tabBar.width, height: tabBarHeight))
        self.customTabBar.backgroundColor = .clear
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.tabBar = tabBar
        self.customTabBar.onDidClickItem = { [weak self] index in
            self?.selectedIndex = index
            if let tabBar = self?.tabBar, let item = self?.tabBar.items?[index] {
                self?.tabBar(tabBar, didSelect: item)
            }
        }
        self.view.addSubview(customTabBar)
        
        var bottomConstraint: NSLayoutConstraint
        bottomConstraint = self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: view.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // Fixed height for nav menu
            bottomConstraint
        ])
        
        self.view.layoutIfNeeded() // important step
    }
    func showTabBar() {
        self.customTabBar.isHidden = false
    }
    func hideTabBar() {
        self.customTabBar.isHidden = true
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        self.customTabBar.selectedIndex = selectedIndex
        
        let navController = self.viewControllers?[selectedIndex] as? UINavigationController

           if selectedIndex == 0 {
                guard let scene = R.storyboard.homeStoryboard.homeVC() else { return }
                (self.viewControllers?[0] as? UINavigationController)?.viewControllers = [scene]
            } else if selectedIndex == 1 {
                guard let scene =  R.storyboard.reservationStoryboard.reservationVC() else { return }
                (self.viewControllers?[1] as? UINavigationController)?.viewControllers = [scene]
            } else if selectedIndex == 2 {
                guard let scene = R.storyboard.moreStoryboard.moreVC() else { return }
                (self.viewControllers?[2] as? UINavigationController)?.viewControllers = [scene]
            }
        
        
        
        navController?.popToRootViewController(animated: false)
       
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}

extension UITabBarController {
    var currentIndex: Int {
        set {
            self.selectedIndex = newValue
            if let item = tabBar.items?[safe: newValue] {
                self.tabBar(self.tabBar, didSelect: item)
            }
        } get {
            return self.selectedIndex
        }
    }
}

