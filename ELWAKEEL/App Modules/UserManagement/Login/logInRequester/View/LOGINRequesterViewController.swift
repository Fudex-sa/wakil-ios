//
//  LOGINRequesterViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRequesterViewController: class {
	var router: ILOGINRequesterRouter? { get set }
}

class LOGINRequesterViewController: UIViewController {
	var interactor: ILOGINRequesterInteractor?
	var router: ILOGINRequesterRouter?

    @IBOutlet weak var logInBTN: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        testGradientButton()
        
}
    
    func testGradientButton() -> Void {
        let gradientColor = CAGradientLayer()
        gradientColor.frame = logInBTN.frame
        gradientColor.colors = [UIColor.blue.cgColor,UIColor.red.withAlphaComponent(1).cgColor]
        self.logInBTN.layer.insertSublayer(gradientColor, at: 0)
    }

}
extension LOGINRequesterViewController: ILOGINRequesterViewController {
	// do someting...
}

extension LOGINRequesterViewController {
	// do someting...
}

extension LOGINRequesterViewController {
	// do someting...
}
