//
//  uvivewControllerExtension.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 8/26/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit

extension UIViewController{

    func showPopUp(current_popup: UIViewController) {
        let hideView = UIView()
        let popUpView = UIView()
         currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)
       hideView.frame = self.view.frame
        hideView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let hideBtn = UIButton()
        hideBtn.frame = CGRect(x: 0, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
        hideView.addSubview(hideBtn)
        hideBtn.addTarget(self, action: #selector(hideBtnTapped), for: .touchUpInside)
        popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
        hideView.addSubview(popUpView)
        currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)
        let vc = currentPopUpVC
        addChild(vc!)
        vc!.view.frame = popUpView.bounds
        popUpView.addSubview(vc!.view)
        vc!.didMove(toParent: self)
        self.view.addSubview(hideView)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
           
            self.popUpView.frame = CGRect(x: self.view.frame.minX , y: 0, width: self.view.frame.width - 80, height: self.view.frame.height)
            
            self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = self.popUpView.frame.origin.x + 250
           
        })
    }
    @objc func hideBtnTapped(sender: UIButton!) {
        hidePopUps()
    }
    func hidePopUps() {
        let previousVC = currentPopUpVC
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
           
            self.popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 100, height: self.view.frame.height)
            self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = 0
        }, completion: { _ in
            previousVC!.willMove(toParent: nil)
            previousVC!.view.removeFromSuperview()
            previousVC!.removeFromParent()
            self.hideView.removeFromSuperview()
           
        })
    }
}
