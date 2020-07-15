//
//  VerificationViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IVerificationViewController: class {
	var router: IVerificationRouter? { get set }
}

class VerificationViewController: UIViewController {
	var interactor: IVerificationInteractor?
	var router: IVerificationRouter?

    @IBOutlet weak var firstNUM: UITextField!
    
    
    @IBOutlet weak var secondNUM: UITextField!
    
    @IBOutlet weak var thirdNum: UITextField!
    
    @IBOutlet weak var furthNUM: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
    
    func setUpView()
    {
        firstNUM.layer.borderWidth = 2.0
        firstNUM.layer.borderColor = UIColor.white.cgColor
        secondNUM.layer.borderWidth = 2.0
        secondNUM.layer.borderColor = UIColor.white.cgColor
        thirdNum.layer.borderWidth = 2.0
        thirdNum.layer.borderColor = UIColor.white.cgColor
        furthNUM.layer.borderWidth = 2.0
        furthNUM.layer.borderColor = UIColor.white.cgColor
    }
    
}

extension VerificationViewController: IVerificationViewController {
	// do someting...
}

extension VerificationViewController {
	// do someting...
}

extension VerificationViewController {
	// do someting...
}
