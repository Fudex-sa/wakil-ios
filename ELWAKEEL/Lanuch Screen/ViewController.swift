//
//  ViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import UIKit
import LocalizationFramework
import Network

class ViewController: UIViewController {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    var userDefualts = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
     
        monitor.pathUpdateHandler = { pathUpdateHandler in
                if pathUpdateHandler.status == .satisfied {
                    print("Internet connection is on.")
                } else {
                    print("There's no internet connection.")
                }
            print("ciiciicic")

            self.monitor.start(queue: self.queue)
        }
        if userDefualts.bool(forKey: "login") == true{
            if userDefualts.string(forKey: "type") == "provider"{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
                
            }
            }
                
               else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
                
                    }
        }
        }
        else{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)}
        }
    

    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

//class ViewController: UIViewController {
//
//    let monitor = NWPathMonitor()
//    let queue = DispatchQueue(label: "InternetConnectionMonitor")
//
//    override func viewDidLoad() {
//        monitor.pathUpdateHandler = { pathUpdateHandler in
//            if pathUpdateHandler.status == .satisfied {
//                print("Internet connection is on.")
//            } else {
//                print("There's no internet connection.")
//            }
//        }
//
//        monitor.start(queue: queue)
//    }
//
//}
