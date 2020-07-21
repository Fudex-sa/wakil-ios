//
//  ViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.navigate(type: .modal, module: GeneralRouterRoute.suppilerSecond(id: 9), completion: nil)
//            self.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
        self.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
//            self.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
        
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

