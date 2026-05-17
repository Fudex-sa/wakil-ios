//
//  Splashscreen.swift
//  Superfan
//
//  Created by ADAM on 21/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
class Splashscreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let delayInSeconds = 3.0 // Adjust this value to increase or decrease the delay
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            self.proceedToMainScreen()
        }
    }
    
    func proceedToMainScreen() {
        self.performSegue(withIdentifier: "showMainScreen", sender: self)
    }
}
