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

    var userDefualts = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
//        if userDefualts.bool(forKey: "login") == true{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            print("log in true")
//            self.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
//        }
//        }
//        else{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigate(type: .modal, module: GeneralRouterRoute.aboutUs, completion: nil)}
    
////        self.navigate(type: .modal, module: GeneralRouterRoute.aboutUs, completion: nil)
////            self.navigate(type: .modal, module: GeneralRouterRoute.requestDetails, completion: nil)
//            }
//        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

