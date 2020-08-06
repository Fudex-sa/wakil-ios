//
//  container.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/6/20.
//  Copyright © 2020 Fudex. All rights reserved.
//



import Foundation
import UIKit

protocol SocialControllerDelegate {
    func handleMenuToggle()
}

class ContainerController: UIViewController {
    
    //MARK: - Properties
    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSocialController()
    }
    
    //MARK: - Handlers
    
    func configureSocialController() {
        print("inside configurationr")
        let socialController = aboutUsViewController()
        socialController.delegate = self
        centerController = UINavigationController(rootViewController: socialController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
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

extension ContainerController: SocialControllerDelegate {
    func handleMenuToggle() {
        print("inside Container")
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
}
