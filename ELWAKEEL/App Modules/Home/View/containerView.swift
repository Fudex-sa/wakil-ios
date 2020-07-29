//
//  containerView.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright © 2020 Fudex. All rights reserved.
//


//

import Foundation
import UIKit

protocol HomeDelegate: class{
    func handleMenuToggle()
}

class HomeContainerController: UIViewController {
    
    //MARK: - Properties
    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    //MARK: - Init
//    var sender: HomeViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hamada")
        configureHomeController()
        print("hamada2")
        
    }
    
    //MARK: - Handlers
    
    func configureHomeController() {
        
        print("config")
        let HomeController = HomeViewController()
        HomeController.delegate = self
        centerController = HomeController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        print("inside configuration")
        if menuController == nil {
            menuController = sideMenuViewController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                self.tabBarController?.tabBar.isHidden = true
            }, completion: nil)
        } else {
            //hide menu
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                self.tabBarController?.tabBar.isHidden = false
            }, completion: nil)
        }
    }
}

extension HomeContainerController: HomeDelegate {
    func handleMenuToggle() {
        print("inside toggle")
        if !isExpanded {
            print("inside if")
            configureMenuController()
            print("inside if")
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
        
    }
}




